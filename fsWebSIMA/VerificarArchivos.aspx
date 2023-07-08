<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VerificarArchivos.aspx.vb" Inherits="fsWebSIMA.VerificarArchivos" %>
<!doctype html>
<html>
	<head runat="server">
		<title>Verificar archivos</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="Scripts/sima.js"></script>
		<link type="text/css" rel="stylesheet" href="Senado.css" />
	</head>
	<body>
		<form id="form1" runat="server" onsubmit="return Procesando();">
			<div class="modal modal-backdrop" id="IdProcesando">
				<div class="modal-dialog modal-dialog-centered modal-sm">
					<div class="modal-content">
						<div class="modal-body">
							<div class="text-center">
								<div class="spinner-border text-primary"></div>
								<span class="text-primary">Procesando...</span>
							</div>
						</div>
					</div>
				</div>
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
				<div class="row">
					<div class="col-4">
						<asp:Button ID="btnIniciarVerificacion" runat="server" Text="Iniciar verificación" CssClass="btn btn-primary" />
					</div>
					<div class="col-3">
						<asp:CheckBox ID="chkReiniciarContadores" runat="server" Text="Reiniciar contadores" CssClass="form-check col-form-label-sm" ToolTip="Reiniciar contador de archivos hallados" />
					</div>
					<div class="col-3">
						<asp:Label ID="lblVerificados" runat="server" Text="Archivos localizados:" CssClass="col-form-label-sm" />
					</div>
					<div class="col-2">
						<asp:TextBox ID="txtVerificados" runat="server" Enabled="false" CssClass="form-control" />
					</div>
				</div>
				<hr />
				<div class="row align-self-center">
					<div class="col-9">
						<h6>Información general del directorio de imágenes (en disco):</h6>
					</div>
					<div class="col-3 align-content-start">
						<asp:TextBox ID="txtEspacioDisco" runat="server" Enabled="false" CssClass="form-control" ToolTip="Espacio utilizado en el directorio de imágenes. Estimado en MB." />
					</div>
				</div>
				<div class="row">
					<div class="col-4 form-group">
						<label for="txtArchivosDirectorio" class="col-form-label-sm">Archivos en directorio:</label>
						<asp:TextBox ID="txtArchivosDirectorio" runat="server" Enabled="false" CssClass="form-control" ToolTip="Archivos de imágenes presentes físicamente" />
					</div>
					<div class="col-4 form-group">
						<label for="txtArchivosDirectorioVinculados" class="col-form-label-sm">Vinculados:</label>
						<asp:TextBox ID="txtArchivosDirectorioVinculados" runat="server" Enabled="false" CssClass="form-control" ToolTip="Archivos de imágenes en disco vinculadas a información de la base de datos" />
					</div>
					<div class="col-4 form-group">
						<label for="txtArchivosDirectorioSinVincular" class="col-form-label-sm">No vinculados:</label>
						<asp:TextBox ID="txtArchivosDirectorioSinVincular" runat="server" Enabled="false" Visible='<%# CInt(Me.txtArchivosDirectorioSinVincular.Text) > 0 %>' CssClass="form-control text-danger font-weight-bold" ToolTip="Archivos de imágenes en disco no vinculados a la base de datos. " />
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<asp:button ID="btnActualizarDatosDirectorioSrv" runat="server" Text="Actualizar datos de directorio" CssClass="btn btn-primary" ToolTip="Recalcula datos sobre el directorio, espacio utilizado y vinculación de imágenes a base de datos" />	
					</div>
					<div class="col-4">
						<asp:CheckBox ID="chkGenerarReporte" runat="server" Text="Generar reporte en Excel" CssClass="form-check col-form-label-sm" ToolTip="Genera reporte con detalle de las imágenes no vinculadas entre directorio y base de datos. " />
					</div>
				</div>
				<hr />
			</div>
		</form>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script src="Scripts/popper.min.js"></script>
		<script src="Scripts/bootstrap.min.js"></script>
		<script type="text/javascript">
			function Procesando() {
				$('#IdProcesando').modal('show');
            };
        </script>
	</body>
</html>
