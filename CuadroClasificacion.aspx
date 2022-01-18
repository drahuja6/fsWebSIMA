<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CuadroClasificacion.aspx.vb" Inherits="fsWebS_SEN.CuadroClasificacion" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>CuadroClasificacion</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ccffff" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label1" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Size="Large" Font-Bold="True">Catálogo de Disposición Documental</asp:label><asp:textbox id="txbFiltro" style="Z-INDEX: 103; LEFT: 480px; POSITION: absolute; TOP: 8px" runat="server"></asp:textbox><asp:label id="Label2" style="Z-INDEX: 104; LEFT: 432px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Bold="True">Filtro:</asp:label><asp:button id="btnAplicar" style="Z-INDEX: 105; LEFT: 640px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Bold="True" Text="Buscar"></asp:button>
			<asp:Panel id="Panel1" style="Z-INDEX: 106; LEFT: 8px; OVERFLOW: auto; POSITION: absolute; TOP: 40px"
				runat="server" Width="850px" Height="430px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" BorderStyle="Ridge" AutoGenerateColumns="False" BorderColor="Black"
					BorderWidth="1px">
					<SelectedItemStyle BackColor="Red"></SelectedItemStyle>
					<AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:ButtonColumn Text="Ir a" ButtonType="PushButton" CommandName="Select"></asp:ButtonColumn>
						<asp:BoundColumn DataField="NombreDeJerarquia" HeaderText="C&#243;digo"></asp:BoundColumn>
						<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n"></asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="idClasificacion" HeaderText="idClasificacion"></asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Font-Bold="True" Width="184px" Visible="False">No hay datos que mostrar</asp:Label>
			</asp:Panel></form>
	</body>
</HTML>
