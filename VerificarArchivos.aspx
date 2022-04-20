<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VerificarArchivos.aspx.vb" Inherits="fsWebS_SEN.VerificarArchivos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verificar archivos</title>
	<script type="text/javascript">
        function setHourglass() {
            document.body.style.cursor = 'wait';
        }
    </script>
		<style type="text/css">
			[class*="etiqueta"] {
				font-size: smaller;
				font-weight:700;
				font-family: Arial, Helvetica, sans-serif;
				color:navy;
				vertical-align:central;
			}
			.etiqueta-titulo {  
				font-size: medium;
				color: white;
				background-color: #5D7B9D;
				height: 40px;
            }  
			.etiqueta-boton {  
				align-self:center;
				float:right;
				display:inline;		
            }  
			.etiqueta-textbox {  
				width: 70px;
				font-weight: 500;
			}
			.col {
				height: 30px;
			}
			[class*="grid"] {
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
				text-align:center;
			}
			.grid-ua {
				width:28%;
				text-align:unset;
			}
			.grid-datos {
				width:9%;		
			}
			.error
			{
				color:red;
			}
		</style> 
</head>
<body>
    <form id="form1" runat="server" onsubmit="return setHourglass()">
        <div>
			<table>
				<tr>
					<th class="etiqueta-titulo" colspan="6">
						<asp:Label ID="lblTitulo" runat="server" Text="Expedientes e imágenes vinculadas" />
					</th>
				</tr>
				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblTotalExpedientes" runat="server" Text="Expedientes en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtTotalExpedientes" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="Label3" runat="server" Text="Aplica digitalización:" />
					</td>
					<td>
						<asp:TextBox ID="txtAplicaDigitalizacion" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="Label4" runat="server" Text="No aplica digitalización:" />
					</td>
					<td>
						<asp:TextBox ID="txtNoAplicaDigitalizacion" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:Label CssClass="etiqueta" ID="lblTituloAplicaDigitalizacion" runat="server" Text="Detalle de expedientes en que aplica digitalización:" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblExpedientesConArchivos" runat="server" Text="Expedientes con información en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtExpedientesConArchivos" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta error" ID="lblExpedientesSinArchivos" runat="server" Text="Expedientes sin información en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtExpedientesSinArchivos" runat="server" Enabled="false" CssClass="etiqueta-textbox error" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblImagenesEsperadas" runat="server" Text="Archivos de imagen esperados:" />
					</td>
					<td>
						<asp:TextBox ID="txtImagenesEsperadas" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblArchivosLocalizados" runat="server" Text="Archivos de imagen localizados:" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosLocalizados" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta error" ID="lblArchivosNoLocalizados" runat="server" Text="Archivos de imagen no localizados:" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosNoLocalizados" runat="server" Enabled="false" CssClass="etiqueta-textbox error" />
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:Label CssClass="etiqueta" ID="lblTituloDetalle" runat="server" Text="Detalle de expedientes por Unidad administrativa:" />
					</td>
				</tr>
				<tr>
					<td class="col" colspan="6">
						<asp:Panel ID="panDetalle" runat="server">
							<asp:GridView ID="grvDetalle" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">

							    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="Descripcion" HeaderText="Unidad administrativa" ItemStyle-CssClass="grid-ua" />
                                    <asp:BoundField DataField="TotalExpedientesBD" HeaderText="Expedientes cargados" ItemStyle-CssClass="grid-datos" />
                                    <asp:BoundField DataField="SinDigitalizacion" HeaderText="No aplica digitalización" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ConDigitalizacion" HeaderText="Aplica digitalización" ItemStyle-CssClass="grid-datos" />
                                    <asp:BoundField DataField="ExpedientesConArchivoBD" HeaderText="Con información en BD" ItemStyle-CssClass="grid-datos" />
                                    <asp:BoundField DataField="ExpedientesSinArchivoBD" HeaderText="Sin información en BD" ItemStyle-CssClass="grid-datos error" />
                                    <asp:BoundField DataField="TotalImagenes" HeaderText="Imágenes esperadas" ItemStyle-CssClass="grid-datos" />
                                    <asp:BoundField DataField="ArchivosLocalizadosFS" HeaderText="Imágenes localizadas" ItemStyle-CssClass="grid-datos" />
                                    <asp:BoundField DataField="ArchivosNoLocalizadosFS" HeaderText="Imágenes no localizadas" ItemStyle-CssClass="grid-datos error" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Underline="true" Font-Size="Smaller" />
                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

							</asp:GridView>
						</asp:Panel>
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>
				<tr>
					<td></td>
					<td class="col" colspan="2" >
						<asp:Button ID="btnIniciarVerificacion" runat="server" Text="Iniciar verificación" CssClass="etiqueta-boton" />
					</td>
					<td></td>
					<td>
						<asp:Label ID="lblVerificados" runat="server" Text="Nuevos archivos localizados:" CssClass="etiqueta" />
					</td>
					<td>
                        <asp:TextBox ID="txtVerificados" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
				</tr>
			</table>
        </div>
    </form>
</body>
</html>
