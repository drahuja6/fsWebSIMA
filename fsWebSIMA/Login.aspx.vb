Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Web.Security

Imports fsSimaServicios

Public Class Login
    Inherits Page

#Region " C�digo generado por el Dise�ador de Web Forms "

    'El Dise�ador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents txtUsuario As TextBox
    Protected WithEvents btnEntrar As Button
    Protected WithEvents Label2 As Label
    Protected WithEvents txtPassword As TextBox
    Protected WithEvents RequiredFieldValidator1 As RequiredFieldValidator
    Protected WithEvents lblAccesoNegado As Label
    Protected WithEvents divMensaje As Panel

    'NOTA: el Dise�ador de Web Forms necesita la siguiente declaraci�n del marcador de posici�n.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Dise�ador de Web Forms requiere esta llamada de m�todo
        'No la modifique con el editor de c�digo.
        InitializeComponent()
    End Sub

#End Region

#Region "Eventos de la p�gina"
    Private Sub Page_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        Session("AdminConnString") = ConexionAdministrativa
        Session("AdminConnStringSql") = ConexionAdministrativaSql

        Session("OrdenDeGridDeExpedientes") = OrdenExpedientes
        Session("SubdirectorioDeImagenes") = DirImagenes
        Session("SubdirectorioTemporal") = DirTemporal
        Session("LimiteDeRecordsEnBusqueda") = RegistrosMaximos

        txtUsuario.Focus()

        If Not Page.IsPostBack Then

            Session("UsuarioVirtualConnString") = ""
            Session("LoginUsuarioVirtual") = ""

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

            'Session("NextLeftActivo") = 0
            'Session("NextRightActivo") = 0

            Session("ExpedienteStatus") = 0 '0=SOLO LECTURA 1=A�ADIENDO 2=EDITANDO 3=BORRANDO
            Session("MovimientoStatus") = 0
            Session("CuadroClasificacionStatus") = 0
            Session("UsuarioRealStatus") = 0

        End If

    End Sub

    Private Sub BtnEntrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEntrar.Click
        'Dim scrambler As New GITDataTools.ScrambleNET
        Dim IDUsuarioReal As Integer
        Dim NombreUsuarioReal As String = ""

        Session("LoginActivo") = txtUsuario.Text.ToString

        'If FillUsuarioVirtualConnString(txtUsuario.Text.ToString, scrambler.Scramble(txtPassword.Text.ToString, Chr(25) & Chr(26))) Then

        Dim ip As String = If(Not String.IsNullOrEmpty(HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR")), HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR"), HttpContext.Current.Request.ServerVariables("REMOTE_ADDR"))

        If FillUsuarioVirtualConnString(txtUsuario.Text.ToString, New Encripcion(Globales.CodigoAcceso).Encripta(txtPassword.Text.ToString.Trim)) Then
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
            ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr) With {
                .Path = FormsAuthentication.FormsCookiePath
            }
            Response.Cookies.Add(ck)

            Dim strRedirect As String = Request("ReturnUrl")
            If String.IsNullOrEmpty(strRedirect) Then
                strRedirect = "Frameset2.htm"
            End If

            Accesorios.EscribeBitacoraBD(Session("AdminConnStringSql").ToString, txtUsuario.Text.ToString.Trim, ip, True)

            Response.Redirect(strRedirect, True)
        Else
            divMensaje.Visible = True
            lblAccesoNegado.Visible = True

            Accesorios.EscribeBitacoraBD(Session("AdminConnStringSql").ToString, txtUsuario.Text.ToString.Trim, ip, False)
        End If

    End Sub

#End Region

#Region "M�todos privados"

    Public Function Get_IDUsuarioReal_From_Login(ByVal MyLogin As String, ByRef MyidUsuarioReal As Integer, ByRef MyNombreUsuarioReal As String) As Boolean

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Dim loginOk As Boolean = False

        Try

            'Abro la conexi�n
            cn.ConnectionString = Session("AdminConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Get_IDUsuarioReal_From_Login"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'MyLogin
            param = cmd.Parameters.Add("MyLogin", OleDbType.VarChar, 25)
            param.Value = MyLogin

            'MyidUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'MyNombreUsuarioReal
            param = cmd.Parameters.Add("MyNombreUsuarioReal", OleDbType.VarChar, 50)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            MyidUsuarioReal = CInt(cmd.Parameters("MyidUsuarioReal").Value)
            MyNombreUsuarioReal = CStr(cmd.Parameters("MyNombreUsuarioReal").Value)

            If CInt(cmd.Parameters("MyidUsuarioReal").Value) <> -1 Then
                loginOk = True
            Else
                loginOk = False
            End If

            cn.Close()

            Return loginOk

        Catch ex As Exception

            Get_IDUsuarioReal_From_Login = False
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Function FillUsuarioVirtualConnString(LoginUsuarioReal As String, PasswordUsuarioReal As String) As Boolean

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        'Dim scrambler As New GITDataTools.ScrambleNET
        Dim cryp As New Encripcion(Globales.CodigoAcceso)

        Try

            'Abro la conexi�n
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

            Dim connString As New OleDbConnectionStringBuilder(Globales.ConexionAdministrativa)
            connString("UID") = CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value)
            connString("PWD") = cryp.Desencripta(CStr(cmd.Parameters("MyPasswordUsuarioVirtual").Value))
            Session("UsuarioVirtualConnString") = connString.ToString()

            Dim connStringSql As New SqlConnectionStringBuilder(Globales.ConexionAdministrativaSql) With {
                .UserID = CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value),
                .Password = cryp.Desencripta(CStr(cmd.Parameters("MyPasswordUsuarioVirtual").Value))
            }
            Session("UsuarioVirtualConnStringSQL") = connStringSql.ToString()

            cn.Close()

            If CStr(cmd.Parameters("MyLoginUsuarioVirtual").Value) <> "?" Then
                FillUsuarioVirtualConnString = True
                Session("LoginUsuarioVirtual") = cmd.Parameters("MyLoginUsuarioVirtual").Value.ToString
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

End Class
