<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="fsWebS_SEN.Menu" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Menu</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body bgcolor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/BuscarExpediente.aspx" Style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 32px"
				Target="PRINCIPAL" Width="96px" tabIndex="1">Buscar / Editar</asp:HyperLink>
			<asp:HyperLink id="HLVEC" style="Z-INDEX: 116; LEFT: 8px; POSITION: absolute; TOP: 112px" tabIndex="3"
				runat="server" Width="88px" Target="PRINCIPAL" NavigateUrl="ExpVencidos.aspx" Visible="False"> VEC: 0</asp:HyperLink>
			<asp:HyperLink id="HLVET" style="Z-INDEX: 115; LEFT: 8px; POSITION: absolute; TOP: 88px" tabIndex="3"
				runat="server" Width="88px" Target="PRINCIPAL" NavigateUrl="ExpVencidos.aspx" Visible="False"> VET: 0</asp:HyperLink>
			<asp:HyperLink id="HyperLink8" style="Z-INDEX: 111; LEFT: 8px; POSITION: absolute; TOP: 256px"
				tabIndex="3" runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="RecepEnBaja.aspx">Autoriz. Baja</asp:HyperLink>
			<asp:HyperLink id="HyperLink7" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 232px"
				tabIndex="3" runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="ConcABaja.aspx">Conc >> Baja</asp:HyperLink>
			<asp:HyperLink id="HyperLink6" style="Z-INDEX: 109; LEFT: 8px; POSITION: absolute; TOP: 208px"
				tabIndex="3" runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="RecepEnConc.aspx">Rec. Conc</asp:HyperLink>
			<asp:HyperLink id="HyperLink4" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 184px"
				tabIndex="3" runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="TramiteAConc.aspx">Tram >> Conc</asp:HyperLink>
			<asp:Label id="Label4" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 160px" runat="server"
				Width="104px" Text="Expedientes" Font-Bold="True">Procesos</asp:Label>
			<asp:HyperLink id="HyperLink5" style="Z-INDEX: 106; LEFT: 8px; POSITION: absolute; TOP: 56px" tabIndex="3"
				runat="server" Width="88px" Target="PRINCIPAL" NavigateUrl="TrabajoRealizado.aspx"> Auditoría</asp:HyperLink>
			<asp:HyperLink id="HyperLink2" style="Z-INDEX: 105; LEFT: 8px; POSITION: absolute; TOP: 400px"
				runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="UsuarioRealBuscar.aspx" tabIndex="3">Buscar / Editar</asp:HyperLink>
			<asp:Label id="Label3" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 376px" runat="server"
				Width="64px" Font-Bold="True" Text="Expedientes">Usuarios</asp:Label>
			<asp:Label id="Label2" runat="server" Width="88px" Text="Expedientes" Font-Bold="True" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 8px"></asp:Label>
			<asp:HyperLink id="HyperLink3" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 328px"
				runat="server" Width="96px" Target="PRINCIPAL" NavigateUrl="CuadroClasificacion.aspx" tabIndex="2">Buscar / Editar</asp:HyperLink>
			<asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Expedientes" Width="104px" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 304px"> Cat.Disp.Doc.</asp:Label>
            <asp:HyperLink ID="HyperLink9" runat="server" style="Z-INDEX: 101; LEFT: 10px; POSITION: absolute; TOP: 440px" NavigateUrl="~/Logout.aspx" Target="_top">Salir</asp:HyperLink>

		</form>
	</body>
</HTML>
