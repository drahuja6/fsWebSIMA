<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BusquedaExpedientesGestionRRHH.aspx.vb" Inherits="fsWebSIMA.BusquedaExpedientesGestionRRHH" %>
<!doctype html>
<html>
<head runat="server">
    <title>Búsqueda de expedientes</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="Content/bootstrap.min.css" rel="stylesheet">
    <link href="Scripts/jquery-ui-1.13.2/jquery-ui.css" rel="stylesheet">
	<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <style>
        .panelGrid {
            min-width: 1000px;
			max-width: 100%;
			height: 735px;
			border: solid 1px grey;
			overflow: auto;
			margin-left: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" onsubmit="setHourglass()">
		<div class="container-fluid ml-2 mt-1">
			<div class="row align-items-center mt-2 ml-1">
				<h4>Búsqueda de expedientes Recursos humanos</h4>			
            </div>
			<div class="row ml-2">
				<h6>Datos del empleado:</h6>
			</div>
            <div class="row m-2"></div>
			<table style="border-collapse:collapse; ">
				<tr>
					<td style="min-width:300px; max-width:300px;">
						<table>
							<tr>
								<td>
									<asp:label id="lblEstado" runat="server" CssClass="form-control-sm" Text="Estado:" />
								</td>
								<td colspan="2">
									<asp:DropDownList ID="ddlEstado" runat="server" CssClass="dropdown form-control-sm w-100" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lblNumeroEmpleado" runat="server" CssClass="form-control-sm" Text="Número:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtNumero" runat="server" CssClass="form-control-sm" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lblNombre" runat="server" CssClass="form-control-sm" Text="Nombre:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtNombre"	runat="server" CssClass="form-control-sm" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lblTipoContratacion" runat="server" CssClass="form-control-sm" Text="Contratación:" />
								</td>
								<td colspan="2">
									<asp:DropDownList ID="ddlTipoContratacion" runat="server" CssClass="dropdown form-control-sm w-100" />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<hr />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<asp:label id="Label2" runat="server" CssClass="form-control-sm" Text="Fecha de apertura (d/m/aaaa):" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label4" runat="server" CssClass="form-control-sm" Text="Desde:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtFApertInic" CssClass="fecha form-control-sm" runat="server" />
								</td>
								<td>
									<asp:regularexpressionvalidator id="RegularExpressionValidator1" CssClass="text-danger text-sm-right" runat="server" ControlToValidate="txtFApertInic" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label3" runat="server" CssClass="form-control-sm" Text="Hasta:" />
								</td>
								<td colspan="2">
									<asp:textbox id="txtFApertFinal" runat="server" CssClass="fecha form-control-sm" />
								</td>
								<td>
									<asp:regularexpressionvalidator id="RegularExpressionValidator2" runat="server" CssClass="text-danger text-sm-right" ControlToValidate="txtFApertFinal" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<hr />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<asp:label id="Label5" runat="server" Text="Consecutivo expediente:" CssClass="form-control-sm invisible"/>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label6" runat="server" CssClass="form-control-sm invisible" Text="Desde:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtExpInic" runat="server" CssClass="form-control-sm invisible" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label7" runat="server" CssClass="form-control-sm invisible" Text="Hasta:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtExpFinal" runat="server" CssClass="form-control-sm invisible" />			
								</td>
							</tr>
							<tr class="invisible">
								<td colspan="4">
									<hr />
								</td>
							</tr>

							<tr>
								<td>
									<asp:label id="Label11" runat="server" CssClass="form-control-sm invisible" Text="Caja:" />
								</td>
								<td colspan="3">
									<asp:textbox id="txtCaja" runat="server" CssClass="form-control-sm invisible"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<hr />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<asp:checkbox id="cbBusqExacta" CssClass="form-check" runat="server" Text="Búsqueda exacta" TextAlign="Right" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label13" CssClass="form-control-sm" Text="Límite:" runat="server"/>
								</td>
								<td>
									<asp:textbox id="txtLimite" CssClass="form-control-sm" runat="server"/>
								</td>
								<td>
									<asp:label id="lblLimiteExcedido" CssClass="text-danger" runat="server" Text="*" Visible="False"/>
								</td>
								<td><br /></td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label14" CssClass="form-control-sm" Text="Real:" runat="server"/>
								</td>
								<td>
									<asp:textbox id="txtReal" CssClass="form-control-sm" runat="server" Enabled="False"/>
								</td>
								<td colspan="2"><br /></td>
							</tr>
							<tr>
								<td>
									<asp:label id="Label15" CssClass="form-control-sm" Text="Ordena por:" runat="server" style="vertical-align:top;"/>
								</td>
								<td colspan="2">
									<asp:DropDownList ID="ordenamientoDropDownList" CssClass="dropdown form-control-sm w-100" runat="server" AutoPostBack="True" />
								</td>
							</tr>
							<tr>
								<td></td>
								<td colspan="2">
									<asp:button id="buscarButton" CssClass="btn btn-primary btn-block" runat="server" Text="Busca" ToolTip="Ejecutar la búsqueda" />
								</td>				
							</tr>
						</table>
					</td>
					<td style="min-width:1000px; max-width:100%; vertical-align: top;">
						<asp:Panel ID="panGridExpedientes" runat="server" CssClass="panelGrid">
							<asp:datagrid id="DataGrid1" runat="server" Width="100%" Height="400px" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="true" PageSize="20">
								<AlternatingItemStyle Wrap="False" BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#284775"></AlternatingItemStyle>
								<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
								<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
								<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
								<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
								<Columns>
									<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Expediente" HeaderText=" " />
									<asp:TemplateColumn HeaderText=" ">
										<ItemTemplate>
											<asp:ImageButton ID="ibtMuestraDocs" runat="server" CommandName="Documentos" ImageUrl="~/images/docs.png"
												CommandArgument="Show" Visible='<%# If(Eval("ArchivosLocalizados").ToString <= "0", False, True) %>' />
											<asp:Panel ID="pnlDocumentos" runat="server" Visible="false" CssClass="container-sm" >
												<asp:GridView ID="gvDocumentos" runat="server" AutoGenerateColumns="false" CssClass="table table-borderless table-striped table-responsive-sm table-hover border-0" ShowHeader="false" OnRowCommand="GvDocumentos_RowCommand">
													<Columns>
														<asp:ButtonField ButtonType="Link" DataTextField="Descripcion" ControlStyle-CssClass="btn btn-link btn-sm" ControlStyle-Font-Size="Small"/>
													</Columns>
												</asp:GridView>
											</asp:Panel>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="Codigo" SortExpression="Codigo" HeaderText="C&#243;digo" />
									<asp:BoundColumn Visible="False" DataField="idExpediente" HeaderText="idExpediente"/>
									<asp:BoundColumn DataField="Expediente" SortExpression="Expediente" HeaderText="Expediente" />
									<asp:TemplateColumn  HeaderText="Digitalización">
										<ItemTemplate>
											<asp:Label ID="lblDigitalizacion" runat="server" Text='<%# If(DataBinder.Eval(Container, "DataItem.Digitalizacion"), "Sí", "No") %>' />
											<asp:Label ID="lblArchivosLocalizados" runat="server" Text='<%# If(DataBinder.Eval(Container, "DataItem.Digitalizacion"), String.Format("/ {0} / {1}", DataBinder.Eval(Container, "DataItem.ArchivosLocalizados"), DataBinder.Eval(Container, "DataItem.ArchivosNoLocalizados")), "") %>' Visible="True" />
										</ItemTemplate>
										<ItemStyle CssClass="grid" />
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText=" ">
										<ItemTemplate>
											<asp:Label ID="txtArchivosNoLocalizados" runat="server" Text='<%# String.Format("{0}", DataBinder.Eval(Container, "DataItem.ArchivosNoLocalizados")) %>' Visible="False" CssClass="" />
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="Estado" SortExpression="Estado" HeaderText="Estado" Visible="false" />
									<asp:BoundColumn DataField="Contratacion" SortExpression="Contratacion" HeaderText="Contratación" Visible="false" />
									<asp:BoundColumn DataField="CajaAnterior" SortExpression="CajaAnterior" HeaderText="Caja Anterior" Visible="false"></asp:BoundColumn>
									<asp:BoundColumn DataField="Caja" SortExpression="Caja" HeaderText="Caja" />
									<asp:BoundColumn DataField="Apertura" SortExpression="FechaApertura" HeaderText="Apertura"/>
									<asp:BoundColumn DataField="Cierre" HeaderText="Cierre"/>
									<asp:BoundColumn DataField="Numero" SortExpression="Numero" HeaderText="Número" Visible="True"/>
									<asp:BoundColumn DataField="NombreCorto" SortExpression="UnidAdmin" HeaderText="Unidad Adm." />
									<asp:BoundColumn DataField="Nombre" HeaderText="Nombre" />
								</Columns>
								<PagerStyle BackColor="#5D7B9D" ForeColor="White" HorizontalAlign="Left" NextPageText=">>" PrevPageText="<<" Mode="NextPrev" Position="Top" />
								<SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
							</asp:datagrid>
							<asp:Label id="NoHayDatos" runat="server" Visible="False" Text="No se encontraron datos para este criterio de búsqueda" CssClass="text-info" />
						</asp:Panel>
					</td>
				</tr>
				<tr>
					<td>
						<p />
					</td>
					<td>
						<table>
							<tr>
								<td colspan="5">
									<asp:label id="Label12" runat="server" CssClass="etiqueta" Text="Impresión de formatos" />
								</td>
							</tr>
							<tr>
								<td>
									<asp:button id="btnImprimeGuiaDeExpedientes" runat="server" Text="Guía" Enabled="False" ToolTip="Imprime guía de expedientes" CssClass="btn btn-primary btn-block" />
								</td>
								<td>
									<asp:button id="btnImprimeListadoDeExpedientes"	runat="server" Text="Lista" Enabled="False" ToolTip="Imprimir lista de expedientes" CssClass="btn btn-primary btn-block" />
								</td>
								<td>
									<asp:button id="btnCaratulasExpediente" runat="server" Text="Carátulas" Enabled="False" ToolTip="Imprimir carátulas" CssClass="btn btn-primary"  />
								</td>
								<td>
									<asp:button id="btnEtiquetas" runat="server" Text="Etiquetas" Enabled="False" ToolTip="Imprimir etiquetas" CssClass="btn btn-primary" />
								</td>
								<td>
									<asp:button id="btnLomos" runat="server" Text="Lomos" Enabled="False" ToolTip="Imprimir lomos de expedientes" CssClass="btn btn-primary" />
								</td>
								<td>
									<asp:button id="btnExportaExcel" runat="server" Text="Exportar" ToolTip="Exportar listado de expedientes a Excel" CssClass="btn btn-primary" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table style="width: 100%">
							<tr>
								<td>
									<asp:textbox id="txtRelAnt"	runat="server" Visible="false" />
									<asp:textbox id="txtAnaqTr"	runat="server" Visible="false" />
									<asp:textbox id="txtCaractExclu" runat="server" Visible="False" />
									<asp:textbox id="txtUbicTr"	runat="server" Visible="false" />
									<asp:textbox id="txtCodigo" tabIndex="2" runat="server" Visible="False" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
    </form>
	<script src="Scripts/jquery-3.6.0.min.js"></script>
	<script src="Scripts/popper.min.js"></script>
	<script src="Scripts/bootstrap.min.js"></script>
	<script src="Scripts/jquery-ui-1.13.2/jquery-ui.js"></script>
	<script type="text/javascript" src="Scripts/sima.js"></script>
	<script type="text/javascript">
		$(function () {
            $(".fecha").datepicker({
				showOn: 'button',
				buttonImageOnly: true,
				buttonImage: 'images/calendario.png',
				dateFormat: 'd/m/yy'
			});
		});
    </script>
	<script type="text/javascript">
        $(function () {
            $("[id*=ibtMuestraDocs]").each(function () {
                if ($(this)[0].src.indexOf("minus") != -1) {
                    $(this).closest("tr").after("<tr><td colspan = '6'>" + $(this).next().html() + "</td></tr>");
                    $(this).next().remove();
                }
            });
        });
    </script>
</body>
</html>
