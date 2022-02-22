<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BuscarExpediente.aspx.vb" Inherits="fsWebS_SEN.BuscarExpediente" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>BuscarExpediente</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style type="text/css">
			#PanelEspera { 
				width:200px; height:200px; position: relative;
				float: left; margin-left: 10px; margin-top: 10px;
				border-right: gray 1px solid; border-top: gray 1px solid; 
				border-left: gray 1px solid; border-bottom: gray 1px solid;
				}
				#ProgresoEspera {
				width: 200px; background-color: #FFC080;
				position: absolute; bottom: 0px; left: 0px;
				}
		</style>
	</HEAD>
	<body bgColor="#ffffff" style="font-size:small">
		<form id="Form1" method="post" runat="server" style="font-size:small">
			<asp:listbox id="lbUnidAdmin" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px" tabIndex="1"
				runat="server" Height="64px" Width="200px" SelectionMode="Multiple"></asp:listbox>
			<asp:label id="Label17" style="Z-INDEX: 160; LEFT: 8px; POSITION: absolute; TOP: 416px" runat="server"
				Height="16px" Width="48px" Visible="false">ObsTr:</asp:label>
			<asp:textbox id="txtObsTr" style="Z-INDEX: 159; LEFT: 64px; POSITION: absolute; TOP: 416px" runat="server"
				Height="20px" Width="48px" BorderStyle="Ridge"  Visible="false"></asp:textbox>
			<asp:label id="Label16" style="Z-INDEX: 158; LEFT: 8px; POSITION: absolute; TOP: 368px" runat="server"
				Height="16px" Width="48px"  Visible="false">AnaqTr:</asp:label>
			<asp:textbox id="txtAnaqTr" style="Z-INDEX: 157; LEFT: 64px; POSITION: absolute; TOP: 368px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge"  Visible="false"></asp:textbox>
			<asp:label id="lblUbicTr" Text="UbicTr" style="Z-INDEX: 155; LEFT: 8px; POSITION: absolute; TOP: 392px; 
				right: 875px;" runat="server" Height="16px" Width="48px" Visible="false"/>
			<asp:textbox id="txtUbicTr" style="Z-INDEX: 156; LEFT: 64px; POSITION: absolute; TOP: 392px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge"  Visible="false"></asp:textbox>
			<asp:button id="btnExpedientesDadosDeBaja" style="Z-INDEX: 146; LEFT: 728px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="32px" Text="Baja" Enabled="False" Visible="false"></asp:button>
			<asp:button id="btnEnArchivoHistorico" style="Z-INDEX: 145; LEFT: 648px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="72px" Text="Arch. Hist." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVencidosConcentracion" style="Z-INDEX: 144; LEFT: 560px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="82px" Text="Venc. Conc." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVigentesConcentracion" style="Z-INDEX: 143; LEFT: 488px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="66px" Text="Vig. Conc." Enabled="False" Visible="false"></asp:button>
			<asp:button id="btnEnTraspasoAConcentracion" style="Z-INDEX: 142; LEFT: 384px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="96px" Text="Trasp. a Conc." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVencidosTramite" style="Z-INDEX: 141; LEFT: 296px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="80px" Text="Venc. Trám." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnExpedientesActivos" style="Z-INDEX: 140; LEFT: 224px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="64px" Text="Vig. Trám." Enabled="False" Visible="false"></asp:button>
			<asp:button id="btnLomos" style="Z-INDEX: 139; LEFT: 656px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="64px" Text="Lomos" Enabled="False" ToolTip="Imprimir lomos de expedientes"></asp:button>
			<asp:button id="btnEtiquetas" style="Z-INDEX: 138; LEFT: 584px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="64px" Text="Etiquetas" Enabled="False" ToolTip="Imprimir etiquetas"></asp:button>
			<asp:button id="btnImprimeListadoDeExpedientes" style="Z-INDEX: 135; LEFT: 304px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="72px" Text="Imp. Lista" Enabled="False" ToolTip="Imprimir lista de expedientes"></asp:button>
			<asp:button id="btnImprimeGuiaDeExpedientes" style="Z-INDEX: 134; LEFT: 224px; POSITION: absolute; TOP: 480px; "
				runat="server" Height="23px" Width="72px" Text="Imp. Guía" Enabled="False" ToolTip="Imprime guía de expedientes"></asp:button>
			<asp:label id="Label1" style="Z-INDEX: 132; LEFT: 8px; POSITION: absolute; TOP: 344px" runat="server"
				Height="16px" Width="48px" Visible="false">CajaTr:</asp:label>
			<asp:textbox id="txtRelAnt" style="Z-INDEX: 133; LEFT: 64px; POSITION: absolute; TOP: 344px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge" Visible="false"></asp:textbox>
			<asp:label id="lblCodigo" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 74px" runat="server"
				Height="24px" Width="56px" Text="Código"></asp:label>
			<asp:textbox id="txtCodigo" style="Z-INDEX: 102; LEFT: 72px; POSITION: absolute; TOP: 74px" tabIndex="2"
				runat="server" Height="20px" Width="136px"></asp:textbox>
			<hr style="Z-INDEX: 126; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 88px; HEIGHT: 1px" SIZE="1">
			<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 97px" runat="server"
				Height="16px" Width="208px">Fecha de apertura (dd/mm/aaaa):</asp:label>
			<asp:label id="Label4" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 120px" runat="server"
				Height="16px" Width="40px">Inicial</asp:label>
			<asp:textbox id="txtFApertInic" style="Z-INDEX: 105; LEFT: 48px; POSITION: absolute; TOP: 120px"
				tabIndex="3" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>&nbsp;
			<asp:textbox id="txtFApertFinal" style="Z-INDEX: 106; LEFT: 48px; POSITION: absolute; TOP: 144px"
				tabIndex="4" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>
			<asp:label id="Label3" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 144px" runat="server"
				Height="16px" Width="40px">Final</asp:label>
			<hr style="Z-INDEX: 127; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 160px; HEIGHT: 1px" SIZE="1">
			<asp:label id="Label5" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 168px" runat="server"
				Height="16px" Width="136px">Expediente (rango):</asp:label>
			<asp:label id="Label6" style="Z-INDEX: 109; LEFT: 8px; POSITION: absolute; TOP: 192px" runat="server"
				Height="16px" Width="40px">Inicial</asp:label>
			<asp:label id="Label7" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 216px" runat="server"
				Height="16px" Width="40px">Final</asp:label>
			<asp:textbox id="txtExpInic" style="Z-INDEX: 111; LEFT: 48px; POSITION: absolute; TOP: 192px"
				runat="server" Height="20px" Width="160px" BorderStyle="Ridge"></asp:textbox>
			<asp:textbox id="txtExpFinal" style="Z-INDEX: 112; LEFT: 48px; POSITION: absolute; TOP: 216px"
				runat="server" Height="20px" Width="160px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label8" style="Z-INDEX: 113; LEFT: 8px; POSITION: absolute; TOP: 240px" runat="server"
				Height="24px" Width="128px">Caracteres excluídos</asp:label>
			<asp:textbox id="txtCaractExclu" style="Z-INDEX: 114; LEFT: 136px; POSITION: absolute; TOP: 240px"
				runat="server" Height="20px" Width="72px" BorderStyle="Ridge"></asp:textbox>
			<hr style="Z-INDEX: 128; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 259px; HEIGHT: 1px" SIZE="1">
			<asp:label id="Label9" style="Z-INDEX: 115; LEFT: 8px; POSITION: absolute; TOP: 272px" runat="server"
				Height="16px" Width="40px">Ref:</asp:label>
			<asp:textbox id="txtTipo" style="Z-INDEX: 116; LEFT: 64px; POSITION: absolute; TOP: 272px" runat="server"
				Height="20px" Width="144px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label10" style="Z-INDEX: 117; LEFT: 8px; POSITION: absolute; TOP: 296px; bottom: 159px;" runat="server"
				Height="16px" Width="40px">Título:</asp:label>
			<asp:textbox id="txtRFC" style="Z-INDEX: 118; LEFT: 64px; POSITION: absolute; TOP: 296px" runat="server"
				Height="20px" Width="144px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label11" style="Z-INDEX: 119; LEFT: 8px; POSITION: absolute; TOP: 320px" runat="server"
				Height="16px" Width="40px">Asunto:</asp:label><asp:textbox id="txtNombre" style="Z-INDEX: 120; LEFT: 64px; POSITION: absolute; TOP: 320px"
				runat="server" Height="20px" Width="145px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label12" style="Z-INDEX: 121; LEFT: 120px; POSITION: absolute; TOP: 344px" runat="server"
				Height="16px" Width="40px">Caja:</asp:label>
			<asp:textbox id="txtCaja" style="Z-INDEX: 122; LEFT: 168px; POSITION: absolute; TOP: 344px" runat="server"
				Height="20px" Width="42px" BorderStyle="Ridge"></asp:textbox>
			<asp:regularexpressionvalidator id="RegularExpressionValidator1" style="Z-INDEX: 125; LEFT: 208px; POSITION: absolute; TOP: 120px"
				runat="server" ControlToValidate="txtFApertInic" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
			<asp:regularexpressionvalidator id="RegularExpressionValidator2" style="Z-INDEX: 129; LEFT: 208px; POSITION: absolute; TOP: 144px"
				runat="server" ControlToValidate="txtFApertFinal" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
			<asp:panel id="Panel1" style="Z-INDEX: 130; LEFT: 216px; OVERFLOW: auto; POSITION: absolute; TOP: 8px"
				runat="server" Height="424px" Width="664px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" Width="598px" Height="176px" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="15">
					<AlternatingItemStyle Wrap="False" BackColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#284775"></AlternatingItemStyle>
					<ItemStyle Wrap="False" BackColor="#F7F6F3" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333"></ItemStyle>
					<EditItemStyle BackColor="#999999" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
					<HeaderStyle Font-Underline="True" Font-Bold="True" BackColor="#5D7B9D" Font-Italic="False" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" ForeColor="White"></HeaderStyle>
					<Columns>
						<asp:ButtonColumn Text="..." ButtonType="PushButton" CommandName="Select">
							<HeaderStyle Width="8%"/>
							<ItemStyle Wrap="False" HorizontalAlign="Center"/>
						</asp:ButtonColumn>
						<asp:BoundColumn DataField="Codigo" SortExpression="Codigo" HeaderText="C&#243;digo">
							<HeaderStyle Width="20%"/>
							<ItemStyle Wrap="False"/>
						</asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="idExpediente" HeaderText="idExpediente"/>
						<asp:BoundColumn DataField="Expediente" SortExpression="Numero" HeaderText="Número">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
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
				    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Position="TopAndBottom" />
                    <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" />
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Visible="False" Font-Bold="True">No se encontraron datos para este criterio de búsqueda</asp:Label>
			</asp:panel>
			<asp:button id="Button2" style="Z-INDEX: 131; LEFT: 728px; POSITION: absolute; TOP: 480px" runat="server"
				Height="23px" Width="152px" Text="Ver ventana de edición" ToolTip="Permite ver directamente la ventana de edición de expedientes, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)"></asp:button>
			<asp:radiobutton id="RadioButtonPDF" style="Z-INDEX: 147; LEFT: 768px; POSITION: absolute; TOP: 448px"
				runat="server" Width="48px" Text=".pdf" Enabled="False" Checked="True" GroupName="Formato"></asp:radiobutton>
			<asp:radiobutton id="RadioButtonXLS" style="Z-INDEX: 148; LEFT: 824px; POSITION: absolute; TOP: 448px"
				runat="server" Text=".xls" Enabled="False" GroupName="Formato" Visible="false"></asp:radiobutton>
		    <p>
			<asp:button id="btnCaratulasNoCredito" style="Z-INDEX: 137; LEFT: 512px; POSITION: absolute; TOP: 480px; right: 355px;"
				runat="server" Height="23px" Width="64px" Text="Carátulas" Enabled="False" ToolTip="Imprimir carátulas"></asp:button>
			</p>
			<asp:Panel ID="Panel2" runat="server" style="Z-INDEX: 123; LEFT: 8px; POSITION: absolute; TOP: 445px;" Width="200px">
				<asp:checkbox id="cbBusqExacta" runat="server" Height="24px" Width="134px" Text="Búsqueda exacta" TextAlign="Left" ></asp:checkbox>
                <asp:Panel ID="Panel3" runat="server" Width="200px">
					<asp:label id="Label13" Text="Límite:" style="vertical-align:top;" runat="server" Width="42px"/>
					<asp:textbox id="txtLimite" style="margin:2px 0px 1px 38px" Height="20px" Width="100px" BorderStyle="Ridge" runat="server"/>
					<asp:label id="lblLimiteExcedido" style="Z-INDEX: 153; LEFT: 140px;" runat="server" Text="*" Visible="False" ForeColor="Red">*</asp:label>
					</asp:Panel>
				<asp:Panel ID="Panel5" runat="server" Width="200px">
					<asp:label id="Label14" Text="Real:" runat="server" style="vertical-align:top;"/>
					<asp:textbox id="txtReal" runat="server" Height="20px" Width="100px" BorderStyle="Ridge" Enabled="False" style="margin:2px 0px 1px 49px"/>
				</asp:Panel>
				<asp:Panel ID="Panel6" runat="server" Width="200px">
					<asp:label id="Label15" Text="Ordena por:" runat="server" style="vertical-align:top;"/>
					<asp:DropDownList ID="ordenamientoDropDownList" runat="server" Height="30px" Width="100px" style="margin:2px 0px 1px 14px" AutoPostBack="True" />
				</asp:Panel>
				<asp:Panel ID="Panel4" runat="server" Width="200px">
					<asp:button id="buscarButton" style="margin:8px 31px 8px 81px" runat="server" Height="23px" Width="100px" Text="Busca"></asp:button>
				</asp:Panel>
			</asp:Panel>
		</form>
	</body>
</HTML>
