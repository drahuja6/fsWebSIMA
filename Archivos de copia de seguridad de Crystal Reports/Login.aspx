<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Login.aspx.vb" Inherits="fsWebS_SEN.Login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Login</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label1" style="Z-INDEX: 100; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Width="58px" Text="Usuario:" Font-Bold="True"></asp:label>
			<asp:textbox id="txtUsuario" style="Z-INDEX: 101; LEFT: 104px; POSITION: absolute; TOP: 8px"
				tabIndex="1" runat="server" Width="160px"></asp:textbox>
			<asp:button id="btnEntrar" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 72px" tabIndex="3"
				runat="server" Text="Entrar" Font-Bold="True"></asp:button>
			<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 16px; POSITION: absolute; TOP: 40px" runat="server"
				Width="67px" Text="Password:" Font-Bold="True">Contraseña:</asp:label>
			<asp:textbox id="txtPassword" style="Z-INDEX: 104; LEFT: 104px; POSITION: absolute; TOP: 40px"
				tabIndex="2" runat="server" Width="160px" TextMode="Password"></asp:textbox>
			<asp:requiredfieldvalidator id="RequiredFieldValidator1" style="Z-INDEX: 106; LEFT: 272px; POSITION: absolute; TOP: 8px"
				runat="server" ErrorMessage="**" ControlToValidate="txtUsuario"></asp:requiredfieldvalidator>
		</form>
	</body>
</HTML>
