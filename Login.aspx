<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Login.aspx.vb" Inherits="fsWebS_SEN.Login" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Login</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	    <style type="text/css">
            #Form1 {
                width: 350px;
            }
			.etiqueta-titulo {  
				font-size: medium;
				font-weight: 700;
				font-family: Arial, Helvetica, sans-serif;
				color: white;
				background-color: #5D7B9D;
				vertical-align: central;
				height: 40px;
            }  
			.etiqueta {  
				font-size: smaller;
				font-weight:700;
				font-family: Arial, Helvetica, sans-serif;
				color:navy;
				vertical-align:central;
            }  
			.textbox {  
				width: 160px;
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
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
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server" visible="True">
			<div>
				<table style="width: 300px">
					<tr>
						<th colspan="3" class="etiqueta-titulo">
							<asp:Label ID="tituloLabel" runat="server" Text="Datos de acceso" Height="40px"></asp:Label>
						</th>
					</tr>
					<tr>
						<td class="col-1">
							<asp:label CssClass="etiqueta" id="usuarioLabel" runat="server" Text="Usuario:"/>
						<td class="col-2">
							<asp:textbox CssClass="textbox" id="txtUsuario" tabIndex="1" runat="server"/>
						<td class="col-3">
							<asp:requiredfieldvalidator id="RequiredFieldValidator1" runat="server" ErrorMessage="**" ControlToValidate="txtUsuario"/>
					</tr>
					<tr>
						<td class="col-1">
							<asp:label CssClass="etiqueta" id="contrasenaLabel" runat="server" Text="Contraseña:"/>
						</td>
						<td class="col-2">
							<asp:textbox CssClass="textbox" id="txtPassword" tabIndex="2" runat="server" TextMode="Password"/>
						</td>
						<td class="col-3"/>
					</tr>
					<tr>
						<td class="col-1"/>
						<td class="col-2">
							<asp:button CssClass="etiqueta" id="btnEntrar" tabIndex="3" runat="server" Text="Entrar"/>
						</td>
					</tr>
					<tr><td colspan="3"><br /></td></tr>
				</table>
				<asp:Label CssClass="etiqueta" ID="lblAccesoNegado" runat="server" ForeColor="Red" Text="Acceso denegado. Verifique usuario y contraseña." Visible="False"/>
			</div>
		</form>
	</body>
</HTML>
