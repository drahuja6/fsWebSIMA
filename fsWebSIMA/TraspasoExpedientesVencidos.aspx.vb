Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Globalization

Imports fsSimaServicios

Public Class TraspasoExpedientesVencidos
    Inherits Page

#Region "Variables privadas globales a la clase"

    Private _tipoProceso As Integer
    Private _statusAnterior As Integer
    Private _seleccionaVencidos As String
    Private _loteEnviado As String
    Private _tituloProceso As String

#End Region

#Region "Eventos de la forma"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Accesorios.CargaDropDownListSql(ddlUnidAdm, Session("UsuarioVirtualConnStringSQL"), "UnidadesAdministrativasDeUnUsuarioReal", "IdParameter", Session("IDUsuarioReal"), "NombreCorto", "idUnidadAdministrativa", -1)

            txtFechaDeCorte.Text = Format(Now.Date, "dd/MM/yyyy")
            txtCajaProv.Text = "CajaTemp"
            txtExpedientesLocalizados.ReadOnly = True

        End If

        _tipoProceso = CInt(Request.QueryString("Proceso"))

        Select Case _tipoProceso
            Case 1  'Trámite a concentración
                _seleccionaVencidos = "Batch_SeleccionaExpedientesVencidosTramite"
                _tituloProceso = "expedientes vencidos en trámite."
                _loteEnviado = "Batches_ListaTramiteConcentracion"
                _statusAnterior = 2
                lblTitulo.Text = "Traspaso de expedientes de trámite a concentración"
            Case 2  'Concentración a baja
                _seleccionaVencidos = "Batch_SeleccionaExpedientesVencidosConcentracion"
                _tituloProceso = "expedientes vencidos en concentración para baja."
                _loteEnviado = "Batches_ListaConcentracionBaja"
                _statusAnterior = 5
                lblTitulo.Text = "Traspaso de expedientes de concentración a baja"
            Case 3 'Concentración a histórico. 
                _seleccionaVencidos = "Batch_SeleccionaExpedientesVencidosConcentracionHistorico"
                _tituloProceso = "expedientes vencidos en concentración para histórico."
                _loteEnviado = "Batches_ListaConcentracionHistorico"
                _statusAnterior = 5
                _lblTitulo.Text = "Traspaso de expedientes de concentración a histórico"
        End Select

    End Sub

    Protected Sub BtnRevisaExp_Click(sender As Object, e As EventArgs) Handles btnRevisaExp.Click
        Dim item As ListItem
        For Each item In lbExpedientesVencidos.Items
            If item.Selected Then
                Session("IDExpedienteActivo") = item.Value
                Session("ExpedienteStatus") = 0
                Session("MovimientoStatus") = 0
                Session("CuadroClasificacionStatus") = 0
                Session("UsuarioRealStatus") = 0
                Response.Redirect("./DisplayExpediente.aspx")
            End If
        Next
    End Sub

    Protected Sub BtnBuscaVencidos_Click(sender As Object, e As EventArgs) Handles btnBuscaVencidos.Click

        If Page.IsValid Then
            Dim parametros(2) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            parametros(2) = New SqlParameter("Caja", txtCaja.Text)
            Accesorios.CargaListBoxSql(lbExpedientesVencidos, Session("UsuarioVirtualConnStringSQL"), _seleccionaVencidos, parametros, "Expediente", "idExpediente")
            txtExpedientesLocalizados.Text = lbExpedientesVencidos.Items.Count.ToString
        End If
    End Sub

    Protected Sub BtnImpListado_Click(sender As Object, e As EventArgs) Handles btnImpListado.Click

        Dim params(2) As SqlParameter
        Dim ds As DataSet

        Dim Reporte As New ListaExpTramVenc

        Try
            params(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            params(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            params(2) = New SqlParameter("Caja", txtCaja.Text)

            ds = New ClienteSQL(Session("UsuarioVirtualConnStringSQL").ToString).ObtenerRegistrosSql(params, _seleccionaVencidos)

            If ds.Tables.Count > 0 Then

                Reporte.SetDataSource(ds.Tables(0))

                Reporte.SetParameterValue(0, ddlUnidAdm.SelectedItem.Text)
                Reporte.SetParameterValue(1, txtFechaDeCorte.Text)
                Reporte.SetParameterValue(2, $"Listado de {_tituloProceso}.")

                Dim guid1 As Guid = Guid.NewGuid
                Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

                Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
                Reporte.Dispose()

                Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=ExpedientesVencidos.pdf")

            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BtnNuevoBatch_Click(sender As Object, e As EventArgs) Handles btnNuevoBatch.Click

        If Page.IsValid And lbExpedientesVencidos.Items.Count > 0 And lbExpConCaja.Items.Count = 0 Then

            Dim expedientesBatchServicios As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL").ToString)
            Dim idNuevoBatch As Integer

            idNuevoBatch = expedientesBatchServicios.Batches_Insert(txtNuevoBatchDesc.Text, CInt(Session("idUsuarioReal")), Now.Date, _tipoProceso, CInt(ddlUnidAdm.SelectedValue), DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            txtNuevoBatchID.Text = idNuevoBatch
            txtNuevoBatchID2.Text = idNuevoBatch
            txtFechCorteVig.Text = txtFechaDeCorte.Text

        End If

    End Sub

    Protected Sub BtnAsignaCaja_Click(sender As Object, e As EventArgs) Handles btnAsignaCaja.Click

        Dim lista As New Dictionary(Of Integer, String)

        If Page.IsValid Then
            Dim expedientesBatchServicios As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL").ToString)
            Dim item As ListItem
            For Each item In lbExpedientesVencidos.Items
                If item.Selected Then
                    If Not Mid(item.Text, 1, 5) = "*****" Then
                        Dim nitem As New ListItem With {
                            .Value = item.Value,
                            .Text = "[CAJA " & txtCajaProv.Text & "] - " & item.Text
                        }
                        lbExpConCaja.Items.Add(nitem)
                        item.Text = "*****" & item.Text
                        lista.Add(item.Value, txtCajaProv.Text)

                    End If
                End If
            Next

            expedientesBatchServicios.Batches_Relaciones_Insert(txtNuevoBatchID.Text, Accesorios.CreaDataTable(lista))

            Dim parametros(2) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            parametros(2) = New SqlParameter("Caja", txtCaja.Text)

            Accesorios.CargaListBoxSql(lbExpedientesVencidos, Session("UsuarioVirtualConnStringSQL"), _seleccionaVencidos, parametros, "Expediente", "idExpediente")
            txtExpedientesLocalizados.Text = lbExpedientesVencidos.Items.Count.ToString

        End If

    End Sub

    Protected Sub BtnImprimeEnvio_Click(sender As Object, e As EventArgs) Handles btnImprimeEnvio.Click

        Dim params(0) As SqlParameter
        Dim ds As DataSet

        Dim Reporte As New BatchExpedientesTramiteConcentracion

        Try

            If Not IsNumeric(txtNuevoBatchID2.Text) Then
                Return
            End If

            params(0) = New SqlParameter("@IdBatch", CInt(txtNuevoBatchID2.Text))

            ds = New ClienteSQL(Session("UsuarioVirtualConnStringSQL").ToString).ObtenerRegistrosSql(params, _loteEnviado)

            If ds.Tables.Count > 0 Then
                Reporte.SetDataSource(ds.Tables(0))

                Reporte.SetParameterValue(0, $"Listado de expedientes {_tituloProceso} enviados. -  LOTE: {txtNuevoBatchID2.Text}")
                Reporte.SetParameterValue(1, Globales.LogoCliente)

                Dim guid1 As Guid = Guid.NewGuid
                Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

                Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
                Reporte.Dispose()

                Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=ListaEnviados.pdf")

            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BtnQuitar_Click(sender As Object, e As EventArgs) Handles btnQuitar.Click
        Dim BorreAlgunItem As Boolean
        Dim item As ListItem
        Dim expedientesBatchServicios As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL").ToString)

        Try
            Do
                BorreAlgunItem = False
                For Each item In lbExpConCaja.Items
                    If item.Selected Then
                        expedientesBatchServicios.Batches_Relaciones_Delete(txtNuevoBatchID.Text, item.Value, _statusAnterior)
                        lbExpConCaja.Items.Remove(item)
                        BorreAlgunItem = True
                        Exit For
                    End If
                Next
            Loop While BorreAlgunItem

            Dim parametros(2) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            parametros(2) = New SqlParameter("Caja", txtCaja.Text)

            Accesorios.CargaListBoxSql(lbExpedientesVencidos, Session("UsuarioVirtualConnStringSQL"), _seleccionaVencidos, parametros, "Expediente", "idExpediente")
            txtExpedientesLocalizados.Text = lbExpedientesVencidos.Items.Count.ToString

        Catch ex As Exception

        End Try
    End Sub

#End Region

End Class