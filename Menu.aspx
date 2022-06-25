<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="fsWebS_SEN.Menu" %>
<!doctype html>
<html>
	<head>
		<title>Menu</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="css/fontawesome-free-5.15.4-web/css/all.min.css" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style type="text/css">  
			.lista-menu {
				list-style:none; 
			}
		</style> 
	</head>
	<body bgcolor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<div class="container text-left">
				<a class="btn btn-link text-decoration-none ml-n3 text-center" data-toggle="collapse" data-target="#collapseUsuarios">
					<i class="fas fa-user"></i>
					Usuarios
				</a>
				<div id="collapseUsuarios" class="collapse">
					<ul class="lista-menu ml-n4 small" id="menuUsuarios">
						<li>
							<asp:HyperLink id="usuariosLink" runat="server" Target ="principal" NavigateUrl="~/UsuarioRealBuscar.aspx" tabIndex="8" Text="Buscar/Editar" ToolTip="Catálogo de usuarios" Font-Underline="false"/>
						</li>
					</ul>
				</div>
				<a class="btn btn-link text-decoration-none ml-n3" data-toggle="collapse" title="Catálogo de disposición documental" data-target="#collapseCatalogo">
					<i class="fas fa-list"></i>
					Catálogo
				</a>
				<div id="collapseCatalogo" class="collapse">
					<ul class="lista-menu ml-n4 small" id="menuCatalogo">
						<li>
							<asp:HyperLink id="catalogoLink" runat="server" Target="principal" NavigateUrl="~/CuadroClasificacion.aspx" tabIndex="7" Text="Buscar/Editar" ToolTip="Catálogo de disposición documental" Font-Underline="false"/>
						</li>
					</ul>
				</div>
				<a class="btn btn-link text-decoration-none ml-n3" data-toggle="collapse" data-target="#collapseExpediente">
					<i class="fas fa-file"></i>
					Expedientes
				</a>
				<div id="collapseExpediente" class="collapse">
					<ul class="lista-menu ml-n4 small" id="menuExpedientes">
						<li>
							<asp:HyperLink ID="expedientesLink" runat="server" NavigateUrl="~/BusquedaExpedientes.aspx" Target="principal" tabIndex="1" Text="Buscar/Editar" ToolTip="Busca expedientes para consulta o edición" Font-Underline="false"/>
						</li>
						<li>
							<asp:HyperLink id="auditoriaLink" tabIndex="2" runat="server" Target="principal" NavigateUrl="TrabajoRealizado.aspx" Text="Auditoría" ToolTip="Auditoría de trabajo realizado" Font-Underline="false"/>
						</li>
					</ul>
				</div>
				<a class="btn btn-link text-decoration-none ml-n3" data-toggle="collapse" data-target="#collapseProcesos">
					<i class="fas fa-spinner"></i>
					Procesos
				</a>
				<div id="collapseProcesos" class="collapse">
					<ul class="lista-menu ml-n4 small" id="menuProcesos">
						<li>
							<asp:HyperLink id="tramiteConcentracionLink" tabIndex="3" runat="server" Target="principal" NavigateUrl="~/TraspasoExpedientesVencidos.aspx?Proceso=1" Text="Trámite" ToolTip="Transferencia de trámite a concentración" Font-Underline="false"/>
						</li>
						<li>
							<asp:HyperLink id="recepConcentracionLink" tabIndex="4" runat="server" Target="principal" NavigateUrl="~/TraspasoRecepcionExpedientes.aspx?Proceso=1" Text="Concentración" ToolTip="Recepción en concentración" Font-Underline="false"/>
						</li>
						<li>
							<asp:HyperLink id="concentracionBajaLink" tabIndex="5" runat="server" Target="principal" NavigateUrl="~/TraspasoExpedientesVencidos.aspx?Proceso=2" Text="Baja" ToolTip="Transferencia de concentración a baja" Font-Underline="false"/>
						</li>
						<li>
							<asp:HyperLink id="autorizaBajaLink" tabIndex="6" runat="server" Target="principal" NavigateUrl="~/TraspasoRecepcionExpedientes.aspx?Proceso=2" Text="Autorización baja" ToolTip="Autorización de baja" Font-Underline="false"/>
						</li>
					</ul>
				</div>
				<asp:panel ID="pnlHerramientas" runat="server">
					<a class="btn btn-link text-decoration-none ml-n3" data-toggle="collapse" data-target="#collapseHerramientas">
						<i class="fas fa-wrench"></i>
						Herramientas
					</a>
					<div id="collapseHerramientas" class="collapse">
						<ul class="lista-menu ml-n4 small" id="menuHerramientas">
							<li>
								<asp:HyperLink id="lnkVerificaArchivos" runat="server" Target="principal" NavigateUrl="~/VerificarArchivos.aspx" tabIndex="9" Text="Verifica archivos" ToolTip="Verifica la existencia de archivo de imágenes" Font-Underline="false" Visible="false" />
							</li>
							<li>
								<asp:HyperLink id="lnkHerramientasPdf" runat="server" Target="principal" NavigateUrl="~/HerramientasPdf.aspx" tabIndex="10" Text="Herramientas PDF" ToolTip="Procesos PDF" Font-Underline="false" Visible="false" />
							</li>
						</ul>
					</div>
				</asp:panel>
				<br />
				<a class="btn btn-link text-decoration-none ml-n3" href="Logout.aspx" target="_top" data-toggle="tooltip" title="Salir de la aplicación">
					<i class="fas fa-door-open"></i>
					Salir
				</a>
			</div>	
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
