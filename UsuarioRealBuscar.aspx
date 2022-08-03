<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UsuarioRealBuscar.aspx.vb" Inherits="fsWebS_SEN.UsuarioRealBuscar" %>
<!doctype html>
<html>
	<head runat="server">
		<title>UsuarioRealBuscar</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</head>
	<body>
		<form id="Form1" method="post" runat="server" visible="true">
			<div class="container-fluid" style="max-width: 800px; margin-left: 20px; margin-top: 10px;">
				<div class="row align-self-center">
					<div class="col-8">
						<h4>Catálogo de usuarios del sistema</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-3-md">
						<asp:textbox CssClass="form-control" id="txbFiltro" runat="server" ToolTip="Secuencia por buscar (vacío para devolver todo)"/>
					</div>
					<div class="col-2-md ml-2">
						<asp:button CssClass="btn btn-primary" id="btnBuscar" runat="server" Text="Buscar" ToolTip="Buscar usuario(s)" Width="95px"/>
					</div>
					<div class="col-2-md offset-4">
						<asp:Button CssClass="btn btn-primary" id="Button1" runat="server" Text="Edición de usuarios" ToolTip="Permite ver directamente la ventana de edición de usuarios, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)" Width="160px"/>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col-12">
						<asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless table-striped table-responsive-md table-hover border-0">
							<ItemStyle Wrap="False" Font-Size="Small"></ItemStyle>
							<HeaderStyle Font-Bold="true"></HeaderStyle>
							<Columns>
								<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Select" ItemStyle-HorizontalAlign="Center"/>
								<asp:BoundColumn Visible="False" DataField="idUsuarioReal" HeaderText="idUsuarioReal"/>
								<asp:BoundColumn DataField="Login" HeaderText="Nombre"/>
								<asp:BoundColumn DataField="Nombre" HeaderText="Descripción"/>
							</Columns>
						</asp:datagrid>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<h5><asp:Label CssClass="form-control font-weight-bold" id="NoHayDatos" runat="server" Visible="False" Text="No hay datos que mostrar" /></h5>
					</div>
				</div>
			</div>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
