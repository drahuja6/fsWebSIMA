Public Class ExpVencidos
    Inherits Page

#Region " C�digo generado por el Dise�ador de Web Forms "

    'El Dise�ador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents NoHayDatos As Label
    Protected WithEvents DataGrid1 As DataGrid
    Protected WithEvents Panel1 As Panel
    Protected WithEvents Label2 As Label
    Protected WithEvents Label3 As Label
    Protected WithEvents Datagrid2 As DataGrid
    Protected WithEvents Panel2 As Panel
    Protected WithEvents Label4 As Label

    'NOTA: el Dise�ador de Web Forms necesita la siguiente declaraci�n del marcador de posici�n.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Dise�ador de Web Forms requiere esta llamada de m�todo
        'No la modifique con el editor de c�digo.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Introducir aqu� el c�digo de usuario para inicializar la p�gina

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then
        Else
        End If

        LlenaExpVencEnTramXUnidAdm()
        LlenaExpVencEnConcXUnidAdm()


    End Sub

    Sub LlenaExpVencEnConcXUnidAdm()

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsExpedientes As New Data.DataSet

        'Abro la conexi�n
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure
        cmd.CommandText = "ExpVencEnConcXUnidAdm"
        cmd.Connection = cn
        cmd.CommandType = Data.CommandType.StoredProcedure

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaDeCorte", Data.OleDb.OleDbType.DBDate)
        param.Value = Now.Date

        'Creo el objeto DataAdapter
        Dim daExpedientes As New Data.OleDb.OleDbDataAdapter(cmd)

        'A�ado al objeto DataSet una nueva tabla,
        'llen�ndola con datos seg�n instrucciones del DataAdapter
        daExpedientes.Fill(dsExpedientes, "Expedientes")
        dsExpedientes.Tables("Expedientes").Rows.Clear()
        daExpedientes.Fill(dsExpedientes, "Expedientes")

        If dsExpedientes.Tables(0).Rows.Count = 0 Then
            Datagrid2.Visible = False
            NoHayDatos.Visible = True

        Else
            Datagrid2.Visible = True
            NoHayDatos.Visible = False

            'Se�alo cu�l va a ser el DataSet de este grid
            Datagrid2.DataSource = dsExpedientes

            'Se�alo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relaci�n, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relaci�n. Hay que poner el nombre completo: "TABLA.RELACION"
            Datagrid2.DataMember = "Expedientes"
            Datagrid2.DataKeyField = "UnidAdm"
            Datagrid2.DataBind()

        End If

        'Cierro la colecci�n de par�metros y la conexi�n
        cmd.Parameters.Clear()

    End Sub

    Sub LlenaExpVencEnTramXUnidAdm()

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsExpedientes As New Data.DataSet

        'Abro la conexi�n
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure
        cmd.CommandText = "ExpVencEnTramXUnidAdm"
        cmd.Connection = cn
        cmd.CommandType = Data.CommandType.StoredProcedure

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaDeCorte", Data.OleDb.OleDbType.DBDate)
        param.Value = Now.Date

        'Creo el objeto DataAdapter
        Dim daExpedientes As New Data.OleDb.OleDbDataAdapter(cmd)

        'A�ado al objeto DataSet una nueva tabla,
        'llen�ndola con datos seg�n instrucciones del DataAdapter
        daExpedientes.Fill(dsExpedientes, "Expedientes")
        dsExpedientes.Tables("Expedientes").Rows.Clear()
        daExpedientes.Fill(dsExpedientes, "Expedientes")

        If dsExpedientes.Tables(0).Rows.Count = 0 Then
            DataGrid1.Visible = False
            NoHayDatos.Visible = True

        Else
            DataGrid1.Visible = True
            NoHayDatos.Visible = False

            'Se�alo cu�l va a ser el DataSet de este grid
            DataGrid1.DataSource = dsExpedientes

            'Se�alo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relaci�n, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relaci�n. Hay que poner el nombre completo: "TABLA.RELACION"
            DataGrid1.DataMember = "Expedientes"
            DataGrid1.DataKeyField = "UnidAdm"
            DataGrid1.DataBind()

        End If

        'Cierro la colecci�n de par�metros y la conexi�n
        cmd.Parameters.Clear()

    End Sub

End Class
