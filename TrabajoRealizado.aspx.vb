Imports System.Data.OleDb

Public Class TrabajoRealizado
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Panel1 As System.Web.UI.WebControls.Panel
    Protected WithEvents txtFApertInic As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents txtFApertFinal As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents Datagrid2 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents Panel2 As System.Web.UI.WebControls.Panel
    Protected WithEvents RegularExpressionValidator2 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents Regularexpressionvalidator1 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents NoHayDatos As System.Web.UI.WebControls.Label
    Protected WithEvents NoHayDatos2 As System.Web.UI.WebControls.Label
    Protected WithEvents btnImpPorUA As System.Web.UI.WebControls.Button
    Protected WithEvents btnImpPorUsuario As System.Web.UI.WebControls.Button

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
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

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsExpedientes As New Data.DataSet

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure
        cmd.CommandText = "ExpTotPorUsuario"
        cmd.Connection = cn
        cmd.CommandType = Data.CommandType.StoredProcedure

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertInic.Text))
        End If

        'Fecha de Apertura final
        param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertFinal.Text))
        End If

        'Creo el objeto DataAdapter
        Dim daExpedientes As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daExpedientes.Fill(dsExpedientes, "Expedientes")
        dsExpedientes.Tables("Expedientes").Rows.Clear()
        daExpedientes.Fill(dsExpedientes, "Expedientes")

        If dsExpedientes.Tables(0).Rows.Count = 0 Then
            Datagrid2.Visible = False
            NoHayDatos2.Visible = True
            btnImpPorUsuario.Enabled = False
        Else
            Datagrid2.Visible = True
            NoHayDatos2.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            Datagrid2.DataSource = dsExpedientes

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            Datagrid2.DataMember = "Expedientes"
            Datagrid2.DataKeyField = "idusuarioreal"
            Datagrid2.DataBind()

            btnImpPorUsuario.Enabled = True

        End If

        'Cierro la colección de parámetros y la conexión
        cmd.Parameters.Clear()

    End Sub

    Sub LlenaTotPorUA()
        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsExpedientes As New Data.DataSet

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure
        cmd.CommandText = "ExpTotPorUA"
        cmd.Connection = cn
        cmd.CommandType = Data.CommandType.StoredProcedure

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertInic.Text))
        End If

        'Fecha de Apertura final
        param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertFinal.Text))
        End If

        'Creo el objeto DataAdapter
        Dim daExpedientes As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daExpedientes.Fill(dsExpedientes, "Expedientes")
        dsExpedientes.Tables("Expedientes").Rows.Clear()
        daExpedientes.Fill(dsExpedientes, "Expedientes")

        If dsExpedientes.Tables(0).Rows.Count = 0 Then
            DataGrid1.Visible = False
            NoHayDatos.Visible = True
            btnImpPorUA.Enabled = False

        Else
            DataGrid1.Visible = True
            NoHayDatos.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            DataGrid1.DataSource = dsExpedientes

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            DataGrid1.DataMember = "Expedientes"
            DataGrid1.DataKeyField = "idunidadadministrativa"
            DataGrid1.DataBind()

            btnImpPorUA.Enabled = True

        End If

        'Cierro la colección de parámetros y la conexión
        cmd.Parameters.Clear()

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

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

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New AuditoriaPorUA
        Dim MiCondicion As String

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "ExpTotPorUA"
        cmd.CommandTimeout = 0

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertInic.Text))
        End If

        'Fecha de Apertura final
        param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertFinal.Text))
        End If

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()


        'da.SelectCommand = cmd
        'da.Fill(ds)
        'da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Expedientes Totales por Unidad Administrativa, y con Fecha de Creación entre """ & cmd.Parameters(0).Value & """ y """ & cmd.Parameters(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

        'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
        'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

        'Write the file directly to the HTTP output stream.
        Response.ContentType = "Application/pdf"
        Response.WriteFile(MyFileName)
        Response.End()

    End Sub

    Private Sub btnImpPorUsuario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpPorUsuario.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New AuditoriaPorUsuario
        Dim MiCondicion As String

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "ExpTotPorUsuario"
        cmd.CommandTimeout = 0

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.Date)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertInic.Text))
        End If

        'Fecha de Apertura final
        param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.Date)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            param.Value = CDate("1/1/1900")
        Else
            param.Value = CDate(Trim(txtFApertFinal.Text))
        End If

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()


        'da.SelectCommand = cmd
        'da.Fill(ds)
        'da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Expedientes Totales por Usuario, y con Fecha de Edición entre """ & cmd.Parameters(0).Value & """ y """ & cmd.Parameters(1).Value & """")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

        'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
        'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

        'Write the file directly to the HTTP output stream.
        Response.ContentType = "Application/pdf"
        Response.WriteFile(MyFileName)
        Response.End()

    End Sub
End Class
