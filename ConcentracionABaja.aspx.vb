Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Globalization

Imports fsSimaServicios

Public Class ConcentracionABaja
    Inherits Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsCallback Then
            Accesorios.CargaDropDownListSql(ddlUnidAdm, Session("UsuarioVirtualConnStringSQL"), "UnidadesAdministrativasDeUnUsuarioReal", "IdParameter", Session("IDUsuarioReal"), "NombreCorto", "idUnidadAdministrativa", -1)
            txtFechaDeCorte.Text = Format(Now.Date, "dd/MM/yyyy")
            txtCajaProv.Text = "CajaTemp"
        End If
    End Sub

    Protected Sub BtnBuscaVencidos_Click(sender As Object, e As EventArgs) Handles btnBuscaVencidos.Click
        If Page.IsValid Then
            Dim parametros(1) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
            Accesorios.CargaListBoxSql(lbExpVencEnConc, Session("UsuarioVirtualConnStringSQL"), "SelVencEnConc", parametros, "Expediente", "idExpediente")
        End If
    End Sub

    Protected Sub BtnImpListado_Click(sender As Object, e As EventArgs) Handles btnImpListado.Click
        Dim params(1) As SqlParameter
        Dim ds As DataSet

        Dim Reporte As New ListaExpTramVenc

        Try
            params(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            params(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))

            ds = New ClienteSQL(Session("UsuarioVirtualConnStringSQL").ToString).ObtenerRegistrosSql(params, "SelVencEnConc")

            If ds.Tables.Count > 0 Then

                Reporte.SetDataSource(ds.Tables(0))

                Reporte.SetParameterValue(0, ddlUnidAdm.SelectedItem.Text)
                Reporte.SetParameterValue(1, txtFechaDeCorte.Text)
                Reporte.SetParameterValue(2, "Listado de expedientes de concentración vencidos")

                Dim guid1 As Guid = Guid.NewGuid
                Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

                Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
                Reporte.Dispose()

                Accesorios.DescargaArchivo(Me.Response, MyFileName, LongitudMaximaArchivoDescarga, "listadovencidosconcentracion.pdf")

            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BtnRevisaExp_Click(sender As Object, e As EventArgs) Handles btnRevisaExp.Click
        Dim item As ListItem
        For Each item In lbExpVencEnConc.Items
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

    Protected Sub BtnNuevoBatch_Click(sender As Object, e As EventArgs) Handles btnNuevoBatch.Click
        If Page.IsValid And lbExpVencEnConc.Items.Count > 0 And lbExpConCaja.Items.Count = 0 Then

            Dim expedientesBatchServicios As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL").ToString)
            Dim idNuevoBatch As Integer

            idNuevoBatch = expedientesBatchServicios.Batches_Insert(txtNuevoBatchDesc.Text, CInt(Session("idUsuarioReal")), Now.Date, 2, CInt(ddlUnidAdm.SelectedValue), DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))
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
            For Each item In lbExpVencEnConc.Items
                If item.Selected Then
                    If Not Mid(item.Text, 1, 5) = "*****" Then
                        Dim nitem As New ListItem With {
                            .Value = item.Value,
                            .Text = "[CAJA " & txtCajaProv.Text & "] - " & item.Text
                        }
                        lbExpConCaja.Items.Add(nitem)
                        item.Text = "*****" & item.Text
                        lista.Add(CInt(item.Value), txtCajaProv.Text)

                    End If
                End If
            Next

            expedientesBatchServicios.Batches_Relaciones_Insert(txtNuevoBatchID.Text, Accesorios.CreaDataTable(lista))

            Dim parametros(1) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))

            Accesorios.CargaListBoxSql(lbExpVencEnConc, Session("UsuarioVirtualConnStringSQL"), "SelVencEnConc", parametros, "Expediente", "idExpediente")

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

            ds = New ClienteSQL(Session("UsuarioVirtualConnStringSQL").ToString).ObtenerRegistrosSql(params, "Batches_ListaConcentracionBaja")

            If ds.Tables.Count > 0 Then
                Reporte.SetDataSource(ds.Tables(0))

                Reporte.SetParameterValue(0, "Listado de expedientes enviados a baja -  LOTE: " & txtNuevoBatchID2.Text)
                Reporte.SetParameterValue(1, Globales.LogoCliente)

                Dim guid1 As Guid = Guid.NewGuid
                Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

                Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
                Reporte.Dispose()

                Accesorios.DescargaArchivo(Me.Response, MyFileName, LongitudMaximaArchivoDescarga, "enviadosbaja.pdf")

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
                        expedientesBatchServicios.Batches_Relaciones_Delete(txtNuevoBatchID.Text, item.Value, 2)
                        lbExpConCaja.Items.Remove(item)
                        BorreAlgunItem = True
                        Exit For
                    End If
                Next
            Loop While BorreAlgunItem

            Dim parametros(1) As SqlParameter

            parametros(0) = New SqlParameter("@IdUnidAdm", CInt(ddlUnidAdm.SelectedValue))
            parametros(1) = New SqlParameter("@FechaDeCorte", DateTime.ParseExact(txtFechaDeCorte.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture))

            Accesorios.CargaListBoxSql(lbExpVencEnConc, Session("UsuarioVirtualConnStringSQL"), "SelVencEnConc", parametros, "Expediente", "idExpediente")

        Catch ex As Exception

        End Try
    End Sub
End Class