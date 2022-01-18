<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TramiteAConc.aspx.vb" Inherits="fsWebS_SEN.TramiteAConc" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>TramiteAConc</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ccffff" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:button id="btnBuscaVencidos" style="Z-INDEX: 104; LEFT: 520px; POSITION: absolute; TOP: 40px"
				runat="server" Text="(1) Buscar Exp"></asp:button><asp:textbox id="txtNuevoBatchID2" style="Z-INDEX: 124; LEFT: 120px; POSITION: absolute; TOP: 480px"
				runat="server" Width="64px"></asp:textbox><asp:label id="Label4" style="Z-INDEX: 123; LEFT: 24px; POSITION: absolute; TOP: 488px" runat="server"
				Width="88px">Para Lote No.</asp:label><asp:button id="btnImpListado" style="Z-INDEX: 122; LEFT: 656px; POSITION: absolute; TOP: 40px"
				runat="server" Text="(2) Imprimir lista" Width="114px"></asp:button><asp:textbox id="txtFechCorteVig" style="Z-INDEX: 121; LEFT: 136px; POSITION: absolute; TOP: 248px"
				runat="server" Width="112px" Enabled="False"></asp:textbox><asp:button id="btnImprimeEnvio" style="Z-INDEX: 120; LEFT: 208px; POSITION: absolute; TOP: 480px"
				runat="server" Text="(5) Imprimir envío" Width="144px"></asp:button><asp:label id="Label3" style="Z-INDEX: 119; LEFT: 16px; POSITION: absolute; TOP: 280px" runat="server"
				Font-Bold="True" Font-Size="Small">Expedientes listos para su envío a concentración (caja provisional asignada):</asp:label><asp:button id="btnQuitar" style="Z-INDEX: 118; LEFT: 776px; POSITION: absolute; TOP: 480px"
				runat="server" Text="Quitar Exp"></asp:button><asp:label id="lblValidaNuevoBatch" style="Z-INDEX: 117; LEFT: 120px; POSITION: absolute; TOP: 248px"
				runat="server" Text="*" Width="3px" Font-Size="Large" ForeColor="Red" Visible="False" Height="3px">*</asp:label><asp:label id="lblValidaCajaProv" style="Z-INDEX: 116; LEFT: 704px; POSITION: absolute; TOP: 248px"
				runat="server" Text="*" Width="3px" Font-Size="Large" ForeColor="Red" Visible="False" Height="3px">*</asp:label><asp:textbox id="txtCajaProv" style="Z-INDEX: 115; LEFT: 648px; POSITION: absolute; TOP: 248px"
				runat="server" Width="56px"></asp:textbox><asp:label id="Label1" style="Z-INDEX: 114; LEFT: 16px; POSITION: absolute; TOP: 248px" runat="server">Lote:</asp:label><asp:textbox id="txtNuevoBatchDesc" style="Z-INDEX: 113; LEFT: 256px; POSITION: absolute; TOP: 248px"
				runat="server" Width="185px"></asp:textbox><asp:textbox id="txtNuevoBatchID" style="Z-INDEX: 112; LEFT: 56px; POSITION: absolute; TOP: 248px"
				runat="server" Width="64px" Enabled="False"></asp:textbox><asp:button id="btnNuevoBatch" style="Z-INDEX: 110; LEFT: 448px; POSITION: absolute; TOP: 248px"
				runat="server" Text="(3) Nuevo Lote" Width="108px"></asp:button><asp:button id="btnAsignaCaja" style="Z-INDEX: 109; LEFT: 720px; POSITION: absolute; TOP: 248px"
				runat="server" Text="(4) Asignar caja prov" Width="140px"></asp:button><asp:listbox id="lbExpConCaja" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 304px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox><asp:button id="btnRevisaExp" style="Z-INDEX: 107; LEFT: 776px; POSITION: absolute; TOP: 40px"
				runat="server" Text="Revisar Exp" Width="88px"></asp:button><asp:dropdownlist id="ddlUnidAdm" style="Z-INDEX: 106; LEFT: 8px; POSITION: absolute; TOP: 40px" tabIndex="11"
				runat="server" Width="184px"></asp:dropdownlist><asp:listbox id="lbExpVencEnTramite" style="Z-INDEX: 105; LEFT: 8px; POSITION: absolute; TOP: 72px"
				runat="server" Width="862px" Height="168px" SelectionMode="Multiple"></asp:listbox><asp:label id="lblValidaFechaDeCorteVigente" style="Z-INDEX: 103; LEFT: 504px; POSITION: absolute; TOP: 40px"
				runat="server" Text="*" Width="3px" Font-Size="Large" ForeColor="Red" Visible="False" Height="3px">*</asp:label><asp:textbox id="txtFechaDeCorte" style="Z-INDEX: 102; LEFT: 392px; POSITION: absolute; TOP: 40px"
				runat="server" Width="112px"></asp:textbox><asp:label id="Label2" style="Z-INDEX: 101; LEFT: 208px; POSITION: absolute; TOP: 40px" runat="server"> Fecha de corte (dd/mm/aaaa):</asp:label><asp:label id="lblFechaDeCorteVigente" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px"
				runat="server" Font-Bold="True" Font-Size="Large">Pase de Trámite a Concentración</asp:label></form>
	</body>
</HTML>
