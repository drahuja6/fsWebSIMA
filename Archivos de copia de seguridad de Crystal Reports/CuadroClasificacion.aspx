<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CuadroClasificacion.aspx.vb" Inherits="fsWebS_SEN.CuadroClasificacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>CuadroClasificacion</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ccffff">
			<asp:label id="Label1" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Size="Large" Font-Bold="True">Catálogo de Disposición Documental</asp:label>
			<asp:textbox id="txbFiltro" style="Z-INDEX: 103; LEFT: 480px; POSITION: absolute; TOP: 8px" runat="server"></asp:textbox>
			<asp:label id="Label2" style="Z-INDEX: 104; LEFT: 432px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Bold="True">Filtro:</asp:label>
			<asp:button id="btnAplicar" style="Z-INDEX: 105; LEFT: 640px; POSITION: absolute; TOP: 8px"
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
			</asp:Panel>
		</form>
	</body>
</html>
