<%@ Register TagPrefix="cc1" Namespace="skmDataGrid" Assembly="skmDataGrid" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EscogeCuadro.aspx.vb" Inherits="fsWebS_SEN.EscogeCuadro" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>EscogeCuadro</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<asp:Panel id="Panel1" style="Z-INDEX: 106; LEFT: 8px; OVERFLOW: auto; POSITION: absolute; TOP: 40px"
				runat="server" Width="850px" Height="430px" BorderStyle="Ridge">
				<P>
					<cc1:PrettyDataGrid id="PrettyDataGrid1" runat="server" BorderStyle="Ridge" AutoGenerateColumns="False"
						BorderColor="Black" BorderWidth="1px" RowHighlightColor="#FFC080" RowClickEventCommandName="PrettyDataGrid1_ItemCommand">
						<AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
						<Columns>
							<asp:BoundColumn DataField="NombreDeJerarquia" HeaderText="C&#243;digo"></asp:BoundColumn>
							<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n"></asp:BoundColumn>
						</Columns>
						<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					</cc1:PrettyDataGrid></P>
				<P>
					<asp:Label id="NoHayDatos" runat="server" Width="184px" Visible="False" Font-Bold="True">No hay datos que mostrar</asp:Label></P>
			</asp:Panel>
			<asp:button id="btnAplicar" style="Z-INDEX: 110; LEFT: 640px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Bold="True" Text="Buscar"></asp:button>
			<asp:textbox id="txbFiltro" style="Z-INDEX: 109; LEFT: 480px; POSITION: absolute; TOP: 8px" runat="server"></asp:textbox>
			<asp:label id="Label2" style="Z-INDEX: 108; LEFT: 432px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Bold="True">Filtro:</asp:label>
			<asp:label id="Label1" style="Z-INDEX: 107; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Bold="True" Font-Size="Large">Catálogo de Disposición Documental</asp:label>
		</form>
	</body>
</HTML>
