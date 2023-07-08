<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CuadroClasificacion.aspx.vb" Inherits="fsWebSIMA.CuadroClasificacion" %>
<!doctype html>
<html">
	<head runat="server">
		<title>CuadroClasificacion</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<div class="container-fluid" style="max-width: 800px; margin-left: 20px; margin-top: 10px;">
				<div class="row align-self-center">
					<div class="col-8">
						<h4>Catálogo de disposición documental</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-3-md">
						<asp:textbox CssClass="form-control" id="txbFiltro" runat="server"/>
					</div>
					<div class="col-2-md ml-2">
						<asp:button CssClass="btn btn-primary" id="btnAplicar" runat="server" Text="Buscar" Width="95px"/>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col-12">
						<asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless table-striped table-responsive-md table-hover border-0">
							<Columns>
								<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Select"/>
								<asp:BoundColumn DataField="NombreDeJerarquia" HeaderText="C&#243;digo"/>
								<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n"/>
								<asp:BoundColumn Visible="False" DataField="idClasificacion" />
							</Columns>
						</asp:datagrid>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<asp:Label CssClass="form-control font-weight-bold" id="NoHayDatos" runat="server" Visible="False" Text="No hay datos que mostrar"/>
					</div>
				</div>
			</div>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
