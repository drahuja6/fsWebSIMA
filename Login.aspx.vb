Public Class Login
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents txtUsuario As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnEntrar As System.Web.UI.WebControls.Button
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents txtPassword As System.Web.UI.WebControls.TextBox
    Protected WithEvents RequiredFieldValidator1 As System.Web.UI.WebControls.RequiredFieldValidator

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

#Region " Métodos privados "

    Public Function Get_IDUsuarioReal_From_Login(ByVal MyLogin As String, ByRef MyidUsuarioReal As Integer, ByRef MyNombreUsuarioReal As String) As Boolean

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("AdminConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Get_IDUsuarioReal_From_Login"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'MyLogin
            param = cmd.Parameters.Add("MyLogin", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = MyLogin

            'MyidUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'MyNombreUsuarioReal
            param = cmd.Parameters.Add("MyNombreUsuarioReal", Data.OleDb.OleDbType.VarChar, 50)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            MyidUsuarioReal = CInt(cmd.Parameters("MyidUsuarioReal").Value)
            MyNombreUsuarioReal = CStr(cmd.Parameters("MyNombreUsuarioReal").Value)

            If CInt(cmd.Parameters("MyidUsuarioReal").Value) <> -1 Then
                Get_IDUsuarioReal_From_Login = True
            Else
                Get_IDUsuarioReal_From_Login = False
            End If

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Get_IDUsuarioReal_From_Login = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Function FillUsuarioVirtualConnString(ByVal LoginUsuarioReal As String, ByVal PasswordUsuarioReal As String) As Boolean

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim scrambler As New GITDataTools.ScrambleNET

        Try

            'Abro la conexión
            cn.ConnectionString = Session("AdminConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Get_UsuarioVirtual_From_UsuarioReal"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'MyLoginUsuarioReal
            param = cmd.Parameters.Add("MyLoginUsuarioReal", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = LoginUsuarioReal

            'MyPasswordUsuarioReal
            param = cmd.Parameters.Add("MyPasswordUsuarioReal", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = PasswordUsuarioReal

            'MyLoginUsuarioVirtual
            param = cmd.Parameters.Add("MyLoginUsuarioVirtual", Data.OleDb.OleDbType.VarChar, 50)
            param.Direction = Data.ParameterDirection.Output

            'MyPasswordUsuarioVirtual
            param = cmd.Parameters.Add("MyPasswordUsuarioVirtual", Data.OleDb.OleDbType.VarChar, 50)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            Session("UsuarioVirtualConnString") = "Provider=SQLOLEDB;Server=ec2-54-147-133-25.compute-1.amazonaws.com,1433;Database=SIMA_Senado;UID=" & CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value) & ";PWD=" & scrambler.Scramble(CStr(cmd.Parameters("MyPasswordUsuarioVirtual").Value), Chr(25) & Chr(26)) & ";Persist Security Info=True;Connect Timeout=15;"

            cn.Close()

            If CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value) <> "?" Then
                FillUsuarioVirtualConnString = True
            Else
                FillUsuarioVirtualConnString = False
            End If

        Catch ex As Exception

            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If
            Session("UsuarioVirtualConnString") = ""
            FillUsuarioVirtualConnString = False
        End Try

    End Function

#End Region

#Region " Eventos de la página "
    Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario al cargar la página

        Session("AdminConnString") = "Provider=SQLOLEDB;Server=ec2-54-147-133-25.compute-1.amazonaws.com,1433;Database=SIMA_Senado;UID=USOC;Pwd=f5*HIDDENUSER;Persist Security Info=True;Connect Timeout=15;"

        Session("OrdenDeGridDeExpedientes") = " e.Nombre "
        'Session("SubdirectorioDeImagenes") = "D:\PdfSIMA\Senado\DGAHML\00001\" '"\\207.248.171.73\img\" '"c:\imagenes\"  '"\\10.1.201.60\img\"  '"c:\prov\"
        Session("SubdirectorioDeImagenes") = My.Settings.DirImagenes
        'Session("SubdirectorioTemporal") = "c:\inetpub\temp\prov\"
        Session("SubdirectorioTemporal") = My.Settings.DirTemporal
        Session("LimiteDeRecordsEnBusqueda") = 50

        If Not Page.IsPostBack Then

            Session("UsuarioVirtualConnString") = ""

            Session("IDExpedienteActivo") = -1
            Session("IDMovimientoActivo") = -1
            Session("idCuadroClasificacionActivo") = -1
            Session("TextoCuadroClasificacionEscogido") = ""
            Session("idUsuarioRealEnEdicionActivo") = -1


            Session("idPlazoDeConservacionTramiteActivo") = -1
            Session("idPlazoDeConservacionConcentracionActivo") = -1
            Session("idDestinoFinalActivo") = -1
            Session("idInformacionClasificadaActivo") = -1
            Session("idClasificacionActivo") = -1

            Session("CodigoCompletoCuadroClasificacion") = -1

            Session("NextLeftActivo") = 0
            Session("NextRightActivo") = 0

            Session("ExpedienteStatus") = 0 '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
            Session("MovimientoStatus") = 0
            Session("CuadroClasificacionStatus") = 0
            Session("UsuarioRealStatus") = 0

        End If

    End Sub

    Private Sub BtnEntrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEntrar.Click
        Dim scrambler As New GITDataTools.ScrambleNET
        Dim IDUsuarioReal As Integer
        Dim NombreUsuarioReal As String = ""

        Session("LoginActivo") = txtUsuario.Text.ToString

        If FillUsuarioVirtualConnString(txtUsuario.Text.ToString, scrambler.Scramble(txtPassword.Text.ToString, Chr(25) & Chr(26))) Then

            If Get_IDUsuarioReal_From_Login(txtUsuario.Text.ToString, IDUsuarioReal, NombreUsuarioReal) Then
                Session("IDUsuarioReal") = IDUsuarioReal
                Session("NombreUsuarioReal") = NombreUsuarioReal
            End If

            Response.Redirect("./FrameSet2.htm")
        Else
            Beep()
        End If

    End Sub

#End Region

End Class
