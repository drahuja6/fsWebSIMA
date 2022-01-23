<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UsuarioRealDisplay.aspx.vb" Inherits="fsWebS_SEN.UsuarioRealDisplay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>UsuarioRealDisplay</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
			<asp:label id="Label1" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Bold="True" Width="56px" Height="16px">Nombre</asp:label>
			<asp:button id="btnRegresar" style="Z-INDEX: 123; LEFT: 416px; POSITION: absolute; TOP: 256px"
				runat="server" Width="72px" Text="Regresar"></asp:button>
			<asp:label id="lblValidaNombre" style="Z-INDEX: 122; LEFT: 488px; POSITION: absolute; TOP: 8px"
				runat="server" Width="1px" Height="3px" Visible="False" Text="*" ForeColor="Red">*</asp:label>
			<asp:label id="lblValidaLogin" style="Z-INDEX: 121; LEFT: 248px; POSITION: absolute; TOP: 40px"
				runat="server" Width="1px" Height="3px" Visible="False" Text="*" ForeColor="Red">*</asp:label>
			<asp:label id="lblValidaPassword2" style="Z-INDEX: 120; LEFT: 312px; POSITION: absolute; TOP: 104px"
				runat="server" Width="1px" Height="3px" Visible="False" Text="*" ForeColor="Red">*</asp:label>
			<asp:label id="lblValidaPassword1" style="Z-INDEX: 119; LEFT: 312px; POSITION: absolute; TOP: 72px"
				runat="server" Width="1px" Height="3px" Visible="False" Text="*" ForeColor="Red">*</asp:label>
			<asp:label id="lblUsuarioRealStatus" style="Z-INDEX: 118; LEFT: 320px; POSITION: absolute; TOP: 40px"
				runat="server" Font-Bold="False" Width="160px" Text="(SÓLO LECTURA)" ForeColor="Red">(SÓLO LECTURA)</asp:label>
			<asp:button id="btnCancelar" style="Z-INDEX: 117; LEFT: 408px; POSITION: absolute; TOP: 96px"
				runat="server" Width="72px" Text="Cancelar" Enabled="False"></asp:button>
			<asp:button id="btnSalvar" style="Z-INDEX: 116; LEFT: 408px; POSITION: absolute; TOP: 72px"
				runat="server" Width="72px" Text="Salvar" Enabled="False"></asp:button>
			<asp:button id="btnBorrar" style="Z-INDEX: 115; LEFT: 296px; POSITION: absolute; TOP: 256px"
				runat="server" Width="72px" Text="Borrar"></asp:button>
			<asp:button id="btnEditar" style="Z-INDEX: 113; LEFT: 216px; POSITION: absolute; TOP: 256px"
				runat="server" Width="72px" Text="Editar"></asp:button>
			<asp:button id="btnAgregar" style="Z-INDEX: 112; LEFT: 136px; POSITION: absolute; TOP: 256px"
				runat="server" Width="72px" Text="Agregar"></asp:button>
			<asp:listbox id="lbxUnidadesAdministrativas" style="Z-INDEX: 111; LEFT: 256px; POSITION: absolute; TOP: 168px"
				runat="server" Width="232px" Enabled="False" SelectionMode="Multiple"></asp:listbox>
			<asp:label id="Label6" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 168px" runat="server"
				Font-Bold="True" Width="256px" Height="24px">Unidades Administrativas asociadas</asp:label>
			<asp:dropdownlist id="ddlstUsuarioVirtualAsociado" style="Z-INDEX: 109; LEFT: 216px; POSITION: absolute; TOP: 136px"
				runat="server" Width="272px" Enabled="False"></asp:dropdownlist>
			<asp:label id="Label5" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 136px" runat="server"
				Font-Bold="True" Width="200px" Height="16px">Usuario Virtual asociado (rol)</asp:label>
			<asp:label id="Label4" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 104px" runat="server"
				Font-Bold="True" Width="144px" Height="16px">Verificar contraseña</asp:label>
			<asp:textbox id="txtVerificacionContrasena" style="Z-INDEX: 106; LEFT: 160px; POSITION: absolute; TOP: 104px"
				tabIndex="1" runat="server" Width="152px" Height="20px" Text="" Enabled="False" TextMode="Password"></asp:textbox>
			<asp:textbox id="txtContrasena" style="Z-INDEX: 105; LEFT: 160px; POSITION: absolute; TOP: 72px"
				tabIndex="1" runat="server" Width="152px" Height="20px" Text="" Enabled="False" TextMode="Password"></asp:textbox>
			<asp:label id="Label3" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 72px" runat="server"
				Font-Bold="True" Width="80px" Height="16px">Contraseña</asp:label>
			<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 40px" runat="server"
				Font-Bold="True" Width="56px" Height="16px">Login</asp:label>
			<asp:textbox id="txtLogin" style="Z-INDEX: 102; LEFT: 96px; POSITION: absolute; TOP: 40px" tabIndex="1"
				runat="server" Width="152px" Height="20px" Text="" Enabled="False"></asp:textbox>
			<asp:textbox id="txtNombre" style="Z-INDEX: 101; LEFT: 96px; POSITION: absolute; TOP: 8px" tabIndex="1"
				runat="server" Width="392px" Height="20px" Text="" Enabled="False"></asp:textbox>
		</form>
	</body>
</html>
