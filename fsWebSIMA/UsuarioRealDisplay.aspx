<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UsuarioRealDisplay.aspx.vb" Inherits="fsWebSIMA.UsuarioRealDisplay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>UsuarioRealDisplay</title>
		<style type="text/css">
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
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
			}
			.col {
				width: 20%;
				height: 30px;
			}
			.col-2 {
				width: 20%;
				height: 30px;
				text-align:right;
			}
		</style> 
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<div>
				<table style="width:500px">
					<tr>
						<th class="etiqueta-titulo" colspan="6">
							<asp:label id="tituloLabel" runat="server" Text="Información de usuario"/>
						</th>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label1" runat="server" Text="Descripción:"/>
						</td>
						<td class="col" colspan="5">
							<asp:textbox CssClass="textbox" id="txtNombre" runat="server" Width="370px" Enabled="False" TabIndex="1"/>
							<asp:label id="lblValidaNombre" runat="server" Visible="False" Text="*" ForeColor="Red"/>
						</td>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label2" runat="server" Text="Usuario:"/>
						</td>
						<td class="col" colspan="2">
							<asp:textbox CssClass="textbox" id="txtLogin" tabIndex="2"	runat="server" Enabled="False"/>
						</td>
						<td>
							<asp:label id="lblValidaLogin" runat="server" Visible="False" Text="*" ForeColor="Red"/>
						</td>
						<td class="col-2" colspan="2">
							<asp:label CssClass="etiqueta" id="lblUsuarioRealStatus" runat="server" Text="(SÓLO LECTURA)" ForeColor="Red"/>
						</td>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label3" runat="server" Text="Contraseña:" />
						</td>
						<td class="col" colspan="2">
							<asp:textbox CssClass="textbox" id="txtContrasena" tabIndex="3" runat="server" Enabled="False" TextMode="Password"/>
						</td>
						<td>
							<asp:label id="lblValidaPassword1" runat="server" Visible="False" Text="*" ForeColor="Red"/>
						</td>
						<td class="col"></td>
						<td class="col"></td>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label4" runat="server" Text="Verificar contraseña:" />
						</td>
						<td class="col" colspan="2">
							<asp:textbox CssClass="textbox" id="txtVerificacionContrasena" runat="server" Enabled="False" TextMode="Password" TabIndex="4"/>
						</td>
						<td>
							<asp:label id="lblValidaPassword2" runat="server" Visible="False" Text="*" ForeColor="Red"/>						
						</td>
						<td class="col"></td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnSalvar" runat="server" Width="72px" Text="Salvar" Enabled="False" TabIndex="7"/>							
						</td>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label5" runat="server" Text="Rol asociado:" />
						</td>
						<td class="col" colspan="3">
							<asp:dropdownlist id="ddlstUsuarioVirtualAsociado" runat="server" Enabled="False" TabIndex="5"/>
						</td>
						<td class="col"></td>
						<td class="col">
							<asp:button id="btnCancelar" runat="server" Width="72px" Text="Cancelar" Enabled="False" TabIndex="8"/>
						</td>
					</tr>
					<tr>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label6" runat="server" Text="Unidades Administrativas asociadas:" />
						</td>
						<td class="col" colspan="5">
							<asp:listbox id="lbxUnidadesAdministrativas" runat="server" Width="232px" Enabled="False" SelectionMode="Multiple" TabIndex="6"/>
						</td>
					</tr>
					<tr>
						<td><br /></td>
					</tr>
					<tr>
						<td class="col"></td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnAgregar" runat="server" Width="72px" Text="Agregar" TabIndex="9"/>
						</td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnEditar" runat="server" Width="72px" Text="Editar" TabIndex="10"/>
						</td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnBorrar" runat="server" Width="72px" Text="Borrar" TabIndex="11"/>
						</td>
						<td class="col"></td>
						<td	class="col">
							<asp:button CssClass="etiqueta" id="btnRegresar" runat="server" Width="72px" Text="Regresar" TabIndex="12"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
