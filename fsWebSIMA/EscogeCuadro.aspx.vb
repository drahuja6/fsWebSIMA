Imports System.Data.OleDb

Public Class EscogeCuadro
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents NoHayDatos As Label
    Protected WithEvents Panel1 As Panel
    Protected WithEvents Label1 As Label
    Protected WithEvents Label2 As Label
    Protected WithEvents txbFiltro As TextBox
    Protected WithEvents btnAplicar As Button
    Protected WithEvents PrettyDataGrid1 As skmDataGrid.PrettyDataGrid

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

        Session("TextoCuadroClasificacionEscogido") = ""

    End Sub

    Sub FillCuadro(ByVal MyFiltro As String)

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsCuadroClasificacion As New Data.DataSet
        'Dim dr As OleDbDataReader

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure para leer los nodos
        cmd.CommandText = "SubArbolDeCuentasOrdenado3"
        cmd.Connection = cn
        cmd.CommandType = CommandType.StoredProcedure

        'idExpediente
        param = cmd.Parameters.Add("Filtro", Data.OleDb.OleDbType.VarChar, 250)
        param.Value = MyFiltro

        'Creo el objeto DataAdapter
        Dim daCuadroClasificacion As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daCuadroClasificacion.Fill(dsCuadroClasificacion, "CuadroClasificacion")
        dsCuadroClasificacion.Tables("CuadroClasificacion").Rows.Clear()
        daCuadroClasificacion.Fill(dsCuadroClasificacion, "CuadroClasificacion")

        If dsCuadroClasificacion.Tables(0).Rows.Count = 0 Then
            PrettyDataGrid1.Visible = False
            NoHayDatos.Visible = True
        Else
            PrettyDataGrid1.Visible = True
            NoHayDatos.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            PrettyDataGrid1.DataSource = dsCuadroClasificacion

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            PrettyDataGrid1.DataMember = "CuadroClasificacion"
            PrettyDataGrid1.DataKeyField = "idClasificacion"
            PrettyDataGrid1.DataBind()

        End If

        cn.Close()

    End Sub

    Private Sub btnAplicar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAplicar.Click

        If Page.IsValid Then
            FillCuadro(txbFiltro.Text)
        End If

    End Sub

    Private Sub PrettyDataGrid1_ItemCommand(ByVal source As Object, ByVal e As DataGridCommandEventArgs) Handles PrettyDataGrid1.ItemCommand

        Session("TextoCuadroClasificacionEscogido") = PrettyDataGrid1.Items(e.Item.ItemIndex).Cells(0).Text()
        Response.Redirect("./DisplayExpediente.aspx")

    End Sub

End Class
