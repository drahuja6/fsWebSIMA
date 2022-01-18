<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CuadroClasificacionStatus.aspx.vb" Inherits="fsWebS_SEN.CuadroClasificacionStatus" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>CuadroClasificacion2</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ccffff" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:label id="Label3" style="Z-INDEX: 103; LEFT: 16px; POSITION: absolute; TOP: 72px" runat="server"
				Font-Bold="True">Propiedades de los documentos de tipo</asp:label>
			<asp:Label id="Label15" style="Z-INDEX: 135; LEFT: 16px; POSITION: absolute; TOP: 8px" runat="server"
				Font-Bold="True" Width="64px" Height="48px">Jerarquía Superior</asp:Label><asp:label id="lblCuadroClasificacionStatus" style="Z-INDEX: 134; LEFT: 568px; POSITION: absolute; TOP: 160px"
				runat="server" Font-Bold="False" ForeColor="Red" Text="(SÓLO LECTURA)" Width="133px">(SÓLO LECTURA)</asp:label><asp:label id="lblValidaDescripcion" style="Z-INDEX: 133; LEFT: 696px; POSITION: absolute; TOP: 128px"
				runat="server" ForeColor="Red" Text="*" Width="1px" Visible="False" Height="3px">*</asp:label><asp:label id="lblValidaCodigo" style="Z-INDEX: 132; LEFT: 696px; POSITION: absolute; TOP: 96px"
				runat="server" ForeColor="Red" Text="*" Width="1px" Visible="False" Height="3px">*</asp:label><asp:button id="btnCancelar" style="Z-INDEX: 131; LEFT: 576px; POSITION: absolute; TOP: 384px"
				runat="server" Text="Cancelar" Width="72px" Enabled="False"></asp:button><asp:button id="btnSalvar" style="Z-INDEX: 130; LEFT: 576px; POSITION: absolute; TOP: 352px"
				runat="server" Text="Salvar" Width="72px" Enabled="False"></asp:button><asp:button id="btnBorrar" style="Z-INDEX: 129; LEFT: 344px; POSITION: absolute; TOP: 432px"
				runat="server" Text="Borrar" Width="89px"></asp:button><asp:button id="btnEditar" style="Z-INDEX: 128; LEFT: 248px; POSITION: absolute; TOP: 432px"
				runat="server" Text="Editar" Width="90px"></asp:button><asp:button id="btnAgregar" style="Z-INDEX: 127; LEFT: 152px; POSITION: absolute; TOP: 432px"
				runat="server" Text="Agregar (hijo)" Width="90px"></asp:button><asp:listbox id="lbxUnidadesAdministrativas" style="Z-INDEX: 126; LEFT: 304px; POSITION: absolute; TOP: 344px"
				runat="server" Width="248px" Enabled="False" SelectionMode="Multiple"></asp:listbox><asp:label id="Label14" style="Z-INDEX: 125; LEFT: 304px; POSITION: absolute; TOP: 320px" runat="server"
				Font-Bold="True">Unidades Administrativas Asociadas</asp:label><asp:dropdownlist id="ddlstDestinoFinal" style="Z-INDEX: 124; LEFT: 72px; POSITION: absolute; TOP: 296px"
				runat="server" Width="112px" Enabled="False"></asp:dropdownlist><asp:listbox id="lbxFundamentosLegalesDestinoFinal" style="Z-INDEX: 123; LEFT: 16px; POSITION: absolute; TOP: 344px"
				runat="server" Width="248px" Enabled="False" SelectionMode="Multiple"></asp:listbox><asp:label id="Label13" style="Z-INDEX: 122; LEFT: 16px; POSITION: absolute; TOP: 320px" runat="server"
				Font-Bold="True">Fundamentos Legales del Destino Final</asp:label><asp:label id="Label12" style="Z-INDEX: 121; LEFT: 16px; POSITION: absolute; TOP: 296px" runat="server"
				Font-Bold="True">Status</asp:label><asp:label id="Label11" style="Z-INDEX: 120; LEFT: 16px; POSITION: absolute; TOP: 272px" runat="server"
				Font-Bold="True">Destino Final</asp:label><asp:dropdownlist id="ddlstStatus" style="Z-INDEX: 119; LEFT: 456px; POSITION: absolute; TOP: 192px"
				runat="server" Width="112px" Enabled="False"></asp:dropdownlist><asp:label id="Label10" style="Z-INDEX: 118; LEFT: 400px; POSITION: absolute; TOP: 216px" runat="server"
				Font-Bold="True">Fundamentos Legales de la Clasificación</asp:label><asp:listbox id="lbxFundamentosLegalesClasificacion" style="Z-INDEX: 117; LEFT: 400px; POSITION: absolute; TOP: 240px"
				runat="server" Width="248px" Enabled="False" SelectionMode="Multiple"></asp:listbox><asp:label id="Label9" style="Z-INDEX: 116; LEFT: 400px; POSITION: absolute; TOP: 192px" runat="server"
				Font-Bold="True">Status</asp:label><asp:label id="Label8" style="Z-INDEX: 115; LEFT: 400px; POSITION: absolute; TOP: 168px" runat="server"
				Font-Bold="True">Información Clasificada</asp:label><asp:label id="Label37" style="Z-INDEX: 114; LEFT: 248px; POSITION: absolute; TOP: 168px" runat="server"
				Font-Bold="True" Width="120px" Height="16px">Valor documental</asp:label><asp:listbox id="lbxValorDocumental" style="Z-INDEX: 113; LEFT: 248px; POSITION: absolute; TOP: 192px"
				runat="server" Width="128px" Enabled="False" SelectionMode="Multiple"></asp:listbox><asp:dropdownlist id="ddlstConcentracion" style="Z-INDEX: 112; LEFT: 120px; POSITION: absolute; TOP: 216px"
				runat="server" Width="112px" Enabled="False"></asp:dropdownlist><asp:dropdownlist id="ddlstTramite" style="Z-INDEX: 111; LEFT: 120px; POSITION: absolute; TOP: 192px"
				runat="server" Width="112px" Enabled="False"></asp:dropdownlist><asp:label id="Label7" style="Z-INDEX: 110; LEFT: 16px; POSITION: absolute; TOP: 216px" runat="server"
				Font-Bold="True">Concentración</asp:label><asp:label id="Label6" style="Z-INDEX: 109; LEFT: 16px; POSITION: absolute; TOP: 192px" runat="server"
				Font-Bold="True">Trámite</asp:label><asp:label id="Label5" style="Z-INDEX: 108; LEFT: 16px; POSITION: absolute; TOP: 168px" runat="server"
				Font-Bold="True">Plazos de Conservación</asp:label><asp:textbox id="txtDescripcion" style="Z-INDEX: 107; LEFT: 104px; POSITION: absolute; TOP: 128px"
				runat="server" Width="592px" Enabled="False"></asp:textbox><asp:textbox id="txtCodigo" style="Z-INDEX: 106; LEFT: 72px; POSITION: absolute; TOP: 96px" runat="server"
				Width="624px" Enabled="False"></asp:textbox><asp:label id="Label4" style="Z-INDEX: 105; LEFT: 16px; POSITION: absolute; TOP: 136px" runat="server"
				Font-Bold="True">Descripción</asp:label><asp:label id="Label1" style="Z-INDEX: 104; LEFT: 16px; POSITION: absolute; TOP: 104px" runat="server"
				Font-Bold="True">Código</asp:label><asp:label id="Label2" style="Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 72px" runat="server"
				Width="411px">Label</asp:label><asp:listbox id="lbxJerarquia" style="Z-INDEX: 101; LEFT: 88px; POSITION: absolute; TOP: 8px"
				runat="server" Width="619px" Height="64px"></asp:listbox></form>
	</body>
</HTML>
