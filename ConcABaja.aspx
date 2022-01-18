<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ConcABaja.aspx.vb" Inherits="fsWebS_SEN.ConcABaja" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>ConcABaja</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ccffff" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="lblFechaDeCorteVigente" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Size="Large" Font-Bold="True" Width="320px">Pase de Concentración a Baja</asp:label>
			<asp:label id="lblValidaCajaProv" style="Z-INDEX: 124; LEFT: 704px; POSITION: absolute; TOP: 248px"
				runat="server" Width="3px" Font-Size="Large" Text="*" Height="3px" ForeColor="Red" Visible="False">*</asp:label>
			<asp:textbox id="txtCajaProv" style="Z-INDEX: 123; LEFT: 648px; POSITION: absolute; TOP: 248px"
				runat="server" Width="56px"></asp:textbox><asp:button id="btnQuitar" style="Z-INDEX: 122; LEFT: 776px; POSITION: absolute; TOP: 480px"
				runat="server" Text="Quitar Exp"></asp:button><asp:button id="btnImprimeEnvio" style="Z-INDEX: 121; LEFT: 208px; POSITION: absolute; TOP: 480px"
				runat="server" Width="144px" Text="(5) Imprimir envío"></asp:button><asp:textbox id="txtNuevoBatchID2" style="Z-INDEX: 120; LEFT: 120px; POSITION: absolute; TOP: 480px"
				runat="server" Width="64px"></asp:textbox><asp:label id="Label4" style="Z-INDEX: 119; LEFT: 24px; POSITION: absolute; TOP: 488px" runat="server"
				Width="88px">Para Lote No.</asp:label><asp:label id="Label3" style="Z-INDEX: 118; LEFT: 16px; POSITION: absolute; TOP: 280px" runat="server"
				Font-Size="Small" Font-Bold="True"> Expedientes pasados a baja:</asp:label><asp:listbox id="lbExpConCaja" style="Z-INDEX: 117; LEFT: 8px; POSITION: absolute; TOP: 304px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox><asp:button id="btnAsignaCaja" style="Z-INDEX: 116; LEFT: 720px; POSITION: absolute; TOP: 248px"
				runat="server" Width="140px" Text="(4) Asignar caja prov"></asp:button><asp:button id="btnNuevoBatch" style="Z-INDEX: 114; LEFT: 448px; POSITION: absolute; TOP: 248px"
				runat="server" Width="108px" Text="(3) Nuevo Lote"></asp:button><asp:textbox id="txtNuevoBatchDesc" style="Z-INDEX: 113; LEFT: 256px; POSITION: absolute; TOP: 248px"
				runat="server" Width="185px"></asp:textbox><asp:label id="lblValidaNuevoBatch" style="Z-INDEX: 112; LEFT: 120px; POSITION: absolute; TOP: 248px"
				runat="server" Font-Size="Large" Width="3px" Height="3px" Visible="False" ForeColor="Red" Text="*">*</asp:label><asp:textbox id="txtFechCorteVig" style="Z-INDEX: 111; LEFT: 136px; POSITION: absolute; TOP: 248px"
				runat="server" Width="112px" Enabled="False"></asp:textbox><asp:textbox id="txtNuevoBatchID" style="Z-INDEX: 110; LEFT: 56px; POSITION: absolute; TOP: 248px"
				runat="server" Width="64px" Enabled="False"></asp:textbox><asp:label id="Label1" style="Z-INDEX: 109; LEFT: 16px; POSITION: absolute; TOP: 248px" runat="server">Lote:</asp:label><asp:listbox id="lbExpVencEnConc" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 72px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox><asp:button id="btnRevisaExp" style="Z-INDEX: 107; LEFT: 776px; POSITION: absolute; TOP: 40px"
				runat="server" Width="88px" Text="Revisar Exp"></asp:button><asp:button id="btnImpListado" style="Z-INDEX: 106; LEFT: 656px; POSITION: absolute; TOP: 40px"
				runat="server" Width="114px" Text="(2) Imprimir lista"></asp:button><asp:button id="btnBuscaVencidos" style="Z-INDEX: 105; LEFT: 520px; POSITION: absolute; TOP: 40px"
				runat="server" Text="(1) Buscar Exp"></asp:button><asp:label id="lblValidaFechaDeCorteVigente" style="Z-INDEX: 104; LEFT: 504px; POSITION: absolute; TOP: 40px"
				runat="server" Font-Size="Large" Width="3px" Height="3px" Visible="False" ForeColor="Red" Text="*">*</asp:label><asp:textbox id="txtFechaDeCorte" style="Z-INDEX: 103; LEFT: 392px; POSITION: absolute; TOP: 40px"
				runat="server" Width="112px"></asp:textbox><asp:label id="Label2" style="Z-INDEX: 102; LEFT: 208px; POSITION: absolute; TOP: 40px" runat="server"> Fecha de corte (dd/mm/aaaa):</asp:label><asp:dropdownlist id="ddlUnidAdm" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 40px" tabIndex="11"
				runat="server" Width="184px"></asp:dropdownlist></form>
	</body>
</HTML>
