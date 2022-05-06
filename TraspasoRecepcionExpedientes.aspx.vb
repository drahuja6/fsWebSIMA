Imports System.Collections.Generic

Imports fsSimaServicios

Public Class TraspasoRecepcionExpedientes
    Inherits Page

#Region "Variables privadas globales a la forma"

    Private _tipoProceso As Integer
    Private _statusExpedientes As Integer
    Private _expedientesSinCaja As String
    Private _expedientesConCaja As String
    Private _tituloListadoExpedientes As String

#End Region

#Region "Métodos de la forma"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Accesorios.CargaDropDownListSql(ddlUnidAdm, Session("UsuarioVirtualConnStringSQL"), "UnidadesAdministrativasDeUnUsuarioReal", "IdParameter", Session("IDUsuarioReal"), "NombreCorto", "idUnidadAdministrativa", -1)

        End If
        _tipoProceso = CInt(Request.QueryString("Proceso"))

        Select Case _tipoProceso
            'Recepción en concentración
            Case 1
                _statusExpedientes = 4
                _expedientesSinCaja = "Batches_SeleccionaExpedientesParaConcentracion"
                _expedientesConCaja = "Batches_SeleccionaExpedientesConCajaProvParaConcentracion"
                _tituloListadoExpedientes = "en concentración."
                lblTitulo.Text = "Recepción de expedientes en archivo de concentración"
                txtCaja.Text = "Conc"
            'Recepción en baja (autoriza baja)
            Case 2
                _statusExpedientes = 7
                _expedientesSinCaja = "Batches_SeleccionaExpedientesParaBaja"
                _expedientesConCaja = "Batches_SeleccionaExpedientesConCajaProvParaBaja"
                _tituloListadoExpedientes = "para baja."
                lblTitulo.Text = "Autorización de expedientes para baja"
                txtCaja.Text = "99999"
            Case Else

        End Select

    End Sub

    Protected Sub BtnBuscaLotes_Click(sender As Object, e As EventArgs) Handles btnBuscaLotes.Click
        ddlBatches.Items.Clear()
        lbExpDelLote.Items.Clear()
        lbExpConCaja.Items.Clear()
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        If ddlUnidAdm.Items.Count = 0 Then
            Return
        End If

        Dim parametros As New Dictionary(Of String, Object) From {
            {"@IdUnidadAdministrativa", CInt(ddlUnidAdm.SelectedValue)},
            {"@IdTipoDeBatch", _tipoProceso}
        }

        Dim clienteSQL As New ClienteSQL()
        Accesorios.CargaDropDownListSql(ddlBatches, Session("UsuarioVirtualConnStringSQL"), "Batches_Pendientes", clienteSQL.CreaParametros(parametros), "Descripcion", "IdBatch", -1)

    End Sub

    Protected Sub BtnTraerLote_Click(sender As Object, e As EventArgs) Handles btnTraerLote.Click
        lbExpDelLote.Items.Clear()
        lbExpConCaja.Items.Clear()
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        If ddlBatches.Items.Count = 0 Then
            Return
        End If

        Accesorios.CargaListBoxSql(lbExpDelLote, Session("UsuarioVirtualConnStringSQL"), _expedientesSinCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
        Accesorios.CargaListBoxSql(lbExpConCaja, Session("UsuarioVirtualConnStringSQL"), _expedientesConCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
    End Sub

    Protected Sub DdlBatches_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlBatches.SelectedIndexChanged
        lbExpDelLote.Items.Clear()
        lbExpConCaja.Items.Clear()
    End Sub

    Protected Sub BtnRevisaExp_Click(sender As Object, e As EventArgs) Handles btnRevisaExp.Click
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        Dim item As ListItem
        For Each item In lbExpDelLote.Items
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

    Protected Sub BtnAsignaCajaConc_Click(sender As Object, e As EventArgs) Handles btnAsignaCaja.Click
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        'Validación para evitar Caja Concentracion en blanco
        If Trim(txtCaja.Text) = "" Then
            lblValidaCaja.Visible = True
            Return
        Else
            lblValidaCaja.Visible = False
        End If

        Dim lista As New Dictionary(Of Integer, String)
        Dim item As ListItem
        For Each item In lbExpDelLote.Items
            If item.Selected Then
                lista.Add(CInt(item.Value), txtCaja.Text)
            End If
        Next

        Dim serviciosExpedientesBatch As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL"))

        serviciosExpedientesBatch.Batches_Relaciones_Update(CInt(ddlBatches.SelectedValue), Accesorios.CreaDataTable(lista))

        If ddlBatches.Items.Count > 0 Then
            Accesorios.CargaListBoxSql(lbExpDelLote, Session("UsuarioVirtualConnStringSQL"), _expedientesSinCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
            Accesorios.CargaListBoxSql(lbExpConCaja, Session("UsuarioVirtualConnStringSQL"), _expedientesConCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
        End If
    End Sub

    Protected Sub DdlUnidAdm_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlUnidAdm.SelectedIndexChanged
        ddlBatches.Items.Clear()
        lbExpDelLote.Items.Clear()
        lbExpConCaja.Items.Clear()
    End Sub

    Protected Sub BtnImprimeResguardo_Click(sender As Object, e As EventArgs) Handles btnImprimeResguardo.Click

        Dim clienteSQL As New ClienteSQL(Session("UsuarioVirtualConnStringSQL"))

        Dim ds As DataSet
        Dim Reporte As New BatchExpedientesTramiteConcentracion

        Try
            lblValidaLoteAtendidoEImpreso.Visible = False

            'Valido que no queden expedientes propuestos para baja
            If lbExpDelLote.Items.Count > 0 Then
                lblValidaLoteAtendido.Visible = True
                Return
            Else
                lblValidaLoteAtendido.Visible = False
            End If

            'Valido que haya expedientes ya dados de baja
            If lbExpConCaja.Items.Count = 0 Then
                lblValidaLoteAtendido.Visible = True
                Return
            Else
                lblValidaLoteAtendido.Visible = False
            End If

            'Debo cambiar el status de los expedientes del batch completo y ademas debo escribir la caja en cada uno de los expedientes
            Dim expedientesServiciosBatch As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL"))
            expedientesServiciosBatch.ExpedientesActualiza_Status(CInt(ddlBatches.SelectedValue), _statusExpedientes)

            ds = clienteSQL.ObtenerRegistrosSql(clienteSQL.CreaParametros("@IdBatch", CInt(ddlBatches.SelectedValue)), "Batches_ListaTraspasoTerminado")

            If ds.Tables.Count > 0 Then
                Reporte.SetDataSource(ds.Tables(0))

                Reporte.SetParameterValue(0, $"Listado de expedientes aceptados {_tituloListadoExpedientes } -  LOTE: {CInt(ddlBatches.SelectedValue)}")
                Reporte.SetParameterValue(1, Globales.LogoCliente)

                Dim guid1 As Guid = Guid.NewGuid
                Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

                Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
                Reporte.Dispose()

                Accesorios.DescargaArchivo(Me.Response, MyFileName, LongitudMaximaArchivoDescarga, "recepcionexpedientes.pdf")

            End If

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub BtnQuitar_Click(sender As Object, e As EventArgs) Handles btnQuitar.Click

        Try
            lblValidaLoteAtendido.Visible = False
            lblValidaLoteAtendidoEImpreso.Visible = False

            Dim lista As New Dictionary(Of Integer, String)
            Dim item As ListItem
            Dim BorreAlgunItem As Boolean
            Do
                BorreAlgunItem = False
                For Each item In lbExpConCaja.Items
                    If item.Selected Then
                        lista.Add(CInt(item.Value), "")
                        lbExpConCaja.Items.Remove(item)
                        BorreAlgunItem = True
                        Exit For
                    End If
                Next
            Loop While BorreAlgunItem

            If lista.Count > 0 Then
                Dim serviciosExpedientesBatch As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL"))
                serviciosExpedientesBatch.Batches_Relaciones_Update(CInt(ddlBatches.SelectedValue), Accesorios.CreaDataTable(lista))

                Accesorios.CargaListBoxSql(lbExpDelLote, Session("UsuarioVirtualConnStringSQL"), _expedientesSinCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
                Accesorios.CargaListBoxSql(lbExpConCaja, Session("UsuarioVirtualConnStringSQL"), _expedientesConCaja, "IdBatch", CInt(ddlBatches.SelectedValue), "Expediente", "idExpediente")
            End If

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub BtnFinalizarLote_Click(sender As Object, e As EventArgs) Handles btnFinalizarLote.Click
        lblValidaLoteAtendido.Visible = False

        'Compruebo que no queden expedientes en el lote sin tener caja asignada
        If lbExpDelLote.Items.Count > 0 Then
            lblValidaLoteAtendidoEImpreso.Visible = True
            Return
        Else
            lblValidaLoteAtendidoEImpreso.Visible = False
        End If

        'Compruebo que al menos hay un expediente con caja asignada
        If lbExpConCaja.Items.Count = 0 Then
            lblValidaLoteAtendidoEImpreso.Visible = True
            Return
        Else
            lblValidaLoteAtendidoEImpreso.Visible = False
        End If

        'Compruebo que todos los expedientes del lote tienen estatus 4 (Vigentes en Concentracion)
        Dim exbs As New ExpedientesBatchServicios(Session("UsuarioVirtualConnStringSQL"))
        If exbs.Batch_VerificaEstatusExpediente(ddlBatches.SelectedValue, _statusExpedientes) Then

            'Borre el lote y su detalle a los que están vinculados expedientes.
            exbs.Batches_Delete(ddlBatches.SelectedValue)

            ddlBatches.Items.Clear()
            lbExpDelLote.Items.Clear()
            lbExpConCaja.Items.Clear()
            lblValidaLoteAtendido.Visible = False
            lblValidaLoteAtendidoEImpreso.Visible = False

            If ddlUnidAdm.Items.Count = 0 Then
                Return
            End If

            Dim parametros As New Dictionary(Of String, Object) From {
                {"@IdUnidadAdministrativa", CInt(ddlUnidAdm.SelectedValue)},
                {"@IdTipoDeBatch", _tipoProceso}
            }

            Dim clienteSQL As New ClienteSQL()
            Accesorios.CargaDropDownListSql(ddlBatches, Session("UsuarioVirtualConnStringSQL"), "Batches_Pendientes", clienteSQL.CreaParametros(parametros), "Descripcion", "IdBatch", -1)

        End If
    End Sub

#End Region

End Class
