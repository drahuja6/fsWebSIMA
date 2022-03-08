Imports System.Data.OleDb

Imports fsSimaServicios

Public Class CuadroClasificacion
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents Label2 As Label
    Protected WithEvents txbFiltro As TextBox
    Protected WithEvents btnAplicar As Button
    Protected WithEvents Panel1 As Panel
    Protected WithEvents DataGrid1 As DataGrid
    Protected WithEvents NoHayDatos As Label

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

#Region "Eventos de la forma"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then

        End If

    End Sub

    Private Sub DataGrid1_ItemCommand(source As Object, e As DataGridCommandEventArgs) Handles DataGrid1.ItemCommand

        If e.Item.ItemIndex >= 0 Then
            Session("idCuadroClasificacionActivo") = DataGrid1.DataKeys.Item(e.Item.ItemIndex)
            Session("CodigoCompletoCuadroClasificacion") = DataGrid1.Items(e.Item.ItemIndex).Cells(1).Text
            Session("CuadroClasificacionStatus") = 0
            Session("ExpedienteStatus") = 0
            Session("MovimientoStatus") = 0
            Session("UsuarioRealStatus") = 0
            Response.Redirect("./CuadroClasificacionStatus.aspx")
        End If

    End Sub

    Private Sub BtnAplicar_Click(sender As Object, e As EventArgs) Handles btnAplicar.Click

        If Page.IsValid Then
            FillCuadro(txbFiltro.Text)
        End If

    End Sub

#End Region

#Region "Métodos privados"

    Sub FillCuadro(filtro As String)

        Dim params(0) As OleDbParameter
        Dim sqlCliente As New ClienteSQL(CadenaConexion)
        Dim dsCuadroClasificacion As DataSet

        params(0) = New OleDbParameter("@CadenaABuscar", filtro)

        dsCuadroClasificacion = sqlCliente.ObtenerRegistros(params, "SubArbolDeCuentasOrdenado3")

        If dsCuadroClasificacion.Tables.Count > 0 Then
            dsCuadroClasificacion.Tables(0).TableName = "CuadroClasificacion"
            If dsCuadroClasificacion.Tables(0).Rows.Count = 0 Then
                DataGrid1.Visible = False
                NoHayDatos.Visible = True
            Else
                DataGrid1.Visible = True
                NoHayDatos.Visible = False

                DataGrid1.DataSource = dsCuadroClasificacion

                DataGrid1.DataMember = "CuadroClasificacion"
                DataGrid1.DataKeyField = "idClasificacion"
                DataGrid1.DataBind()
            End If
        End If
    End Sub

#End Region

End Class
