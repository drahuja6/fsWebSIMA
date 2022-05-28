<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Login.aspx.vb" Inherits="fsWebS_SEN.Login" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!doctype html>
<html>
	<head>
		<title>Login</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<!– jQuery first, then Popper.js, then Bootstrap JS –>
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />
		<link type="text/css" rel="stylesheet" href="Senado.css" />
	    <style type="text/css">
            #Form1 {
                width: 350px;
            }
			.col-1 {
				width: 50%;
				height: 30px;
				text-align: right;
			}
			.col-2 {
				width: 45%;
				height: 30px;
			}
			.col-3 {
				width: 5%;
				height: 30px;
			}
		</style> 
	</head>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server" visible="True">
			<div style="max-width: 300px; margin-left: 20px">
				<h2 class="form-signin-heading">Datos de acceso</h2>
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
<%--			<div>
				<table style="width: 300px; margin: auto auto auto 10px">
					<tr>
						<th colspan="3" class="etiqueta-titulo">
							<asp:Label ID="tituloLabel" runat="server" Text="Datos de acceso" Height="40px"></asp:Label>
						</th>
					</tr>
					<tr>
						<td class="col-1">
							<asp:label CssClass="etiqueta" id="usuarioLabel" runat="server" Text="Usuario:"/>
						<td class="col-2">
							<asp:textbox CssClass="etiqueta-textbox-ancho" id="txtUsuario" tabIndex="1" runat="server"/>
						<td class="col-3">
							<asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" ErrorMessage="**" ControlToValidate="txtUsuario"/>
					</tr>
					<tr>
						<td class="col-1">
							<asp:label CssClass="etiqueta" id="contrasenaLabel" runat="server" Text="Contraseña:"/>
						</td>
						<td class="col-2">
							<asp:textbox CssClass="etiqueta-textbox-ancho" id="txtPassword" tabIndex="2" runat="server" TextMode="Password"/>
						</td>
						<td class="col-3"/>
					</tr>
					<tr>
						<td class="col-1"/>
						<td class="col-2">
							<asp:button CssClass="etiqueta-boton" id="btnEntrar" tabIndex="3" runat="server" Text="Entrar"/>
						</td>
					</tr>
					<tr><td colspan="3"><br /></td></tr>
				</table>
				<asp:Label CssClass="etiqueta error" ID="lblAccesoNegado" runat="server" ForeColor="Red" Text="Acceso denegado. Verifique usuario y contraseña." Visible="False"/>
			</div>--%>
		</form>
	</body>
</html>
