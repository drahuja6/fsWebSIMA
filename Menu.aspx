<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="fsWebS_SEN.Menu" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Menu</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css">  
			.titulo {  
				width: 100px;
				font-size: medium;
				font-weight:700;
				font-family: Arial, Helvetica, sans-serif;
				color:navy;
			}  
			.liga {  
				width: 100px;
				font-weight: 500;
				font-size: smaller; 
				font-family: Arial, Helvetica, sans-serif;
			}  
		</style> 
	</HEAD>
	<body bgcolor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<div>
				<table style="width: 120px;">
				<tr>
					<td class="titulo">
						<asp:Label id="expedientesLabel" runat="server" Text="Expedientes"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink ID="expedienteLink" runat="server" NavigateUrl="~/BuscarExpediente.aspx" Target="PRINCIPAL" tabIndex="1" Text="Buscar/Editar" ToolTip="Busca expedientes para consulta o edición" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="auditoriaLink" tabIndex="2" runat="server" Target="PRINCIPAL" NavigateUrl="TrabajoRealizado.aspx" Text="Auditoría" ToolTip="Auditoría de trabajo realizado" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td><br/></td>
				</tr>
				<tr>
					<td class="titulo">
						<asp:Label id="procesosLabel" runat="server" Text="Procesos"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="tramiteConcentracionLink" tabIndex="3" runat="server" Target="PRINCIPAL" NavigateUrl="TramiteAConc.aspx" Text="Tram >> Conc" ToolTip="Transferencia de trámite a concentración" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="recepConcentracionLink" tabIndex="4" runat="server" Target="PRINCIPAL" NavigateUrl="RecepEnConc.aspx" Text="Rec. Conc" ToolTip="Recepción en concentración" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="concentracionBajaLink" tabIndex="5" runat="server" Target="PRINCIPAL" NavigateUrl="ConcABaja.aspx" Text="Conc >> Baja" ToolTip="Transferencia de concentración a baja" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="autorizaBajaLink" tabIndex="6" runat="server" Target="PRINCIPAL" NavigateUrl="RecepEnBaja.aspx" Text="Autoriza baja" ToolTip="Autorización de baja" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td class="titulo">
						<asp:Label ID="cuadroLabel" runat="server" Text="Catálogo"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="cuadroLink" runat="server" Target="PRINCIPAL" NavigateUrl="CuadroClasificacion.aspx" tabIndex="7" Text="Buscar/Editar" ToolTip="Catálogo de disposición documental" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td class="titulo">
						<asp:Label id="usuariosLabel" runat="server" Text="Usuarios"/>
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="usuariosLink" runat="server" Target ="PRINCIPAL" NavigateUrl="UsuarioRealBuscar.aspx" tabIndex="8" Text="Buscar/Editar" ToolTip="Catálogo de usuarios" Font-Underline="false"/>
					</td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td class="titulo">
						<asp:Label ID="lblTituloHerramientas" runat="server" Text="Herramientas" Visible="false" />
					</td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink id="lnkVerificaArchivos" runat="server" Target="PRINCIPAL" NavigateUrl="VerificarArchivos.aspx" tabIndex="9" Text="Verifica archivos" ToolTip="Verifica la existencia de archivo de imágenes" Font-Underline="false" Visible="false" />
					</td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td><br /></td>
				</tr>
				<tr>
					<td class="liga">
						<asp:HyperLink ID="salirLink" runat="server" NavigateUrl="~/Logout.aspx" Target="_top" Text="Salir" ToolTip="Cerrar la sesión" Font-Underline="false" TabIndex="10" />
					</td>
				</tr>
				<asp:HyperLink id="HLVEC" style="LEFT: 8px; POSITION: absolute; TOP: 112px" tabIndex="3"
					runat="server" Width="88px" Target="PRINCIPAL" NavigateUrl="ExpVencidos.aspx" Visible="False" Text="VEC: 0"/>
				<asp:HyperLink id="HLVET" style="LEFT: 8px; POSITION: absolute; TOP: 88px" tabIndex="3"
					runat="server" Width="88px" Target="PRINCIPAL" NavigateUrl="ExpVencidos.aspx" Visible="False" Text="VET: 0"/>
				</table>
			</div>
		</form>
	</body>
</HTML>
