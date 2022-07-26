Imports System.Data.SqlClient
Imports System.IO
Imports System.Collections.Generic

Imports fsSimaServicios

Public Class ExpedienteDocumentosGestion
    Inherits Page

    Public ListaSecciones As DataTable

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            Dim sqlCliente As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))
            Dim params(1) As SqlParameter

            params(0) = New SqlParameter("@IdExpediente", Session("IdExpedienteActivo"))
            params(1) = New SqlParameter("@Gestion", SqlDbType.NVarChar, 100) With {
                .Direction = ParameterDirection.Output
            }

            sqlCliente.EjecutaProcedimientoSql(params, "Gestion_ObtieneGestionExpediente")

            txtGestion.Text = params(1).Value.ToString

            ListaSecciones = New DataTable()
            ListaSecciones.Columns.Add("Seccion", GetType(String))
            ListaSecciones.Rows.Add("Todas las secciones")
            ListaSecciones.Rows.Add("1.00")
            ListaSecciones.Rows.Add("2.00")
            ListaSecciones.Rows.Add("3.00")

        End If

        CargaGrids()

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

            CargaGrids()

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

            CargaGrids()
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

    Private Sub CargaGrids()
        Dim sqlCliente As New ClienteSQL(Session("UsuarioVirtualConnStringSql"))
        Dim ds As DataSet

        Dim params(0) As SqlParameter

        params(0) = New SqlParameter("@IdExpediente", Session("IdExpedienteActivo"))

        ds = sqlCliente.ObtenerRegistrosSql(params, "Gestion_DocumentosDisponiblesAsignados")

        If ds IsNot Nothing AndAlso ds.Tables.Count > 0 Then
            ds.Tables(0).TableName = "Disponibles"
            dgvDocsDisponibles.Visible = True

            dgvDocsDisponibles.DataSource = ds
            dgvDocsDisponibles.DataMember = "Disponibles"
            dgvDocsDisponibles.DataKeyNames = {"IdExpedientePDFRelaciones"}
            dgvDocsDisponibles.DataBind()

            ds.Tables(1).TableName = "Asignados"
            dgvDocsAsignados.Visible = True

            dgvDocsAsignados.DataSource = ds
            dgvDocsAsignados.DataMember = "Asignados"
            dgvDocsAsignados.DataKeyNames = {"IdGestionDocumentosInstancia", "IdExpedientePdfRelaciones"}
            dgvDocsAsignados.DataBind()

        End If
    End Sub

    Protected Sub DgvDocsAsignados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles dgvDocsAsignados.RowCommand
        Dim gv As GridView = CType(sender, GridView)

        If e.CommandName = "DescargaImagen" Then
            Dim archivo As String = gv.Rows(CInt(e.CommandArgument)).Cells(14).Text     'La celda en posición 14 contiene el nombre del PDF.
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
End Class