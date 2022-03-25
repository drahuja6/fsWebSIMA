Imports System.Data.OleDb
Imports System.Globalization

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
    Protected WithEvents buscarButton As Button
    Protected WithEvents txtFApertFinal As TextBox
    Protected WithEvents Label4 As Label
    Protected WithEvents Label5 As Label
    Protected WithEvents Datagrid2 As DataGrid
    Protected WithEvents Panel2 As Panel
    Protected WithEvents RegularExpressionValidator2 As RegularExpressionValidator
    Protected WithEvents Regularexpressionvalidator1 As RegularExpressionValidator
    Protected WithEvents noHayDatosUnidadLabel As Label
    Protected WithEvents noHayDatosUsuarioLabel As Label
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

    Private _cadenaConexion As String
    Private ReadOnly _culture As CultureInfo = CultureInfo.CreateSpecificCulture("es-MX")

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        _cadenaConexion = Session("UsuarioVirtualConnString").ToString

        btnImpPorUA.Visible = False
        btnImpPorUsuario.Visible = False

        If Not Page.IsPostBack Then
        Else


        End If

    End Sub

    Sub LlenaTotPorUsuario()
        Dim params(1) As OleDbParameter
        Dim dsExpedientes As DataSet
        Dim culture As CultureInfo = CultureInfo.CreateSpecificCulture("es-MX")

        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        'Fecha de Apertura inicial
        params(0) = New OleDbParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", _culture)
        End If

        'Fecha de Apertura final
        params(1) = New OleDbParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", _culture)
        End If

        dsExpedientes = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUsuario")

        If dsExpedientes.Tables.Count > 0 Then

            dsExpedientes.Tables(0).TableName = "Expedientes"

            If dsExpedientes.Tables(0).Rows.Count = 0 Then
                Datagrid2.Visible = False
                noHayDatosUsuarioLabel.Visible = True
                btnImpPorUsuario.Enabled = False
            Else
                Datagrid2.Visible = True
                noHayDatosUsuarioLabel.Visible = False

                Datagrid2.DataSource = dsExpedientes
                Datagrid2.DataMember = "Expedientes"
                Datagrid2.DataKeyField = "idusuarioreal"
                Datagrid2.DataBind()

                btnImpPorUsuario.Visible = True

            End If

        End If

    End Sub

    Sub LlenaTotPorUA()
        Dim params(1) As OleDbParameter
        Dim dsExpedientes As DataSet

        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        'Fecha de Apertura inicial
        params(0) = New OleDbParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", _culture)
        End If

        'Fecha de Apertura final
        params(1) = New OleDbParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", _culture)
        End If

        dsExpedientes = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUnidadAdministrativa")

        If dsExpedientes.Tables.Count > 0 Then

            dsExpedientes.Tables(0).TableName = "Expedientes"

            If dsExpedientes.Tables(0).Rows.Count = 0 Then
                DataGrid1.Visible = False
                noHayDatosUnidadLabel.Visible = True
                btnImpPorUA.Enabled = False
            Else
                DataGrid1.Visible = True
                noHayDatosUnidadLabel.Visible = False

                DataGrid1.DataSource = dsExpedientes

                DataGrid1.DataMember = "Expedientes"
                DataGrid1.DataKeyField = "idunidadadministrativa"
                DataGrid1.DataBind()

                btnImpPorUA.Visible = True

            End If

        End If
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles buscarButton.Click

        If Page.IsValid Then

            DataGrid1.Visible = False
            Datagrid2.Visible = False
            noHayDatosUnidadLabel.Visible = False
            noHayDatosUsuarioLAbel.Visible = False
            btnImpPorUA.Visible = False
            btnImpPorUsuario.Visible = False

            LlenaTotPorUA()
            LlenaTotPorUsuario()

        End If

    End Sub

    Private Sub BtnImpPorUA_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpPorUA.Click

        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        Dim reporte As New AuditoriaPorUA

        'Fecha de Apertura inicial
        params(0) = New OleDbParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", _culture)
        End If

        'Fecha de Apertura final
        params(1) = New OleDbParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", _culture)
        End If

        ds = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUnidadAdministrativa")

        reporte.SetDataSource(ds.Tables(0))
        reporte.SetParameterValue(0, "Expedientes totales por Unidad Administrativa con Fecha de creación entre """ & params(0).Value & """ y """ & params(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

        reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        reporte.Dispose()

        Accesorios.DescargaArchivo(Me.Response, MyFileName, LongitudMaximaArchivoDescarga, "trabajorealizado.pdf", True)

    End Sub

    Private Sub BtnImpPorUsuario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpPorUsuario.Click

        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        Dim Reporte As New AuditoriaPorUsuario

        'Fecha de Apertura inicial
        params(0) = New OleDbParameter("@FechaInicial", SqlDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            params(0).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(0).Value = DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", _culture)
        End If

        'Fecha de Apertura final
        params(1) = New OleDbParameter("@FechaFinal", SqlDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            params(1).Value = DateTime.ParseExact("1/1/1900", "d/M/yyyy", _culture)
        Else
            params(1).Value = DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", _culture)
        End If

        ds = sqlCliente.ObtenerRegistros(params, "ExpedientesPorUsuario")

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Expedientes totales por usuario con fecha de edición entre """ & params(0).Value & """ y """ & params(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        Reporte.Dispose()

        Accesorios.DescargaArchivo(Me.Response, MyFileName, LongitudMaximaArchivoDescarga, "trabajousuario.pdf", True)

    End Sub
End Class
