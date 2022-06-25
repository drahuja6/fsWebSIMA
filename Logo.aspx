<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Logo.aspx.vb" Inherits="fsWebS_SEN.Logo" %>
<!doctype html>
<html>
	<head>
		<title>Logo</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
	</head>
	<body>
		<form id="form1" runat="server">
			<div class="card border-0" style="margin-left: 20px; margin-top: 10px;">
				<div class="row no-gutters">
					<div class="row">
						<div class="col-auto">
							<asp:Image CssClass="rounded" ID="logoFullServiceImg" runat="server" src="Images/LogoFSM.png" Height="75px" Width="75px" AlternateText="Full Service de México, S.A. de C.V." />
							<asp:Image CssClass="rounded" ID="logoCliente" runat="server" src="Images/LogoSenado-LXV.png" Height="75px" Width="75px" AlternateText="Full Service de México, S.A. de C.V. - Cliente" />
						</div>
					</div>
					<div class="col">
						<div class="card-block px-0">
							<p class="card-text">SIMA Senado</p>
							<asp:Label ID="versionLabel" runat="server" CssClass="text-muted small float-left" />
						</div>
					</div>
				</div>
			</div>
	    </form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
