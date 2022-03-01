<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CuadroClasificacion.aspx.vb" Inherits="fsWebS_SEN.CuadroClasificacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>CuadroClasificacion</title>
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
            }  
			.textbox {  
				width: 160px;
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
			}
			.col {
				width: 15%;
				height: 30px;
			}
		</style> 
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<div>
				<table style="width: 600px">
					<tr>
						<th class="etiqueta-titulo" colspan="6">				
							<asp:label  id="Label3" runat="server" Text="Catálogo de disposición documental"/>
						</th>
					</tr>
					<tr>
						<td class="col">
							<asp:textbox class="textbox" id="txbFiltro" runat="server"/>
						</td>
						<td class="col">
							<asp:button CssClass="etiqueta" id="btnAplicar" runat="server" Text="Buscar" Width="95px"/>
						</td>
						<td class="col" colspan="4"/>
					</tr>
					<tr>
						<td class="col" colspan="6">
							<asp:Panel id="Panel1" runat="server" Width="600px" Height="430px" Style="overflow:auto">
								<asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" Width="600px" PageSize="15" AllowPaging="False">
									<AlternatingItemStyle Wrap="False" BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#284775"></AlternatingItemStyle>
									<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
									<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
									<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
									<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
									<Columns>
										<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Select"/>
										<asp:BoundColumn DataField="NombreDeJerarquia" HeaderText="C&#243;digo"/>
										<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n"/>
										<asp:BoundColumn Visible="False" DataField="idClasificacion" />
									</Columns>
								    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Position="TopAndBottom" Visible="False" />
				                    <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
								</asp:datagrid>
							</asp:Panel>
						</td>
					</tr>
					<tr>
						<td class="col" colspan="6">
							<asp:Label CssClass="etiqueta" id="NoHayDatos" runat="server" Visible="False" Text="No hay datos que mostrar"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
