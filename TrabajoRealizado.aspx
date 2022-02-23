<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TrabajoRealizado.aspx.vb" Inherits="fsWebS_SEN.TrabajoRealizado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>TrabajoRealizado</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
            <asp:Panel ID="Panel3" runat="server" Font-Size="Small">
				<asp:label id="Label1" style="Z-INDEX: 100; LEFT: 24px; POSITION: absolute; TOP: 16px" runat="server"
					Font-Bold="False" Height="24px" Width="488px" Text="Totales de expedientes con fecha de alta en el rango entre:" />
				<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 24px; POSITION: absolute; TOP: 51px" runat="server"
					Height="24px" Width="168px" Text="Fecha inicial (dd/mm/aaaa)"/>
				<asp:textbox id="txtFApertInic" style="Z-INDEX: 102; LEFT: 200px; POSITION: absolute; TOP: 48px; width: 148px;"
					tabIndex="1" runat="server" Height="20px" BorderStyle="Ridge" MaxLength="10"/>
				<asp:regularexpressionvalidator id="Regularexpressionvalidator1" style="Z-INDEX: 111; LEFT: 360px; POSITION: absolute; TOP: 48px"
					runat="server" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"
					ErrorMessage="*" ControlToValidate="txtFApertInic"/>
				<asp:label id="Label3" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 80px" runat="server"
					Height="24px" Width="168px" Text="Fecha final (dd/mm/aaaa)"/>
				<asp:textbox id="txtFApertFinal" style="Z-INDEX: 105; LEFT: 200px; POSITION: absolute; TOP: 80px; width: 148px;"
					tabIndex="2" runat="server" Height="20px" BorderStyle="Ridge" MaxLength="10"/>
				<asp:regularexpressionvalidator id="RegularExpressionValidator2" style="Z-INDEX: 110; LEFT: 360px; POSITION: absolute; TOP: 80px"
					runat="server" Width="1px" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"
					ErrorMessage="*" ControlToValidate="txtFApertFinal"/>
				<asp:button id="buscarButton" style="Z-INDEX: 106; LEFT: 382px; POSITION: absolute; TOP: 81px" runat="server"
					Height="23px" Width="72px" Text="Busca" TabIndex="3"/>
				<asp:label id="Label4" style="Z-INDEX: 107; LEFT: 19px; POSITION: absolute; TOP: 120px" runat="server"
					Font-Bold="True" Height="24px" Width="208px" Text="Totales por unidad administrativa"/>
				<asp:button id="btnImpPorUA" style="Z-INDEX: 113; LEFT: 731px; POSITION: absolute; TOP: 117px"
					runat="server" Height="23px" Width="72px" Enabled="False" Text="Imp. Lista" TabIndex="4" ToolTip="Imprimir listado"/>
				<asp:panel id="Panel1" style="Z-INDEX: 101; LEFT: 16px; OVERFLOW: auto; POSITION: absolute; TOP: 144px; width: 780px;"
					runat="server" Height="240px" BorderStyle="Ridge">
					<asp:datagrid id="DataGrid1" runat="server" Height="192px" Width="780px" AllowSorting="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
						<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
						<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
						<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
						<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
						<Columns>
							<asp:BoundColumn Visible="False" DataField="idunidadadministrativa" HeaderText="idUnidadAdministrativa"></asp:BoundColumn>
							<asp:BoundColumn DataField="Nombre" HeaderText="Unid. Adm.">
								<HeaderStyle Width="70%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="TotPorUA" HeaderText="Total general de expedientes">
								<HeaderStyle Width="15%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="EntreFechas" HeaderText="Total de expedientes entre fechas">
								<HeaderStyle Width="15%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
						</Columns>
					</asp:datagrid>
					<asp:Label id="noHayDatosUnidadLabel" runat="server" Font-Bold="True" Visible="False" Text="No hay datos que mostrar"/>
				</asp:panel>
				<asp:label id="Label5" style="Z-INDEX: 108; LEFT: 22px; POSITION: absolute; TOP: 428px" runat="server"
					Font-Bold="True" Height="24px" Width="208px" Text="Totales por usuario"/>
				<asp:button id="btnImpPorUsuario" style="Z-INDEX: 114; LEFT: 732px; POSITION: absolute; TOP: 429px; right: 127px;"
					runat="server" Height="23px" Width="72px" Enabled="False" Text="Imp. Lista" TabIndex="5" ToolTip="Imprimir listado"></asp:button>
				<asp:panel id="Panel2" style="overflow:auto; POSITION: absolute; TOP: 457px; LEFT: 17px; width: 780px;"
					runat="server" Height="240px" BorderStyle="Ridge">
					<asp:datagrid id="Datagrid2" runat="server" Height="192px" Width="780px" AllowSorting="false" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
						<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
						<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
						<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
						<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
						<Columns>
							<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal"></asp:BoundColumn>
							<asp:BoundColumn DataField="Nombre" HeaderText="Nombre Usuario">
								<HeaderStyle Width="70%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="ExpCreados" HeaderText="Total de expedientes creados">
								<HeaderStyle Width="15%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="ExpEditados" HeaderText="Total de expedientes editados">
								<HeaderStyle Width="15%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
						</Columns>
					</asp:datagrid>
					<asp:Label id="noHayDatosUsuarioLabel" runat="server" Font-Bold="True" Visible="False">No hay datos que mostrar</asp:Label>
				</asp:panel>
			</asp:Panel>
		</form>
	</body>
</html>
