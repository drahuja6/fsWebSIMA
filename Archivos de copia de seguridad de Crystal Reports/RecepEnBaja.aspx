<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RecepEnBaja.aspx.vb" Inherits="fsWebS_SEN.RecepEnBaja" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>RecepEnBaja</title>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" bgcolor="#ffffff">
			<asp:label id="lblFechaDeCorteVigente" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Size="Large" Font-Bold="True">Recepción de Lotes propuestos para Baja</asp:label>
			<asp:button id="btnQuitar" style="Z-INDEX: 116; LEFT: 776px; POSITION: absolute; TOP: 496px"
				runat="server" Text="Quitar Exp"></asp:button>
			<asp:button id="btnImprimeResguardo" style="Z-INDEX: 115; LEFT: 16px; POSITION: absolute; TOP: 496px"
				runat="server" Text="(4) Imprimir Resg." ToolTip="Imprimir Resguardo" Width="120px"></asp:button>
			<asp:label id="lblValidaLoteAtendido" style="Z-INDEX: 112; LEFT: 144px; POSITION: absolute; TOP: 496px"
				runat="server" Font-Size="Large" Text="*" Width="3px" ForeColor="Red" Visible="False" Height="3px">*</asp:label>
			<asp:button id="btnFinalizarLote" style="Z-INDEX: 113; LEFT: 264px; POSITION: absolute; TOP: 496px"
				runat="server" Text="(5) Finalizar Lote" ToolTip="Finalizar el Lote" Width="120px"></asp:button>
			<asp:label id="lblValidaLoteAtendidoEImpreso" style="Z-INDEX: 114; LEFT: 392px; POSITION: absolute; TOP: 496px"
				runat="server" Font-Size="Large" Text="*" Width="3px" ForeColor="Red" Visible="False" Height="3px">*</asp:label>
			<asp:listbox id="lbExpConCajaConc" style="Z-INDEX: 111; LEFT: 8px; POSITION: absolute; TOP: 320px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox>
			<asp:button id="btnAsignaCajaConc" style="Z-INDEX: 106; LEFT: 720px; POSITION: absolute; TOP: 288px"
				runat="server" Text="(3) Ejecutar Baja" Width="140px"></asp:button>
			<asp:listbox id="lbExpDelLote" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 112px"
				runat="server" Width="862px" Height="176px" SelectionMode="Multiple"></asp:listbox>
			<asp:button id="btnRevisaExp" style="Z-INDEX: 109; LEFT: 768px; POSITION: absolute; TOP: 72px"
				runat="server" Text="Revisar Exp"></asp:button>
			<asp:button id="btnBuscaLote" style="Z-INDEX: 107; LEFT: 624px; POSITION: absolute; TOP: 72px"
				runat="server" Text="(2) Traer Lote"></asp:button>
			<asp:dropdownlist id="ddlBatches" style="Z-INDEX: 105; LEFT: 136px; POSITION: absolute; TOP: 72px"
				tabIndex="11" runat="server" Width="482px" AutoPostBack="True"></asp:dropdownlist>
			<asp:label id="Label1" style="Z-INDEX: 104; LEFT: 16px; POSITION: absolute; TOP: 72px" runat="server"
				Width="112px" Height="8px">Lotes por atender:</asp:label>
			<asp:button id="btnBuscaLotes" style="Z-INDEX: 103; LEFT: 424px; POSITION: absolute; TOP: 40px"
				runat="server" Text="(1) Buscar Lotes"></asp:button>
			<asp:dropdownlist id="ddlUnidAdm" style="Z-INDEX: 102; LEFT: 176px; POSITION: absolute; TOP: 40px"
				tabIndex="11" runat="server" Width="240px" AutoPostBack="True"></asp:dropdownlist>
			<asp:label id="Label2" style="Z-INDEX: 101; LEFT: 16px; POSITION: absolute; TOP: 40px" runat="server"
				Width="144px" Height="8px">Unidad Administrativa:</asp:label>
		</form>
	</body>
</html>
