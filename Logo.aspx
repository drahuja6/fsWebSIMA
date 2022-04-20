<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Logo.aspx.vb" Inherits="fsWebS_SEN.Logo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Logo</title>
		<style type="text/css">
			.etiqueta-pequena {  
				font-size: xx-small;
				font-weight:300;
				font-family: Arial, Helvetica, sans-serif;
				color:navy;
				vertical-align: bottom;
            }
		</style> 
	</head>
	<body>
		<form id="form1" runat="server">
		<div>
			<asp:Panel ID="Panel1" runat="server">
                <asp:Panel ID="Panel2" runat="server">
		            <asp:Image ID="logoFullServiceImg" runat="server" src="Images/LogoFSM.png" Height="75px" Width="75px" AlternateText="Full Service de M�xico, S.A. de C.V." />
					<asp:Image ID="logoCliente" runat="server" src="Images/LogoSenado-LXV.png" Height="75px" Width="75px" AlternateText="Full Service de M�xico, S.A. de C.V. - Cliente" />
					<asp:Label class="etiqueta-pequena" ID="versionLabel" runat="server"/>
                </asp:Panel>
			</asp:Panel>
		</div>
	    </form>
	</body>
</html>
