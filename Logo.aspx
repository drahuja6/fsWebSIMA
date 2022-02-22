<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Logo.aspx.vb" Inherits="fsWebS_SEN.Logo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Logo</title>
	</head>
	<body>
		<form id="form1" runat="server">
		<div>
			<asp:Panel ID="Panel1" runat="server">
                <asp:Panel ID="Panel2" runat="server">
		            <asp:Image ID="logoFullServiceImg" runat="server" src="LogoFSM.png" Height="75px" Width="75px" AlternateText="Full Service de México, S.A. de C.V." />
					<asp:Image ID="logoCliente" runat="server" src="LogoSenado-LXV.png" Height="75px" Width="75px" AlternateText="Full Service de México, S.A. de C.V. - Cliente" />
					<asp:Label ID="versionLabel" runat="server" Font-Size="XX-Small"/>
                </asp:Panel>
			</asp:Panel>
		</div>
	    </form>
	</body>
</html>
