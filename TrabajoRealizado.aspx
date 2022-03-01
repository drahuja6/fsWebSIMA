<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TrabajoRealizado.aspx.vb" Inherits="fsWebS_SEN.TrabajoRealizado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>TrabajoRealizado</title>
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
			.editafecha {  
				width: 100px;
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
			}
			.col-15 {
				width: 15%;
				height: 30px;
			}
			.col-2 {
				width: 2%;
				height: 30px;
				text-align: center;
			}
			.col-14 {
				width: 14%;
				height: 30px;
			}
		    .col-11 {
                width: 11%;
                height: 30px;
            }
            .tabla {
                width: 600px;
            }
		    .panel {
                overflow: auto;
            }
			.separador {
				height:1px;
				border-top:1px solid;
			}
		</style> 
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<div>
				<table class="tabla">
					<tr>
						<th class="etiqueta-titulo" colspan="8">
							<asp:label id="Label6" runat="server" Text="Auditoría de expedientes y trabajo realizado" />
						</th>
					</tr>
					<tr>
						<td class="col-15" colspan="3">
							<asp:label CssClass="etiqueta" id="Label1" runat="server" Text="Expedientes registrados entre"/>
						</td>
						<td class="col-14">
							<asp:textbox CssClass="editafecha" id="txtFApertInic" runat="server" MaxLength="10" ToolTip="Formato dd/MM/aaaa"/>
							<asp:regularexpressionvalidator id="Regularexpressionvalidator1" runat="server" ErrorMessage="*" ControlToValidate="txtFApertInic"
								ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
						</td>
						<td class="col-2">
							<asp:label CssClass="etiqueta" id="Label2" runat="server" Text=" y "/>
						</td>
						<td class="col-14" colspan="2">
							<asp:textbox CssClass="editafecha" id="txtFApertFinal" runat="server" MaxLength="10" ToolTip="Formato dd/MM/aaaa"/>
							<asp:regularexpressionvalidator id="RegularExpressionValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtFApertFinal"
								ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
						</td>
						<td class="col-11">
							<asp:button CssClass="etiqueta" id="buscarButton" runat="server" Height="23px" Width="95px" Text="Buscar"/>
						</td>
					</tr>
					<tr>
						<td class="separador" colspan="8"></td>
					</tr>
					<tr>
						<td class="col-15" colspan="4">
							<asp:label CssClass="etiqueta" id="Label4" runat="server" Text="Totales por unidad administrativa"/>
						</td>
						<td colspan="3"></td>
						<td class="col-14">
							<asp:button CssClass="etiqueta" id="btnImpPorUA" runat="server" Height="23px" Width="95px" Text="Imprimir lista" ToolTip="Imprimir listado"/>
						</td>
					</tr>
					<tr>
						<td class="col-15" colspan="8">
							<asp:panel id="Panel1" runat="server" Height="240px" width="600px" CssClass="panel">
								<asp:datagrid id="DataGrid1" runat="server" Width="600px" AllowSorting="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
									<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
									<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
									<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
									<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
									<Columns>
										<asp:BoundColumn Visible="False" DataField="idunidadadministrativa" HeaderText="idUnidadAdministrativa"></asp:BoundColumn>
										<asp:BoundColumn DataField="Nombre" HeaderText="Unidad administrativa" HeaderStyle-Width="70%"/>
										<asp:BoundColumn DataField="TotPorUA" HeaderText="Total general de expedientes" HeaderStyle-Width="15%"/>
										<asp:BoundColumn DataField="EntreFechas" HeaderText="Total de expedientes entre fechas" HeaderStyle-Width="15%"/>
									</Columns>
								</asp:datagrid>
								<asp:Label CssClass="etiqueta" id="noHayDatosUnidadLabel" runat="server" Visible="False" Text="No hay datos que mostrar"/>
							</asp:panel>
						</td>
					</tr>
					<tr>
						<td class="separador" colspan="8"></td>
					</tr>
					<tr>
						<td class="col-15" colspan="4">
							<asp:label CssClass="etiqueta" id="Label5" runat="server" Text="Totales por usuario"/>
						</td>
						<td colspan="3"></td>
						<td class="col-14">
							<asp:button CssClass="etiqueta" id="btnImpPorUsuario" runat="server" Height="23px" Width="95px" Text="Imprimir lista" ToolTip="Imprimir listado"/>
						</td>
					</tr>
					<tr>
						<td class="col-15" colspan="8">
							<asp:panel CssClass="panel" id="Panel2" runat="server" Height="240px" Width="600px">
								<asp:datagrid id="Datagrid2" runat="server" Width="600px" AllowSorting="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
									<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
									<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
									<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
									<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
									<Columns>
										<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal"/>
										<asp:BoundColumn DataField="Nombre" HeaderText="Nombre Usuario" HeaderStyle-Width="70%"/>
										<asp:BoundColumn DataField="ExpCreados" HeaderText="Total de expedientes creados" HeaderStyle-Width="15%"/>
										<asp:BoundColumn DataField="ExpEditados" HeaderText="Total de expedientes editados" HeaderStyle-Width="15%"/>
									</Columns>
								</asp:datagrid>
								<asp:Label CssClass="etiqueta" id="noHayDatosUsuarioLabel" runat="server" Font-Bold="True" Visible="False" Text="No hay datos que mostrar"/>
							</asp:panel>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
