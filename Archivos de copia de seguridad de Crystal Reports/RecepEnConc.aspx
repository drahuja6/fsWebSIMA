<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RecepEnConc.aspx.vb" Inherits="fsWebS_SEN.RecepEnConc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>RecepEnConc</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
			<asp:label id="lblFechaDeCorteVigente" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Bold="True" Font-Size="Large">Recepción de Lotes en Concentración</asp:label>
			<asp:label id="lblValidaLoteAtendidoEImpreso" style="Z-INDEX: 118; LEFT: 392px; POSITION: absolute; TOP: 496px"
				runat="server" Font-Size="Large" Width="3px" Text="*" Height="3px" Visible="False" ForeColor="Red">*</asp:label>
			<asp:button id="btnFinalizarLote" style="Z-INDEX: 117; LEFT: 264px; POSITION: absolute; TOP: 496px"
				runat="server" Width="120px" Text="(5) Finalizar Lote" ToolTip="Finalizar el Lote"></asp:button>
			<asp:button id="btnBuscaLotes" style="Z-INDEX: 116; LEFT: 424px; POSITION: absolute; TOP: 40px"
				runat="server" Text="(1) Buscar Lotes"></asp:button>
			<asp:label id="Label2" style="Z-INDEX: 115; LEFT: 16px; POSITION: absolute; TOP: 40px" runat="server"
				Width="144px" Height="8px">Unidad Administrativa:</asp:label>
			<asp:dropdownlist id="ddlUnidAdm" style="Z-INDEX: 114; LEFT: 176px; POSITION: absolute; TOP: 40px"
				tabIndex="11" runat="server" Width="240px" AutoPostBack="True"></asp:dropdownlist>
			<asp:label id="lblValidaLoteAtendido" style="Z-INDEX: 113; LEFT: 144px; POSITION: absolute; TOP: 496px"
				runat="server" Font-Size="Large" Width="3px" Text="*" Height="3px" Visible="False" ForeColor="Red">*</asp:label>
			<asp:label id="lblValidaCajaConc" style="Z-INDEX: 111; LEFT: 696px; POSITION: absolute; TOP: 288px"
				runat="server" Font-Size="Large" Width="3px" Text="*" Height="3px" Visible="False" ForeColor="Red">*</asp:label>
			<asp:button id="btnImprimeResguardo" style="Z-INDEX: 110; LEFT: 16px; POSITION: absolute; TOP: 496px"
				runat="server" Width="120px" Text="(4) Imprimir Resg." ToolTip="Imprimir Resguardo"></asp:button>
			<asp:button id="btnRevisaExp" style="Z-INDEX: 109; LEFT: 768px; POSITION: absolute; TOP: 72px"
				runat="server" Text="Revisar Exp"></asp:button>
			<asp:button id="btnQuitar" style="Z-INDEX: 108; LEFT: 776px; POSITION: absolute; TOP: 496px"
				runat="server" Text="Quitar Exp"></asp:button>
			<asp:listbox id="lbExpConCajaConc" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 320px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox>
			<asp:button id="btnAsignaCajaConc" style="Z-INDEX: 106; LEFT: 720px; POSITION: absolute; TOP: 288px"
				runat="server" Width="140px" Text="(3) Asignar caja Conc"></asp:button>
			<asp:textbox id="txtCajaConc" style="Z-INDEX: 105; LEFT: 640px; POSITION: absolute; TOP: 288px"
				runat="server" Width="56px"></asp:textbox>
			<asp:listbox id="lbExpDelLote" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 112px"
				runat="server" Width="862px" Height="176px" SelectionMode="Multiple"></asp:listbox>
			<asp:button id="btnBuscaLote" style="Z-INDEX: 103; LEFT: 624px; POSITION: absolute; TOP: 72px"
				runat="server" Text="(2) Traer Lote"></asp:button>
			<asp:dropdownlist id="ddlBatches" style="Z-INDEX: 101; LEFT: 136px; POSITION: absolute; TOP: 72px"
				tabIndex="11" runat="server" Width="482px" AutoPostBack="True"></asp:dropdownlist>
			<asp:label id="Label1" style="Z-INDEX: 102; LEFT: 16px; POSITION: absolute; TOP: 72px" runat="server"
				Width="112px" Height="8px">Lotes por atender:</asp:label>
		</form>
	</body>
</html>
