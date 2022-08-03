<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Login.aspx.vb" Inherits="fsWebS_SEN.Login" %>
<!doctype html>
<html>
	<head>
		<title>Login</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</head>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server" visible="True">
			<div style="max-width: 300px; margin-left: 20px; margin-top: 10px;">
				<h3 class="form-signin-heading">Datos de acceso</h3>
				<label for="txtUsuario">Usuario:</label>
				<asp:textbox CssClass="form-control" id="txtUsuario" tabIndex="1" runat="server" place-holder="Nombre de usuario" required="true" oninvalid="this.setCustomValidity('El campo no puede quedar vacío')" oninput="this.setCustomValidity('');" />
				<br />
				<label for="txtPassword">Contraseña:</label>
				<asp:textbox CssClass="form-control" TextMode="Password" place-holder="Contraseña" id="txtPassword" tabIndex="2" runat="server" required="true" oninvalid="this.setCustomValidity('El campo no puede quedar vacío')" oninput="this.setCustomValidity('')" />
				<br />
				<asp:button CssClass="btn btn-primary" id="btnEntrar" tabIndex="3" runat="server" Text="Entrar"/>
				<br />
				<br />
				<asp:panel id="divMensaje" runat="server" visible="false" class="alert alert-danger">
					<strong>¡Error!</strong>
					<asp:Label id="lblAccesoNegado" runat="server" Text="Acceso denegado. Verifique usuario y contraseña." visible="False"/>
				</asp:panel>
			</div>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
