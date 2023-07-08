<%@ Register TagPrefix="cc1" Namespace="skmDataGrid" Assembly="skmDataGrid" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PaginaEnBlanco.aspx.vb" Inherits="fsWebSIMA.PaginaEnBlanco" %>
<!doctype html>
<html>
	<head>
		<title>PaginaEnBlanco</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</head>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<div>
				<div>

				</div>
				<div>
					<center>
						<asp:Image ID="Image1" ImageUrl="~/Images/Senado3.jpg" CssClass="img-fluid" AlternateText="Senado de la República" runat="server" />
					</center>
				 </div>  
			</div>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
