Imports System.Data.SqlClient
Imports fsSimaServicios

Public Class TrabajoRealizado
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents DataGrid1 As DataGrid
    Protected WithEvents Panel1 As Panel
    Protected WithEvents txtFApertInic As TextBox
    Protected WithEvents Label2 As Label
    Protected WithEvents Label3 As Label
    Protected WithEvents Button1 As Button
    Protected WithEvents txtFApertFinal As TextBox
    Protected WithEvents Label4 As Label
    Protected WithEvents Label5 As Label
    Protected WithEvents Datagrid2 As DataGrid
    Protected WithEvents Panel2 As Panel
    Protected WithEvents RegularExpressionValidator2 As RegularExpressionValidator
    Protected WithEvents Regularexpressionvalidator1 As RegularExpressionValidator
    Protected WithEvents NoHayDatos As Label
    Protected WithEvents NoHayDatos2 As Label
    Protected WithEvents btnImpPorUA As Button
    Protected WithEvents btnImpPorUsuario As Button

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then
        Else
        End If

    End Sub

    Sub LlenaTotPorUsuario()
        Dim params(1) As SqlParameter
        Dim dsExpedientes As DataSet

        Dim sqlCliente As New ClienteSQL(CadenaConexion)

        'Fecha de Apertura inicial
        params(0) = New SqlParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", Nothing)
        End If

        'Fecha de Apertura final
        params(1) = New SqlParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", Nothing)
        End If

        dsExpedientes = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUsuario")

        If dsExpedientes.Tables.Count > 0 Then

            dsExpedientes.Tables(0).TableName = "Expedientes"

            If dsExpedientes.Tables(0).Rows.Count = 0 Then
                Datagrid2.Visible = False
                NoHayDatos2.Visible = True
                btnImpPorUsuario.Enabled = False
            Else
                Datagrid2.Visible = True
                NoHayDatos2.Visible = False

                Datagrid2.DataSource = dsExpedientes
                Datagrid2.DataMember = "Expedientes"
                Datagrid2.DataKeyField = "idusuarioreal"
                Datagrid2.DataBind()

                btnImpPorUsuario.Enabled = True

            End If

        End If

    End Sub

    Sub LlenaTotPorUA()
        Dim params(1) As SqlParameter
        Dim dsExpedientes As DataSet

        Dim sqlCliente As New ClienteSQL(CadenaConexion)

        'Fecha de Apertura inicial
        params(0) = New SqlParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", Nothing)
        End If

        'Fecha de Apertura final
        params(1) = New SqlParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", Nothing)
        End If

        dsExpedientes = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUnidadAdministrativa")

        If dsExpedientes.Tables.Count > 0 Then

            dsExpedientes.Tables(0).TableName = "Expedientes"

            If dsExpedientes.Tables(0).Rows.Count = 0 Then
                DataGrid1.Visible = False
                NoHayDatos.Visible = True
                btnImpPorUA.Enabled = False
            Else
                DataGrid1.Visible = True
                NoHayDatos.Visible = False

                DataGrid1.DataSource = dsExpedientes

                DataGrid1.DataMember = "Expedientes"
                DataGrid1.DataKeyField = "idunidadadministrativa"
                DataGrid1.DataBind()

                btnImpPorUA.Enabled = True

            End If

        End If
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        If Page.IsValid Then

            DataGrid1.Visible = False
            Datagrid2.Visible = False
            NoHayDatos.Visible = False
            btnImpPorUA.Enabled = False
            btnImpPorUsuario.Enabled = False

            LlenaTotPorUA()
            LlenaTotPorUsuario()

        End If

    End Sub

    Private Sub btnImpPorUA_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpPorUA.Click

        Dim params(1) As SqlParameter
        Dim ds As DataSet

        Dim sqlCliente As New ClienteSQL(CadenaConexion)

        Dim reporte As New AuditoriaPorUA

        'Fecha de Apertura inicial
        params(0) = New SqlParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", Nothing)
        End If

        'Fecha de Apertura final
        params(1) = New SqlParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", Nothing)
        End If

        ds = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUnidadAdministrativa")

        reporte.SetDataSource(ds.Tables(0))
        reporte.SetParameterValue(0, "Expedientes totales por Unidad Administrativa con Fecha de creación entre """ & params(0).Value & """ y """ & params(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

        reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        reporte.Dispose()

        Accesorios.DescargaReporte(Me, MyFileName, "trabajorealizado.pdf")

    End Sub

    Private Sub btnImpPorUsuario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpPorUsuario.Click

        Dim params(1) As SqlParameter
        Dim ds As DataSet

        Dim sqlCliente As New ClienteSQL(CadenaConexion)

        Dim Reporte As New AuditoriaPorUsuario

        'Fecha de Apertura inicial
        params(0) = New SqlParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", Nothing)
        End If

        'Fecha de Apertura final
        params(1) = New SqlParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", Nothing)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", Nothing)
        End If

        ds = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUsuario")

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Expedientes totales por usuario con fecha de edición entre """ & params(0).Value & """ y """ & params(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        Reporte.Dispose()

        Accesorios.DescargaReporte(Me, MyFileName, "trabajousuario.pdf")

    End Sub
End Class
