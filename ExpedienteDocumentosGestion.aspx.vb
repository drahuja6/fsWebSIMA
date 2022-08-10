Imports System.Data.SqlClient
Imports System.IO

Imports fsSimaServicios

Public Class ExpedienteDocumentosGestion
    Inherits Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim idGestion As Integer
        Dim clienteSQL As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))

        If Not Page.IsPostBack Then

            Dim params(6) As SqlParameter

            params(0) = New SqlParameter("@IdExpediente", Session("IdExpedienteActivo"))
            params(1) = New SqlParameter("@Gestion", SqlDbType.NVarChar, 100) With {
                .Direction = ParameterDirection.Output
            }
            params(2) = New SqlParameter("@Asunto", SqlDbType.NVarChar, 4096) With {
                .Direction = ParameterDirection.Output
            }
            params(3) = New SqlParameter("@Titulo", SqlDbType.NVarChar, 4096) With {
                .Direction = ParameterDirection.Output
            }
            params(4) = New SqlParameter("@Observaciones", SqlDbType.NVarChar, 4096) With {
                .Direction = ParameterDirection.Output
            }
            params(5) = New SqlParameter("@CampoAdicional2", SqlDbType.NVarChar, 4096) With {
                .Direction = ParameterDirection.Output
            }
            params(6) = New SqlParameter("@IdGestion", SqlDbType.Int) With {
                .Direction = ParameterDirection.Output
            }
            clienteSQL.EjecutaProcedimientoSql(params, "Gestion_ObtieneGestionExpediente")

            lblGestion.Text = params(1).Value.ToString
            lblAsunto.Text = params(2).Value.ToString
            lblTitulo.Text = params(3).Value.ToString
            lblObservaciones.Text = params(4).Value.ToString
            lblCampoAdicional2.Text = params(5).Value.ToString

            idGestion = Convert.ToInt32(params(6).Value)

            ViewState.Add("Gestion", idGestion)
            ViewState.Add("Seccion", 0)

            Dim params1(0) As SqlParameter
            params1(0) = New SqlParameter("@IdGestion", ViewState("Gestion"))

            Dim ds As DataSet = clienteSQL.ObtenerRegistrosSql(params1, "Gestion_CargaSecciones")
            ds.Tables(0).TableName = "Secciones"

            ddlSeccionesGestion.DataSource = ds
            ddlSeccionesGestion.DataMember = "Secciones"
            ddlSeccionesGestion.DataValueField = "Id"
            ddlSeccionesGestion.DataTextField = "Descripcion"

            ddlSeccionesGestion.DataBind()

        End If

        CargaGrids(ViewState("Seccion"))

    End Sub

    Protected Sub BtnAsigna_Click(sender As Object, e As EventArgs) Handles btnAsigna.Click
        If dgvDocsDisponibles.SelectedRow IsNot Nothing AndAlso dgvDocsAsignados.SelectedRow IsNot Nothing Then
            Dim idGestionDocumentosInstancia As Integer = Convert.ToInt32(dgvDocsAsignados.SelectedValue)
            Dim idExpedientePdfRelaciones As Integer = Convert.ToInt32(dgvDocsDisponibles.SelectedValue)

            Dim sqlCliente As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))
            Dim params(1) As SqlParameter

            params(0) = New SqlParameter("@IdGestionDocumentosInstancia", idGestionDocumentosInstancia)
            params(1) = New SqlParameter("@IdExpedientePdfRelaciones", idExpedientePdfRelaciones)

            sqlCliente.EjecutaProcedimientoSql(params, "Gestion_AsignaDocumento")

            dgvDocsDisponibles.SelectedIndex = -1
            dgvDocsAsignados.SelectedIndex = -1

            CargaGrids(ViewState("Seccion"))

        End If

    End Sub

    Protected Sub BtnDesasigna_Click(sender As Object, e As EventArgs) Handles btnDesasigna.Click
        If dgvDocsAsignados.SelectedRow IsNot Nothing Then
            Dim idGestionDocumentosInstancia As Integer = Convert.ToInt32(dgvDocsAsignados.SelectedValue)
            Dim idExpedientePdfRelaciones As Integer
            Dim registroSeleccionado As Integer = dgvDocsAsignados.SelectedIndex

            idExpedientePdfRelaciones = Convert.ToInt32(dgvDocsAsignados.DataKeys(registroSeleccionado).Item("IdExpedientePdfRelaciones"))

            Dim sqlCliente As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))
            Dim params(1) As SqlParameter

            params(0) = New SqlParameter("@IdGestionDocumentosInstancia", idGestionDocumentosInstancia)
            params(1) = New SqlParameter("@IdExpedientePdfRelaciones", idExpedientePdfRelaciones)

            sqlCliente.EjecutaProcedimientoSql(params, "Gestion_AsignaDocumento")

            dgvDocsDisponibles.SelectedIndex = -1
            dgvDocsAsignados.SelectedIndex = -1

            CargaGrids(ViewState("Seccion"))
        End If
    End Sub

    Protected Sub DgvDocsDisponibles_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dgvDocsDisponibles.SelectedIndexChanged
        If dgvDocsDisponibles.SelectedRow IsNot Nothing Then
            btnAsigna.Enabled = True
        End If
    End Sub

    Protected Sub DgvDocsAsignados_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dgvDocsAsignados.SelectedIndexChanged
        If dgvDocsAsignados.SelectedRow IsNot Nothing Then
            btnDesasigna.Enabled = True
        End If
    End Sub

    Protected Sub DgvDocsAsignados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles dgvDocsAsignados.RowCommand, dgvDocsDisponibles.RowCommand

        Dim gv As GridView = CType(sender, GridView)

        If e.CommandName = "DescargaImagen" Then
            Dim archivo As String = gv.DataKeys(e.CommandArgument).Item("NombreArchivo")

            If Not String.IsNullOrWhiteSpace(archivo) AndAlso archivo <> "&nbsp;" Then
                If Not ImagenNuevaVentana Then
                    'Llamada a dll de accesorios.
                    Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(Path.Combine(DirImagenes, archivo))}")
                Else
                    'Llamada a página extra para mostrar imagen. Necesario activar Pop-Ups en cliente.
                    Dim url As String = $"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(Path.Combine(DirImagenes, archivo))}"
                    ClientScript.RegisterClientScriptBlock(Me.GetType(), "script", "open('" & url & "');", True)
                End If
            End If
        End If
    End Sub

    Protected Sub FiltrarSeccion_IndexChanged(sender As Object, e As EventArgs) Handles ddlSeccionesGestion.SelectedIndexChanged

        Dim dd As DropDownList = CType(sender, DropDownList)

        ViewState("Seccion") = Convert.ToInt32(dd.SelectedValue)
        CargaGrids(ViewState("Seccion"))

    End Sub

    Private Sub CargaGrids(Optional idSeccion As Integer = 0)
        Dim sqlCliente As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))
        Dim ds As DataSet

        Dim params(1) As SqlParameter

        params(0) = New SqlParameter("@IdExpediente", Session("IdExpedienteActivo"))
        params(1) = New SqlParameter("@IdSeccion", idSeccion)

        ds = sqlCliente.ObtenerRegistrosSql(params, "Gestion_DocumentosDisponiblesAsignados")

        If ds IsNot Nothing AndAlso ds.Tables.Count > 0 Then
            ds.Tables(0).TableName = "Disponibles"
            dgvDocsDisponibles.Visible = True

            dgvDocsDisponibles.DataSource = ds
            dgvDocsDisponibles.DataMember = "Disponibles"
            dgvDocsDisponibles.DataKeyNames = {"IdExpedientePDFRelaciones", "NombreArchivo"}
            dgvDocsDisponibles.DataBind()

            ds.Tables(1).TableName = "Asignados"
            dgvDocsAsignados.Visible = True

            dgvDocsAsignados.DataSource = ds
            dgvDocsAsignados.DataMember = "Asignados"
            dgvDocsAsignados.DataKeyNames = {"IdGestionDocumentosInstancia", "IdExpedientePdfRelaciones", "NombreArchivo"}
            dgvDocsAsignados.DataBind()

            Dim posibleDuplicadoCodigo As String = dgvDocsAsignados.Rows(0).Cells(3).Text

            Dim i As Integer
            For i = 1 To dgvDocsAsignados.Rows.Count - 1
                If dgvDocsAsignados.Rows(i).Cells(3).Text = posibleDuplicadoCodigo Then
                    dgvDocsAsignados.Rows(i).Cells(3).Text = ""
                Else
                    posibleDuplicadoCodigo = dgvDocsAsignados.Rows(i).Cells(3).Text
                End If
            Next

        End If
    End Sub

End Class