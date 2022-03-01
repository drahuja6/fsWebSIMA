<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UsuarioRealBuscar.aspx.vb" Inherits="fsWebS_SEN.UsuarioRealBuscar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>UsuarioRealBuscar</title>
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
				width: 160px;
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
			}
			.col {
				width: 20%;
				height: 30px;
			}
		</style> 
	</head>
	<body>
		<form id="Form1" method="post" runat="server" visible="true">
			<div>
				<table style="width: 480px">
					<tr>
						<th class="etiqueta-titulo" colspan="6">				
							<asp:label  id="Label1" runat="server" Text="Catálogo de usuarios del sistema"/>
						</th>
					</tr>
					<tr>
						<td class="col">
							<asp:textbox CssClass="textbox" id="txbFiltro" runat="server" ToolTip="Secuencia por buscar (vacío para devolver todo)"/>
						</td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnBuscar" runat="server" Text="Buscar" ToolTip="Buscar usuario(s)" Width="95px" Height="23px"/>
						</td>
						<td class="col"/>
						<td class="col" colspan="2">
							<asp:Button CssClass="etiqueta" id="Button1" runat="server" Text="Edición de usuarios" ToolTip="Permite ver directamente la ventana de edición de usuarios, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)" Width="160px"/>
						</td>
						<td class="col"/>
					</tr>
					<tr>
						<td class="col" colspan="6">
							<asp:Panel id="Panel1" runat="server" Width="480px" Height="250px">
								<asp:datagrid id="DataGrid1" Width="480px" runat="server" AllowSorting="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
									<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
									<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
									<Columns>
										<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Select"/>
										<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal"/>
										<asp:BoundColumn DataField="Login" HeaderText="Nombre"/>
										<asp:BoundColumn DataField="Nombre" HeaderText="Descripción"/>
									</Columns>
								</asp:datagrid>
							</asp:Panel>
						</td>
					</tr>
					<tr>
						<td class="col" colspan="6">
							<asp:Label CssClass="etiqueta" id="NoHayDatos" runat="server" Font-Bold="True" Visible="False" Text="No hay datos que mostrar" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
