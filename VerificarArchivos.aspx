<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VerificarArchivos.aspx.vb" Inherits="fsWebS_SEN.VerificarArchivos" %>
<!doctype html>
<html>
	<head runat="server">
		<title>Verificar archivos</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="Scripts/sima.js"></script>
		<link type="text/css" rel="stylesheet" href="Senado.css" />
		<style type="text/css">
			.grid-ua {
				width:28%;
				text-align:unset;
			}
			.grid-datos {
				width:9%;		
			}
		</style> 
	</head>
	<body>
		<form id="form1" runat="server" onsubmit="return setHourglass()">
			<div class="loading" align="center">
				Por favor espere<br />
				<br />
				<img src="Images/loader.gif" alt="" />
			</div>
			<div class="container-fluid" style="max-width: 800px; margin-left: 20px; margin-top: 10px;">
				<div class="row align-self-center">
					<div class="col-8">
						<h4>Expedientes e imágenes vinculadas</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-4 form-group">
						<Label for="txtTotalExpedientes" class="col-form-label-sm">Expedientes en BD:</Label>
						<asp:TextBox ID="txtTotalExpedientes" runat="server" Enabled="false" CssClass="form-control" />
					</div>
					<div class="col-4 form-group">
						<label for="txtAplicaDigitalizacion" class="col-form-label-sm">Aplica digitalización:</label>
						<asp:TextBox ID="txtAplicaDigitalizacion" runat="server" Enabled="false" CssClass="form-control" />
					</div>
					<div class="col-4 form-group">
						<label for="txtNoAplicaDigitalizacion" class="col-form-label-sm">No aplica digitalización</label>
						<asp:TextBox ID="txtNoAplicaDigitalizacion" runat="server" Enabled="false" CssClass="form-control" />
					</div>
				</div>
				<hr />
				<div class="row align-self-center>">
					<div class="col">
						<h6>Detalle de expedientes en que aplica digitalización:</h6>
					</div>
				</div>
				<div class="row">
					<div class="col-4 form-group">
						<label for="txtExpedientesConArchivos" class="col-form-label-sm">Expedientes con información en BD:</label>
						<asp:TextBox ID="txtExpedientesConArchivos" runat="server" Enabled="false" CssClass="form-control" />
					</div>
					<div class="col-4 form-group">
						<asp:Label CssClass="from-control col-form-label-sm" ID="lblExpedientesSinArchivos" runat="server" Text="Expedientes sin información en BD:" Visible='<%# CInt(Me.txtExpedientesSinArchivos.Text) > 0 %>' />
						<asp:TextBox ID="txtExpedientesSinArchivos" runat="server" Enabled="false" Visible='<%# CInt(Me.txtExpedientesSinArchivos.Text) > 0 %>' CssClass="form-control text-danger font-weight-bold" />
					</div>
					<div class="col-4 form-group">
						<label for="txtTotalHojasEsperadas" class="col-form-label-sm">Total de hojas en BD:</label>
						<asp:TextBox ID="txtTotalHojasEsperadas" runat="server" Enabled="false" CssClass="form-control" />
					</div>
				</div>
				<div class="row">
					<div class="col-4 form-group">
						<label for="txtImagenesEsperadas" class="col-form-label-sm">Archivos de imagen esperados:</label>
						<asp:TextBox ID="txtImagenesEsperadas" runat="server" Enabled="false" CssClass="form-control" />
					</div>
					<div class="col-4 form-group">
						<label for="txtArchivosLocalizados" class="col-form-label-sm">Archivos de imagen localizados:</label>
						<asp:TextBox ID="txtArchivosLocalizados" runat="server" Enabled="false" CssClass="form-control" />
					</div>
					<div class="col-4 form-group">
						<label for="txtArchivosNoLocalizados" class="col-form-label-sm">Archivos de imagen no localizados:</label>
						<asp:TextBox ID="txtArchivosNoLocalizados" runat="server" Enabled="false" CssClass="form-control text-danger font-weight-bold" />
					</div>
				</div>
				<hr />
				<div class="row align-self-center>">
					<div class="col">
						<h6>Detalle de expedientes por Unidad administrativa:</h6>
					</div>
				</div>
				<div class="row mt-2">
					<div class="col-12">
						<asp:GridView ID="grvDetalle" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless table-striped table-responsive-md table-hover border-0 small">
							<Columns>
								<asp:BoundField DataField="Descripcion" HeaderText="Unidad administrativa" />
								<asp:BoundField DataField="TotalExpedientesBD" HeaderText="Expedientes cargados" />
								<asp:BoundField DataField="SinDigitalizacion" HeaderText="No aplica digitalización" />
								<asp:BoundField DataField="ConDigitalizacion" HeaderText="Aplica digitalización" />
								<asp:BoundField DataField="ExpedientesConArchivoBD" HeaderText="Con información en BD" />
								<asp:BoundField DataField="ExpedientesSinArchivoBD" HeaderText="Sin información en BD" ItemStyle-CssClass="text-danger font-weight-bold" />
								<asp:BoundField DataField="TotalImagenes" HeaderText="Imágenes esperadas" />
								<asp:BoundField DataField="TotalHojasBD" HeaderText="Hojas esperadas" />
								<asp:BoundField DataField="ArchivosLocalizadosFS" HeaderText="Imágenes localizadas" />
								<asp:BoundField DataField="ArchivosNoLocalizadosFS" HeaderText="Imágenes no localizadas" ItemStyle-CssClass="text-danger font-weight-bold" />
							</Columns>
						</asp:GridView>
					</div>
				</div>
				<hr />
				<div class="row clickable-row">
					<div class="col-3">
						<div class="w-100" onclick="ShowProgress()">
							<div class="row">
								<div class="col">
									<asp:Button ID="btnIniciarVerificacion" runat="server" Text="Iniciar verificación" CssClass="btn btn-primary" />
								</div>
							</div>					
						</div>
					</div>
					<div class="col-4">
						<asp:CheckBox ID="chkReiniciarContadores" runat="server" Text="Reiniciar contadores" CssClass="form-check" ToolTip="Reiniciar contador de archivos hallados" />
					</div>
					<div class="col-3">
						<asp:Label ID="lblVerificados" runat="server" Text="Archivos localizados:" CssClass="col-form-label-sm" />
					</div>
					<div class="col">
						<asp:TextBox ID="txtVerificados" runat="server" Enabled="false" CssClass="form-control" />
					</div>
				</div>
				<hr />
			</div>
			<table>
<%--				<tr>
					<th class="etiqueta-titulo" colspan="6">
					</th>
				</tr>--%>
<%--				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblTotalExpedientes" runat="server" Text="Expedientes en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtTotalExpedientes" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="Label3" runat="server" Text="Aplica digitalización:" />
					</td>
					<td>
						<asp:TextBox ID="txtAplicaDigitalizacion" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="Label4" runat="server" Text="No aplica digitalización:" />
					</td>
					<td>
						<asp:TextBox ID="txtNoAplicaDigitalizacion" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="2">
						<asp:Label CssClass="etiqueta" ID="lblTituloAplicaDigitalizacion" runat="server" Text="Detalle de expedientes en que aplica digitalización:" />
					</td>
				</tr>--%>
<%--				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblExpedientesConArchivos" runat="server" Text="Expedientes con información en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtExpedientesConArchivos" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta error" ID="lblExpedientesSinArchivos" runat="server" Text="Expedientes sin información en BD:"  Visible='<%# CInt(Me.txtExpedientesSinArchivos.Text) > 0 %>' />
					</td>
					<td>
						<asp:TextBox ID="txtExpedientesSinArchivos" runat="server" Enabled="false" Visible='<%# CInt(Me.txtExpedientesSinArchivos.Text) > 0 %>' CssClass="textbox numero error" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblTotalHojas" runat="server" Text="Total de hojas en BD:" />
					</td>
					<td>
						<asp:TextBox ID="txtTotalHojasEsperadas" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
				</tr>--%>
<%--				<tr>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblImagenesEsperadas" runat="server" Text="Archivos de imagen esperados:" />
					</td>
					<td>
						<asp:TextBox ID="txtImagenesEsperadas" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta" ID="lblArchivosLocalizados" runat="server" Text="Archivos de imagen localizados:" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosLocalizados" runat="server" Enabled="false" CssClass="textbox numero" />
					</td>
					<td>
						<asp:Label CssClass="etiqueta error" ID="lblArchivosNoLocalizados" runat="server" Text="Archivos de imagen no localizados:" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosNoLocalizados" runat="server" Enabled="false" CssClass="textbox numero error" />
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="2">
						<asp:Label CssClass="etiqueta" ID="lblTituloDetalle" runat="server" Text="Detalle de expedientes por Unidad administrativa:" />
					</td>
				</tr>--%>
<%--				<tr>
					<td class="col" colspan="6">
						<asp:Panel ID="panDetalle" runat="server">
							<asp:GridView ID="grvDetalle" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">

								<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
								<Columns>
									<asp:BoundField DataField="Descripcion" HeaderText="Unidad administrativa" ItemStyle-CssClass="grid-ua" />
									<asp:BoundField DataField="TotalExpedientesBD" HeaderText="Expedientes cargados" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="SinDigitalizacion" HeaderText="No aplica digitalización" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ConDigitalizacion" HeaderText="Aplica digitalización" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ExpedientesConArchivoBD" HeaderText="Con información en BD" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ExpedientesSinArchivoBD" HeaderText="Sin información en BD" ItemStyle-CssClass="grid-datos error" />
									<asp:BoundField DataField="TotalImagenes" HeaderText="Imágenes esperadas" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="TotalHojasBD" HeaderText="Hojas esperadas" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ArchivosLocalizadosFS" HeaderText="Imágenes localizadas" ItemStyle-CssClass="grid-datos" />
									<asp:BoundField DataField="ArchivosNoLocalizadosFS" HeaderText="Imágenes no localizadas" ItemStyle-CssClass="grid-datos error" />
								</Columns>
								<EditRowStyle BackColor="#999999" />
								<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
								<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Underline="true" Font-Size="Smaller" />
								<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
								<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
								<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
								<SortedAscendingCellStyle BackColor="#E9E7E2" />
								<SortedAscendingHeaderStyle BackColor="#506C8C" />
								<SortedDescendingCellStyle BackColor="#FFFDF8" />
								<SortedDescendingHeaderStyle BackColor="#6F8DAE" />

							</asp:GridView>
						</asp:Panel>
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>--%>
<%--				<tr>
					<td onclick="ShowProgress()">
						<asp:Button ID="btnIniciarVerificacion" runat="server" Text="Iniciar verificación" CssClass="etiqueta-boton" />
					</td>
					<td>
						<asp:CheckBox ID="chkReiniciarContadores" runat="server" Text="Reiniciar contadores" CssClass="etiqueta" ToolTip="Reiniciar contador de archivos hallados" />
					</td>
					<td colspan="2"></td>
					<td>
						<asp:Label ID="lblVerificados" runat="server" Text="Nuevos archivos localizados:" CssClass="etiqueta" />
					</td>
					<td>
						<asp:TextBox ID="txtVerificados" runat="server" Enabled="false" CssClass="etiqueta-textbox" />
					</td>
				</tr>--%>
<%--				<tr>
					<td colspan="6">
						<hr />
					</td>
				</tr>--%>
				<tr>
					<td colspan="2" class="etiqueta-titulo">
						<asp:Label ID="lblInformacionDirectorio" runat="server" Text="Información general del directorio de imágenes (en disco):" />
					</td>
					<td colspan="2">
						<asp:TextBox ID="txtEspacioDisco" runat="server" Enabled="false" CssClass="textbox ancho" ToolTip="Espacio utilizado en el directorio de imágenes. Estimado en MB." />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label ID="lblArchivosFS" runat="server" Text="Archivos en directorio:" CssClass="etiqueta" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosDirectorio" runat="server" Enabled="false" CssClass="textbox numero" ToolTip="Archivos de imágenes presentes físicamente" />
					</td>
					<td>
						<asp:Label ID="lblArchivosDirectorioVinculados" runat="server" Text="Vinculados:" CssClass="etiqueta" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosDirectorioVinculados" runat="server" Enabled="false" CssClass="textbox numero" ToolTip="Archivos de imágenes en disco vinculadas a información de la base de datos" />
					</td>
					<td>
						<asp:Label ID="lblArchivosDirectorioSinVincular" runat="server" Text="No vinculados:" CssClass="etiqueta" />
					</td>
					<td>
						<asp:TextBox ID="txtArchivosDirectorioSinVincular" runat="server" Enabled="false" Visible='<%# CInt(Me.txtArchivosDirectorioSinVincular.Text) > 0 %>' CssClass="textbox numero error" ToolTip="Archivos de imágenes en disco no vinculados a la base de datos. " />
					</td>
				</tr>
				<tr>
					<td onclick="ShowProgress()">
						<asp:Button ID="btnActualizarDatosDirectorio" runat="server" Text="Actualizar información" CssClass="etiqueta-boton" ToolTip="Recalcula datos sobre el directorio, espacio utilizado y vinculación de imágenes a base de datos" />
					</td>
					<td>
						<asp:CheckBox ID="chkGenerarReporte" runat="server" Text="Generar reporte en Excel" CssClass="etiqueta" ToolTip="Genera reporte con detalle de las imágenes no vinculadas entre directorio y base de datos. " />
					</td>
				</tr>
			</table>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
	</body>
</html>
