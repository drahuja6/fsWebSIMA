<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TrabajoRealizado.aspx.vb" Inherits="fsWebS_SEN.TrabajoRealizado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>TrabajoRealizado</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
			<asp:label id="Label1" style="Z-INDEX: 100; LEFT: 24px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Bold="True" Height="24px" Width="488px">Totales de Expedientes con Fecha de Creación entre</asp:label>
			<asp:button id="btnImpPorUsuario" style="Z-INDEX: 114; LEFT: 544px; POSITION: absolute; TOP: 320px"
				runat="server" Height="23px" Width="72px" Enabled="False" Text="Imp. Lista"></asp:button>
			<asp:button id="btnImpPorUA" style="Z-INDEX: 113; LEFT: 544px; POSITION: absolute; TOP: 112px"
				runat="server" Height="23px" Width="72px" Enabled="False" Text="Imp. Lista"></asp:button>
			<asp:regularexpressionvalidator id="Regularexpressionvalidator1" style="Z-INDEX: 111; LEFT: 360px; POSITION: absolute; TOP: 48px"
				runat="server" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"
				ErrorMessage="*" ControlToValidate="txtFApertInic"></asp:regularexpressionvalidator>
			<asp:regularexpressionvalidator id="RegularExpressionValidator2" style="Z-INDEX: 110; LEFT: 360px; POSITION: absolute; TOP: 80px"
				runat="server" Width="1px" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"
				ErrorMessage="*" ControlToValidate="txtFApertFinal"></asp:regularexpressionvalidator>
			<asp:panel id="Panel2" style="Z-INDEX: 109; LEFT: 16px; OVERFLOW: auto; POSITION: absolute; TOP: 352px"
				runat="server" Height="144px" Width="664px" BorderStyle="Ridge">
				<asp:datagrid id="Datagrid2" runat="server" Height="192px" Width="598px" BorderStyle="Ridge" BorderColor="Black"
					BorderWidth="1px" AllowSorting="True" AutoGenerateColumns="False">
					<AlternatingItemStyle Wrap="False" BackColor="#E0E0E0"></AlternatingItemStyle>
					<ItemStyle Wrap="False"></ItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal"></asp:BoundColumn>
						<asp:BoundColumn DataField="Nombre" HeaderText="Nombre Usuario">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="ExpCreados" HeaderText="Tot. Exp. Creados entre fechas">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="ExpEditados" HeaderText="Tot. Exp. Editados entre fechas"></asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos2" runat="server" Font-Bold="True" Visible="False">No hay datos que mostrar</asp:Label>
			</asp:panel>
			<asp:label id="Label5" style="Z-INDEX: 108; LEFT: 24px; POSITION: absolute; TOP: 320px" runat="server"
				Font-Bold="True" Height="24px" Width="208px">Por Usuario</asp:label>
			<asp:label id="Label4" style="Z-INDEX: 107; LEFT: 24px; POSITION: absolute; TOP: 120px" runat="server"
				Font-Bold="True" Height="24px" Width="208px">Por Unidad Administrativa</asp:label>
			<asp:button id="Button1" style="Z-INDEX: 106; LEFT: 384px; POSITION: absolute; TOP: 80px" runat="server"
				Height="23px" Width="72px" Text="Busca"></asp:button>
			<asp:textbox id="txtFApertFinal" style="Z-INDEX: 105; LEFT: 200px; POSITION: absolute; TOP: 80px"
				tabIndex="3" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>
			<asp:label id="Label3" style="Z-INDEX: 104; LEFT: 24px; POSITION: absolute; TOP: 80px" runat="server"
				Height="24px" Width="168px">Fecha final (dd/mm/aaaa)</asp:label>
			<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 24px; POSITION: absolute; TOP: 48px" runat="server"
				Height="24px" Width="168px">Fecha inicial (dd/mm/aaaa)</asp:label>
			<asp:textbox id="txtFApertInic" style="Z-INDEX: 102; LEFT: 200px; POSITION: absolute; TOP: 48px"
				tabIndex="3" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>
			<asp:panel id="Panel1" style="Z-INDEX: 101; LEFT: 16px; OVERFLOW: auto; POSITION: absolute; TOP: 144px"
				runat="server" Height="152px" Width="664px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" Height="176px" Width="598px" BorderStyle="Ridge" BorderColor="Black"
					BorderWidth="1px" AllowSorting="True" AutoGenerateColumns="False">
					<AlternatingItemStyle Wrap="False" BackColor="#E0E0E0"></AlternatingItemStyle>
					<ItemStyle Wrap="False"></ItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:BoundColumn Visible="False" DataField="idunidadadministrativa" HeaderText="idUnidadAdministrativa"></asp:BoundColumn>
						<asp:BoundColumn DataField="Nombre" HeaderText="Unid. Adm.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="TotPorUA" HeaderText="Tot. Exp.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="EntreFechas" HeaderText="Tot. entre fechas"></asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Font-Bold="True" Visible="False">No hay datos que mostrar</asp:Label>
			</asp:panel>
		</form>
	</body>
</html>
