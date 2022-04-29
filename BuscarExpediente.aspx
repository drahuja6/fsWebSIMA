<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BuscarExpediente.aspx.vb" Inherits="fsWebS_SEN.BuscarExpediente"  %>

<!DOCTYPE html>

<html>
	<head>
		<title>BuscarExpediente</title>
		<script src="Scripts/jquery-3.6.0.min.js"></script>
		<script type="text/javascript" src="Scripts/sima.js"></script>
		<script type="text/javascript">
            $(function () {
                $("[id*=ibtMuestraDocs]").each(function () {
                    if ($(this)[0].src.indexOf("minus") != -1) {
                        $(this).closest("tr").after("<tr><td></td<td colspan = '999'>" + $(this).next().html() + "</td></tr>");
                        $(this).next().remove();
                    }
                });
            });
        </script>
		<link type="text/css" rel="stylesheet" href="Senado.css" />
	    <style type="text/css">
			.gvDocumentos td {
				background-color: #fff;
				color: black;
				line-height: 100%;
				font-size:smaller;
			}
            .auto-style1 {
                z-index: 135;
                left: 400px;
                position: absolute;
                top: 480px;
            }
            .auto-style2 {
                z-index: 134;
                left: 323px;
                position: absolute;
                top: 480px;
                right: 536px;
            }
            .auto-style3 {
                z-index: 137;
                left: 482px;
                position: absolute;
                top: 480px;
                width: 72px;
                right: 377px;
            }
            .auto-style4 {
                z-index: 138;
                left: 558px;
                position: absolute;
                top: 480px;
                width: 72px;
            }
            .auto-style5 {
                z-index: 139;
                left: 634px;
                position: absolute;
                top: 480px;
                width: 72px;
            }
            .auto-style6 {
                right: 377px;
                z-index: 140;
                left: 482px;
                position: absolute;
                top: 515px;
                width: 72px;
            }
            .auto-style7 {
                z-index: 141;
                left: 559px;
                position: absolute;
                top: 515px;
                width: 82px;
            }
            .auto-style8 {
                z-index: 142;
                left: 647px;
                position: absolute;
                top: 515px;
                width: 106px;
            }
            .auto-style9 {
                z-index: 145;
                left: 647px;
                position: absolute;
                top: 540px;
            }
            .auto-style10 {
                z-index: 143;
                left: 482px;
                position: absolute;
                top: 540px;
                width: 72px;
            }
            .auto-style11 {
                z-index: 144;
                left: 559px;
                position: absolute;
                top: 540px;
            }
            .auto-style12 {
                z-index: 146;
                position: absolute;
                top: 540px;
                left: 722px;
            }
            .auto-style13 {
                z-index: 131;
                left: 728px;
                position: absolute;
                top: 447px;
            }
            .auto-style15 {
                position: absolute;
                top: 460px;
                left: 8px;
            }
            .auto-style16 {
                z-index: 102;
                left: 573px;
                position: absolute;
                top: 450px;
            }
            .auto-style17 {
                position: absolute;
                left: 107px;
                top: 70px;
                width: 106px;
                height: 24px;
            }
            .auto-style18 {
                z-index: 127;
                left: 8px;
                width: 10%;
                position: absolute;
                top: 160px;
                height: -13px;
            }
            .auto-style19 {
                right: 883px;
            }
            .auto-style20 {
                z-index: 108;
                left: 8px;
                position: absolute;
                top: 168px;
                width: 196px;
            }
            .auto-style21 {
                z-index: 100;
                left: 107px;
                position: absolute;
                top: 8px;
                height: 60px;
                width: 106px;
            }
            .auto-style22 {
                z-index: 160;
                left: 8px;
                position: absolute;
                top: 28px;
                width: 49px;
            }
	    	[class*="grid"]{
				text-align:center;
	    	}
            .auto-style23 {
                z-index: 122;
                left: 163px;
                position: absolute;
                top: 344px;
            }
            .auto-style24 {
                z-index: 159;
                left: 59px;
                position: absolute;
                top: 416px;
            }
            .auto-style25 {
                z-index: 156;
                left: 59px;
                position: absolute;
                top: 392px;
            }
            .auto-style26 {
                z-index: 157;
                left: 59px;
                position: absolute;
                top: 368px;
            }
            .auto-style27 {
                z-index: 133;
                left: 59px;
                position: absolute;
                top: 344px;
            }
            .auto-style28 {
                z-index: 120;
                left: 59px;
                position: absolute;
                top: 320px;
            }
            .auto-style29 {
                z-index: 116;
                left: 59px;
                position: absolute;
                top: 272px;
            }
            .auto-style30 {
                z-index: 118;
                left: 59px;
                position: absolute;
                top: 296px;
            }
            .auto-style31 {
                z-index: 114;
                left: 131px;
                position: absolute;
                top: 240px;
            }
            .auto-style32 {
                z-index: 111;
                left: 48px;
                position: absolute;
                top: 192px;
                width: 155px;
            }
            .auto-style33 {
                z-index: 112;
                left: 48px;
                position: absolute;
                top: 216px;
                width: 155px;
            }
        </style>
	</head>
	<body bgColor="#ffffff" style="font-size:small">
		<form id="Form1" method="post" runat="server" style="font-size:small" onsubmit="return setHourglass()">
				<asp:label id="Label18" runat="server"
					Height="16px" Visible="true" Text="Unidades Administrativas" CssClass="auto-style22" />
				<asp:listbox id="lbUnidAdmin" tabIndex="1"
					runat="server" SelectionMode="Multiple" CssClass="auto-style21" />
				<asp:DropDownList ID="ddlCodigosUsuario" runat="server" CssClass="auto-style17" />
				<asp:label id="Label17" style="Z-INDEX: 160; LEFT: 8px; POSITION: absolute; TOP: 416px" runat="server"
					Height="16px" Width="48px" Visible="false">ObsTr:</asp:label>
				<asp:textbox id="txtObsTr" runat="server"
					Width="48px" Visible="false" CssClass="auto-style24"></asp:textbox>
				<asp:label id="Label16" style="Z-INDEX: 158; LEFT: 8px; POSITION: absolute; TOP: 368px" runat="server"
					Height="16px" Width="48px"  Visible="false">AnaqTr:</asp:label>
				<asp:textbox id="txtAnaqTr"
					runat="server" Width="48px" Visible="false" CssClass="auto-style26"></asp:textbox>
				<asp:label id="lblUbicTr" Text="UbicTr" style="Z-INDEX: 155; LEFT: 8px; POSITION: absolute; TOP: 392px; 
					right: 875px;" runat="server" Height="16px" Width="48px" Visible="false"/>
				<asp:textbox id="txtUbicTr"
					runat="server" Width="48px" Visible="false" CssClass="auto-style25"></asp:textbox>
				<asp:button id="btnExpedientesDadosDeBaja"
					runat="server" Height="23px" Width="32px" Text="Baja" Enabled="False" Visible="false" CssClass="auto-style12"></asp:button>
				<asp:button id="btnEnArchivoHistorico"
					runat="server" Height="23px" Width="72px" Text="Arch. Hist." Visible="False" Enabled="False" CssClass="auto-style9"></asp:button>
				<asp:button id="btnVencidosConcentracion"
					runat="server" Height="23px" Width="82px" Text="Venc. Conc." Visible="False" Enabled="False" CssClass="auto-style11"></asp:button>
				<asp:button id="btnVigentesConcentracion"
					runat="server" Height="23px" Text="Vig. Conc." Enabled="False" Visible="false" CssClass="auto-style10"></asp:button>
				<asp:button id="btnVencidosTramite"
					runat="server" Height="23px" Text="Venc. Trám." Visible="False" Enabled="False" CssClass="auto-style7"></asp:button>
				<asp:button id="btnExpedientesActivos"
					runat="server" Height="23px" Text="Vig. Trám." Enabled="False" Visible="false" CssClass="auto-style6"></asp:button>
				<asp:button id="btnLomos"
					runat="server" Height="23px" Text="Lomos" Enabled="False" ToolTip="Imprimir lomos de expedientes" CssClass="auto-style5"></asp:button>
				<asp:button id="btnEtiquetas"
					runat="server" Height="23px" Text="Etiquetas" Enabled="False" ToolTip="Imprimir etiquetas" CssClass="auto-style4"></asp:button>
				<asp:button id="btnImprimeListadoDeExpedientes"
					runat="server" Height="23px" Width="72px" Text="Imp. Lista" Enabled="False" ToolTip="Imprimir lista de expedientes" CssClass="auto-style1"></asp:button>
				<asp:button id="btnImprimeGuiaDeExpedientes"
					runat="server" Height="23px" Width="72px" Text="Imp. Guía" Enabled="False" ToolTip="Imprime guía de expedientes" CssClass="auto-style2"></asp:button>
				<asp:label id="Label1" style="Z-INDEX: 132; LEFT: 8px; POSITION: absolute; TOP: 344px" runat="server"
					Height="16px" Width="48px" Visible="false">CajaTr:</asp:label>
				<asp:textbox id="txtRelAnt"
					runat="server" Width="48px" Visible="false" CssClass="auto-style27"></asp:textbox>
				<asp:label id="lblCodigo" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 74px" runat="server"
					Height="24px" Width="56px" Text="Código"></asp:label>
				<hr style="Z-INDEX: 126; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 88px; HEIGHT: 1px" SIZE="1">
				<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 97px" runat="server"
					Height="16px" Width="208px">Fecha de apertura (dd/mm/aaaa):</asp:label>
				<asp:label id="Label4" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 120px" runat="server"
					Height="16px" Width="40px">Desde:</asp:label>
				<asp:textbox id="txtFApertInic" style="Z-INDEX: 105; LEFT: 48px; POSITION: absolute; TOP: 120px"
					tabIndex="3" runat="server" Width="160px" MaxLength="10"></asp:textbox>&nbsp;
				<asp:textbox id="txtFApertFinal" style="Z-INDEX: 106; LEFT: 48px; POSITION: absolute; TOP: 144px"
					tabIndex="4" runat="server" Width="160px" MaxLength="10"></asp:textbox>
				<asp:label id="Label3" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 144px" runat="server"
					Height="16px" Width="40px">Hasta:</asp:label>
				<hr SIZE="1" class="auto-style18">
				<asp:label id="Label5" runat="server"
					Height="16px" Text="Consecutivo expediente:" CssClass="auto-style20"/>
				<asp:label id="Label6" style="Z-INDEX: 109; LEFT: 8px; POSITION: absolute; TOP: 192px" runat="server"
					Height="16px" Width="40px">Desde:</asp:label>
				<asp:label id="Label7" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 216px" runat="server"
					Height="16px" Width="40px" Text="Hasta:" Visible="True" CssClass="auto-style19" />
				<asp:textbox id="txtExpInic"
					runat="server" CssClass="auto-style32" />
				<asp:textbox id="txtExpFinal"
					runat="server" Visible="true" CssClass="auto-style33" />
				<asp:label id="Label8" style="Z-INDEX: 113; LEFT: 8px; POSITION: absolute; TOP: 240px" runat="server"
					Height="24px" Width="128px" Visible="False">Caracteres excluídos</asp:label>
				<asp:textbox id="txtCaractExclu"
					runat="server" Width="72px" Visible="False" CssClass="auto-style31"></asp:textbox>
				<hr style="Z-INDEX: 128; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 259px; HEIGHT: 1px" SIZE="1">
				<asp:label id="Label9" style="Z-INDEX: 115; LEFT: 8px; POSITION: absolute; TOP: 272px" runat="server"
					Height="16px" Width="40px">Ref:</asp:label>
				<asp:textbox id="txtTipo" runat="server"
					Width="144px" CssClass="auto-style29"></asp:textbox>
				<asp:label id="Label10" style="Z-INDEX: 117; LEFT: 8px; POSITION: absolute; TOP: 296px; bottom: 159px;" runat="server"
					Height="16px" Width="40px">Título:</asp:label>
				<asp:textbox id="txtRFC" runat="server"
					Width="144px" CssClass="auto-style30"></asp:textbox>
				<asp:label id="Label11" style="Z-INDEX: 119; LEFT: 8px; POSITION: absolute; TOP: 320px" runat="server"
					Height="16px" Width="40px">Asunto:</asp:label><asp:textbox id="txtNombre"
					runat="server" Width="145px" CssClass="auto-style28" ></asp:textbox>
				<asp:label id="Label12" style="Z-INDEX: 121; LEFT: 120px; POSITION: absolute; TOP: 344px" runat="server"
					Height="16px" Width="40px">Caja:</asp:label>
				<asp:textbox id="txtCaja" runat="server"
					Width="42px" CssClass="auto-style23"></asp:textbox>
				<asp:regularexpressionvalidator id="RegularExpressionValidator1" style="Z-INDEX: 125; LEFT: 208px; POSITION: absolute; TOP: 120px"
					runat="server" ControlToValidate="txtFApertInic" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
				<asp:regularexpressionvalidator id="RegularExpressionValidator2" style="Z-INDEX: 129; LEFT: 208px; POSITION: absolute; TOP: 144px"
					runat="server" ControlToValidate="txtFApertFinal" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
				<asp:panel id="Panel1" style="Z-INDEX: 130; LEFT: 216px; OVERFLOW: auto; POSITION: absolute; TOP: 8px"
					runat="server" Height="430px" Width="800px" BorderStyle="outset">
					<asp:datagrid id="DataGrid1" runat="server" Width="598px" Height="176px" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="true" PageSize="12">
						<AlternatingItemStyle Wrap="False" BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#284775"></AlternatingItemStyle>
						<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
						<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
						<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
						<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
						<Columns>
							<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Expediente" HeaderText=" " />
							<asp:TemplateColumn HeaderText=" ">
								<ItemTemplate>
									<asp:Label ID="txtArchivosNoLocalizados" runat="server" Text='<%# String.Format("{0}", DataBinder.Eval(Container, "DataItem.ArchivosNoLocalizados")) %>' Visible="false" CssClass="" />
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText=" ">
								<ItemTemplate>
									<asp:ImageButton ID="ibtMuestraDocs" runat="server" CommandName="Documentos" ImageUrl="~/images/docs.png"
										CommandArgument="Show" Visible='<%# If(Eval("ArchivosLocalizados").ToString <= "0", False, True) %>' />
									<asp:Panel ID="pnlDocumentos" Width="180px" runat="server" Visible="false" Style="position:relative;">
                                        <asp:GridView ID="gvDocumentos" runat="server" AutoGenerateColumns="false" CssClass="gvDocumentos" ShowHeader="false" OnRowCommand="GvDocumentos_RowCommand">
											<Columns>
												<asp:ButtonField ButtonType="Link" DataTextField="Descripcion" ControlStyle-CssClass="docs-link"/>
											</Columns>
										</asp:GridView>
									</asp:Panel>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:BoundColumn DataField="Codigo" SortExpression="Codigo" HeaderText="C&#243;digo">
								<HeaderStyle Width="20%"/>
								<ItemStyle Wrap="False"/>
							</asp:BoundColumn>
							<asp:BoundColumn Visible="False" DataField="idExpediente" HeaderText="idExpediente"/>
							<asp:BoundColumn DataField="Expediente" SortExpression="Numero" HeaderText="Número">
								<HeaderStyle Width="20%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:TemplateColumn  HeaderText="Digitalización">
								<ItemTemplate>
									<asp:Label ID="lblDigitalizacion" runat="server" Text='<%# If(DataBinder.Eval(Container, "DataItem.Digitalizacion"), "Sí", "No") %>' />
								</ItemTemplate>
								<ItemStyle CssClass="grid" />
							</asp:TemplateColumn>
							<asp:BoundColumn DataField="Observaciones" SortExpression="Observaciones" HeaderText="Obs" Visible="false">
							</asp:BoundColumn>
							<asp:BoundColumn DataField="CajaAnterior" SortExpression="CajaAnterior" HeaderText="Caja Anterior" Visible="false"></asp:BoundColumn>
							<asp:BoundColumn DataField="Caja" SortExpression="Caja" HeaderText="Caja">
								<HeaderStyle Width="20%"></HeaderStyle>
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="Apertura" SortExpression="FechaApertura" HeaderText="Apertura"/>
							<asp:BoundColumn DataField="Cierre" HeaderText="Cierre"/>
							<asp:BoundColumn DataField="Titulo" SortExpression="Titulo" HeaderText="Título" Visible="True"/>
							<asp:BoundColumn DataField="NombreCorto" SortExpression="UnidAdmin" HeaderText="Unidad Adm.">
								<HeaderStyle Width="10%"/>
								<ItemStyle Wrap="False"/>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="Asunto" HeaderText="Asunto">
								<HeaderStyle Width="20%"></HeaderStyle>
								<ItemStyle Wrap="False" ></ItemStyle>
							</asp:BoundColumn>
						</Columns>
						<PagerStyle BackColor="#5D7B9D" ForeColor="White" HorizontalAlign="Left" NextPageText=">>" PrevPageText="<<" Mode="NextPrev" Position="Top" />
						<SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
					</asp:datagrid>
					<asp:Label id="NoHayDatos" runat="server" Visible="False" Font-Bold="True">No se encontraron datos para este criterio de búsqueda</asp:Label>
				</asp:panel>
				<asp:button id="Button2" runat="server"
					Height="23px" Width="152px" Text="Ver ventana de edición" ToolTip="Permite ver directamente la ventana de edición de expedientes, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)" CssClass="auto-style13"></asp:button>
				<asp:radiobutton id="RadioButtonPDF" style="Z-INDEX: 147; LEFT: 768px; POSITION: absolute; TOP: 540px"
					runat="server" Width="48px" Text=".pdf" Enabled="False" Checked="True" GroupName="Formato"></asp:radiobutton>
				<asp:radiobutton id="RadioButtonXLS" style="Z-INDEX: 148; LEFT: 824px; POSITION: absolute; TOP: 540px"
					runat="server" Text=".xls" Enabled="False" GroupName="Formato" Visible="false"></asp:radiobutton>
				<asp:button id="btnCaratulasNoCredito"
					runat="server" Height="23px" Text="Carátulas" Enabled="False" ToolTip="Imprimir carátulas" CssClass="auto-style3"></asp:button>
				<asp:button id="btnEnTraspasoAConcentracion"
					runat="server" Height="23px" Text="Trasp. a Conc." Visible="False" Enabled="False" CssClass="auto-style8"></asp:button>
				<asp:panel ID="panelBusqueda" runat="server" CssClass="auto-style15">
					<table style="width:300px">
						<tr>
							<td colspan="4">
								<asp:checkbox id="cbBusqExacta" CssClass="etiqueta" runat="server" Text="Búsqueda exacta" TextAlign="Left" />
							</td>
						</tr>
						<tr>
							<td>
								<asp:label id="Label13" CssClass="etiqueta" Text="Límite:" runat="server"/>
							</td>
							<td>
								<asp:textbox id="txtLimite" CssClass="etiqueta-textbox" runat="server"/>
							</td>
							<td>
								<asp:label id="lblLimiteExcedido" CssClass="etiqueta error" runat="server" Text="*" Visible="False"/>
							</td>
							<td><br /></td>
						</tr>
						<tr>
							<td>
								<asp:label id="Label14" CssClass="etiqueta" Text="Real:" runat="server"/>
							</td>
							<td>
								<asp:textbox id="txtReal" CssClass="etiqueta-textbox" runat="server" Enabled="False"/>
							</td>
							<td colspan="2"><br /></td>
						</tr>
						<tr>
							<td>
								<asp:label id="Label15" CssClass="etiqueta" Text="Ordena por:" runat="server" style="vertical-align:top;"/>
							</td>
							<td>
								<asp:DropDownList ID="ordenamientoDropDownList" CssClass="etiqueta-textbox" runat="server" AutoPostBack="True" Height="30px" Width="180"/>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<asp:button id="buscarButton" CssClass="etiqueta-boton" runat="server" Height="23px" Width="100px" Text="Busca"></asp:button>
							</td>
							<td><br /></td>
						</tr>
					</table>
				</asp:panel>
				<asp:textbox id="txtCodigo" tabIndex="2"
					runat="server" Height="20px" Width="136px" CssClass="auto-style16" Visible="False"></asp:textbox>

		</form>
	</body>
</html>
