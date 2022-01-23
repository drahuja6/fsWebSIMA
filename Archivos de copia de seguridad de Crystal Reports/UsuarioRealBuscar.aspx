<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UsuarioRealBuscar.aspx.vb" Inherits="fsWebS_SEN.UsuarioRealBuscar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>UsuarioRealBuscar</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
			<asp:label id="Label1" style="Z-INDEX: 101; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Size="Large" Font-Bold="True" Width="80px">Usuarios</asp:label>
			<asp:label id="Label2" style="Z-INDEX: 102; LEFT: 152px; POSITION: absolute; TOP: 16px" runat="server"
				Font-Bold="True" Width="112px" Height="8px">Filtro (Nombre):</asp:label>
			<asp:textbox id="txbFiltro" style="Z-INDEX: 103; LEFT: 264px; POSITION: absolute; TOP: 8px" runat="server"></asp:textbox>
			<asp:button id="btnBuscar" style="Z-INDEX: 104; LEFT: 424px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Bold="True" Text="Buscar"></asp:button>
			<asp:Panel id="Panel1" style="Z-INDEX: 106; LEFT: 16px; POSITION: absolute; TOP: 48px" runat="server"
				Width="850px" Height="430px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" BorderStyle="Ridge" BorderColor="Black" BorderWidth="1px"
					AutoGenerateColumns="False">
					<AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:ButtonColumn Text="Ir a" ButtonType="PushButton" CommandName="Select">
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:ButtonColumn>
						<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal">
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Login" HeaderText="Login">
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Nombre" HeaderText="Nombre">
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Font-Bold="True" Visible="False">No hay datos que mostrar</asp:Label>
			</asp:Panel>
			<asp:Button id="Button1" style="Z-INDEX: 107; LEFT: 528px; POSITION: absolute; TOP: 8px" runat="server"
				Text="Ver ventana de edición de usuarios" ToolTip="Permite ver directamente la ventana de edición de usuarios, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)"></asp:Button>
		</form>
	</body>
</html>
