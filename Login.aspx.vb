Imports System.Web.Security

Public Class Login
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents txtUsuario As TextBox
    Protected WithEvents btnEntrar As Button
    Protected WithEvents Label2 As Label
    Protected WithEvents txtPassword As TextBox
    Protected WithEvents RequiredFieldValidator1 As RequiredFieldValidator
    Protected WithEvents lblAccesoNegado As Label

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

            Session("UsuarioVirtualConnString") = "Provider=MSOLEDBSQL;Server=ec2-54-147-133-25.compute-1.amazonaws.com,1433;Database=" & BaseDatos & ";UID=" & CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value) & ";PWD=" & scrambler.Scramble(CStr(cmd.Parameters("MyPasswordUsuarioVirtual").Value), Chr(25) & Chr(26)) & ";Persist Security Info=True;Connect Timeout=15;Encryption=True;"

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

        Session("AdminConnString") = "Provider=MSOLEDBSQL;Server=ec2-54-147-133-25.compute-1.amazonaws.com,1433;UID=USOC;Pwd=f5*HIDDENUSER;Persist Security Info=True;Connect Timeout=15;Database=" & BaseDatos & ";Encryption=True;"

        Session("OrdenDeGridDeExpedientes") = OrdenExpedientes
        'Estas dos variables de sesión se dejan por compatibilidad en lugar de la variable global definida en Globales.vb
        Session("SubdirectorioDeImagenes") = My.Settings.DirImagenes
        Session("SubdirectorioTemporal") = My.Settings.DirTemporal

        Session("LimiteDeRecordsEnBusqueda") = RegistrosMaximos

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
            lblAccesoNegado.Visible = False
            'Response.Redirect("./FrameSet2.htm")
            'FormsAuthentication.RedirectFromLoginPage(IDUsuarioReal, False)

            Dim tkt As FormsAuthenticationTicket
            Dim cookiestr As String
            Dim ck As HttpCookie
            tkt = New FormsAuthenticationTicket(1, IDUsuarioReal, DateTime.Now, DateTime.Now.AddMinutes(30), False, "SIMA")
            cookiestr = FormsAuthentication.Encrypt(tkt)
            ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
            ck.Path = FormsAuthentication.FormsCookiePath
            Response.Cookies.Add(ck)

            Dim strRedirect As String = Request("ReturnUrl")
            If String.IsNullOrEmpty(strRedirect) Then
                strRedirect = "Frameset2.htm"
            End If

            Response.Redirect(strRedirect, True)
        Else
            lblAccesoNegado.Visible = True
        End If

    End Sub

#End Region

End Class
