<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ExpVencidos.aspx.vb" Inherits="fsWebSIMA.ExpVencidos" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>ExpVencidos</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<asp:Label id="Label1" style="Z-INDEX: 100; LEFT: 16px; POSITION: absolute; TOP: 24px" runat="server"
				Width="488px" Height="24px" Font-Bold="True">Total de Expedientes Vencidos al día de hoy por Unidad Administrativa</asp:Label>
			<asp:Label id="Label4" style="Z-INDEX: 105; LEFT: 16px; POSITION: absolute; TOP: 280px" runat="server"
				Width="200px" Height="24px">En Concentración (VEC):</asp:Label>
			<asp:panel id="Panel2" style="Z-INDEX: 104; LEFT: 16px; OVERFLOW: auto; POSITION: absolute; TOP: 304px"
				runat="server" Width="664px" Height="152px" BorderStyle="Ridge">
				<asp:datagrid id="Datagrid2" runat="server" Width="598px" Height="176px" BorderStyle="Ridge" AutoGenerateColumns="False"
					AllowSorting="True" BorderWidth="1px" BorderColor="Black">
					<AlternatingItemStyle Wrap="False" BackColor="#E0E0E0"></AlternatingItemStyle>
					<ItemStyle Wrap="False"></ItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:BoundColumn DataField="UnidAdm" HeaderText="Unid. Adm.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Total" HeaderText="Total"></asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="Label3" runat="server" Visible="False" Font-Bold="True">No hay datos que mostrar</asp:Label>
			</asp:panel>
			<asp:Label id="Label2" style="Z-INDEX: 103; LEFT: 16px; POSITION: absolute; TOP: 64px" runat="server"
				Width="136px" Height="24px">En Trámite (VET):</asp:Label>
			<asp:panel id="Panel1" style="Z-INDEX: 101; LEFT: 16px; OVERFLOW: auto; POSITION: absolute; TOP: 88px"
				runat="server" Width="664px" Height="152px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" Width="598px" Height="176px" BorderStyle="Ridge" AutoGenerateColumns="False"
					AllowSorting="True" BorderWidth="1px" BorderColor="Black">
					<AlternatingItemStyle Wrap="False" BackColor="#E0E0E0"></AlternatingItemStyle>
					<ItemStyle Wrap="False"></ItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:BoundColumn DataField="UnidAdm" HeaderText="Unid. Adm.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Total" HeaderText="Total"></asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Visible="False" Font-Bold="True">No hay datos que mostrar</asp:Label>
			</asp:panel>
		</form>
	</body>
</HTML>
