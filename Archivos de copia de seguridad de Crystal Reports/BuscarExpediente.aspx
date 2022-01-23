<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BuscarExpediente.aspx.vb" Inherits="fsWebS_SEN.BuscarExpediente" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>BuscarExpediente</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ffffff" style="font-size:small">
		<form id="Form1" method="post" runat="server">
			<asp:listbox id="lbUnidAdmin" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px" tabIndex="1"
				runat="server" Height="64px" Width="200px" SelectionMode="Multiple"></asp:listbox>
			<asp:label id="Label17" style="Z-INDEX: 160; LEFT: 8px; POSITION: absolute; TOP: 416px" runat="server"
				Height="16px" Width="48px">ObsTr:</asp:label>
			<asp:textbox id="txtObsTr" style="Z-INDEX: 159; LEFT: 64px; POSITION: absolute; TOP: 416px" runat="server"
				Height="20px" Width="48px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label16" style="Z-INDEX: 158; LEFT: 8px; POSITION: absolute; TOP: 368px" runat="server"
				Height="16px" Width="48px">AnaqTr:</asp:label>
			<asp:textbox id="txtAnaqTr" style="Z-INDEX: 157; LEFT: 64px; POSITION: absolute; TOP: 368px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge"></asp:textbox>
			<asp:textbox id="txtUbicTr" style="Z-INDEX: 156; LEFT: 64px; POSITION: absolute; TOP: 392px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label15" style="Z-INDEX: 155; LEFT: 8px; POSITION: absolute; TOP: 392px" runat="server"
				Height="16px" Width="48px">UbicTr:</asp:label><asp:label id="lblLimiteExcedido" style="Z-INDEX: 153; LEFT: 128px; POSITION: absolute; TOP: 456px"
				runat="server" Text="*" Visible="False" ForeColor="Red">*</asp:label>
			<asp:textbox id="txtReal" style="Z-INDEX: 152; LEFT: 64px; POSITION: absolute; TOP: 480px" runat="server"
				Height="20px" Width="64px" BorderStyle="Ridge" Enabled="False"></asp:textbox>
			<asp:textbox id="txtLimite" style="Z-INDEX: 151; LEFT: 64px; POSITION: absolute; TOP: 456px"
				runat="server" Height="20px" Width="64px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label14" style="Z-INDEX: 150; LEFT: 8px; POSITION: absolute; TOP: 480px" runat="server"
				Height="16px" Width="40px">Real:</asp:label>
			<asp:label id="Label13" style="Z-INDEX: 149; LEFT: 8px; POSITION: absolute; TOP: 456px" runat="server"
				Height="16px" Width="40px">Límite:</asp:label>
			<asp:button id="btnExpedientesDadosDeBaja" style="Z-INDEX: 146; LEFT: 728px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="32px" Text="Baja" Enabled="False"></asp:button>
			<asp:button id="btnEnArchivoHistorico" style="Z-INDEX: 145; LEFT: 648px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="72px" Text="Arch. Hist." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVencidosConcentracion" style="Z-INDEX: 144; LEFT: 560px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="82px" Text="Venc. Conc." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVigentesConcentracion" style="Z-INDEX: 143; LEFT: 488px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="66px" Text="Vig. Conc." Enabled="False"></asp:button>
			<asp:button id="btnEnTraspasoAConcentracion" style="Z-INDEX: 142; LEFT: 384px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="96px" Text="Trasp. a Conc." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnVencidosTramite" style="Z-INDEX: 141; LEFT: 296px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="80px" Text="Venc. Trám." Visible="False" Enabled="False"></asp:button>
			<asp:button id="btnExpedientesActivos" style="Z-INDEX: 140; LEFT: 224px; POSITION: absolute; TOP: 448px"
				runat="server" Height="23px" Width="64px" Text="Vig. Trám." Enabled="False"></asp:button>
			<asp:button id="btnLomos" style="Z-INDEX: 139; LEFT: 656px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="64px" Text="Lomos" Enabled="False"></asp:button>
			<asp:button id="btnEtiquetas" style="Z-INDEX: 138; LEFT: 584px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="64px" Text="Etiquetas" Enabled="False"></asp:button>
			<asp:button id="btnCaratulasNoCredito" style="Z-INDEX: 137; LEFT: 512px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="64px" Text="Carátulas" Enabled="False"></asp:button>
			<asp:button id="btnImprimeCaratulas" style="Z-INDEX: 136; LEFT: 384px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="120px" Text="Carátulas (Barras)" Enabled="False" Visible="False"></asp:button>
			<asp:button id="btnImprimeListadoDeExpedientes" style="Z-INDEX: 135; LEFT: 304px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="72px" Text="Imp. Lista" Enabled="False"></asp:button>
			<asp:button id="btnImprimeGuiaDeExpedientes" style="Z-INDEX: 134; LEFT: 224px; POSITION: absolute; TOP: 480px"
				runat="server" Height="23px" Width="72px" Text="Imp. Guía" Enabled="False"></asp:button>
			<asp:textbox id="txtRelAnt" style="Z-INDEX: 133; LEFT: 64px; POSITION: absolute; TOP: 344px"
				runat="server" Height="20px" Width="48px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label1" style="Z-INDEX: 132; LEFT: 8px; POSITION: absolute; TOP: 344px" runat="server"
				Height="16px" Width="48px">CajaTr:</asp:label>
			<asp:label id="lblCodigo" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 74px" runat="server"
				Height="24px" Width="56px" Text="Código"></asp:label>
			<asp:textbox id="txtCodigo" style="Z-INDEX: 102; LEFT: 72px; POSITION: absolute; TOP: 74px" tabIndex="2"
				runat="server" Height="20px" Width="136px"></asp:textbox>
			<hr style="Z-INDEX: 126; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 88px; HEIGHT: 1px"
				color="#000000" SIZE="1">
			<asp:label id="Label2" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 96px" runat="server"
				Height="16px" Width="208px">Fecha de apertura (dd/mm/aaaa):</asp:label>
			<asp:label id="Label4" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 120px" runat="server"
				Height="16px" Width="40px">Inicial</asp:label>
			<asp:textbox id="txtFApertInic" style="Z-INDEX: 105; LEFT: 48px; POSITION: absolute; TOP: 120px"
				tabIndex="3" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>&nbsp;
			<asp:textbox id="txtFApertFinal" style="Z-INDEX: 106; LEFT: 48px; POSITION: absolute; TOP: 144px"
				tabIndex="4" runat="server" Height="20px" Width="160px" BorderStyle="Ridge" MaxLength="10"></asp:textbox>
			<asp:label id="Label3" style="Z-INDEX: 107; LEFT: 8px; POSITION: absolute; TOP: 144px" runat="server"
				Height="16px" Width="40px">Final</asp:label>
			<hr style="Z-INDEX: 127; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 160px; HEIGHT: 1px"
				color="#000000" SIZE="1">
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
			<hr style="Z-INDEX: 128; LEFT: 8px; WIDTH: 10%; POSITION: absolute; TOP: 264px; HEIGHT: 1px"
				color="#000000" SIZE="1">
			<asp:label id="Label9" style="Z-INDEX: 115; LEFT: 8px; POSITION: absolute; TOP: 272px" runat="server"
				Height="16px" Width="40px">Ref:</asp:label>
			<asp:textbox id="txtTipo" style="Z-INDEX: 116; LEFT: 64px; POSITION: absolute; TOP: 272px" runat="server"
				Height="20px" Width="144px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label10" style="Z-INDEX: 117; LEFT: 8px; POSITION: absolute; TOP: 296px" runat="server"
				Height="16px" Width="40px">RFC:</asp:label>
			<asp:textbox id="txtRFC" style="Z-INDEX: 118; LEFT: 64px; POSITION: absolute; TOP: 296px" runat="server"
				Height="20px" Width="144px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label11" style="Z-INDEX: 119; LEFT: 8px; POSITION: absolute; TOP: 320px" runat="server"
				Height="16px" Width="40px">Nombre:</asp:label><asp:textbox id="txtNombre" style="Z-INDEX: 120; LEFT: 64px; POSITION: absolute; TOP: 320px"
				runat="server" Height="20px" Width="145px" BorderStyle="Ridge"></asp:textbox>
			<asp:label id="Label12" style="Z-INDEX: 121; LEFT: 120px; POSITION: absolute; TOP: 344px" runat="server"
				Height="16px" Width="40px">CajaC:</asp:label>
			<asp:textbox id="txtCaja" style="Z-INDEX: 122; LEFT: 168px; POSITION: absolute; TOP: 344px" runat="server"
				Height="20px" Width="42px" BorderStyle="Ridge"></asp:textbox>
			<asp:checkbox id="cbBusqExacta" style="Z-INDEX: 123; LEFT: 8px; POSITION: absolute; TOP: 432px"
				runat="server" Height="24px" Width="128px" Text="Búsqueda exacta"></asp:checkbox>
			<asp:button id="Button1" style="Z-INDEX: 124; LEFT: 136px; POSITION: absolute; TOP: 480px" runat="server"
				Height="23px" Width="72px" Text="Busca"></asp:button>
			<asp:regularexpressionvalidator id="RegularExpressionValidator1" style="Z-INDEX: 125; LEFT: 208px; POSITION: absolute; TOP: 120px"
				runat="server" ControlToValidate="txtFApertInic" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
			<asp:regularexpressionvalidator id="RegularExpressionValidator2" style="Z-INDEX: 129; LEFT: 208px; POSITION: absolute; TOP: 144px"
				runat="server" ControlToValidate="txtFApertFinal" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$"></asp:regularexpressionvalidator>
			<asp:panel id="Panel1" style="Z-INDEX: 130; LEFT: 216px; OVERFLOW: auto; POSITION: absolute; TOP: 8px"
				runat="server" Height="424px" Width="664px" BorderStyle="Ridge">
				<asp:datagrid id="DataGrid1" runat="server" Width="598px" Height="176px" BorderStyle="Ridge" BorderColor="Black"
					BorderWidth="1px" AllowSorting="True" AutoGenerateColumns="False">
					<AlternatingItemStyle Wrap="False" BackColor="#E0E0E0"></AlternatingItemStyle>
					<ItemStyle Wrap="False"></ItemStyle>
					<HeaderStyle Font-Underline="True" Font-Bold="True"></HeaderStyle>
					<Columns>
						<asp:ButtonColumn Text="Ir a" ButtonType="PushButton" CommandName="Select">
							<HeaderStyle Width="8%"></HeaderStyle>
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
						</asp:ButtonColumn>
						<asp:BoundColumn DataField="Codigo" SortExpression="Codigo" HeaderText="C&#243;digo">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn Visible="False" DataField="idExpediente" HeaderText="idExpediente">
							<HeaderStyle Width="1%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Expediente" SortExpression="Expediente" HeaderText="Expediente">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Tipo" SortExpression="Tipo" HeaderText="Ref">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="RFC" SortExpression="RFC" HeaderText="RFC">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="Asunto" SortExpression="Nombre" HeaderText="Nombre">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="CajaT" SortExpression="CajaT" HeaderText="Caja Tram."></asp:BoundColumn>
						<asp:BoundColumn DataField="Caja" SortExpression="Caja" HeaderText="Caja Conc.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="F.Apertura" SortExpression="FechaApertura" HeaderText="Apertura">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="F.Cierre" SortExpression="FechaCierre" HeaderText="Cierre"></asp:BoundColumn>
						<asp:BoundColumn DataField="NombreCorto" SortExpression="UnidAdmin" HeaderText="Unid. Adm.">
							<HeaderStyle Width="20%"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
						</asp:BoundColumn>
					</Columns>
				</asp:datagrid>
				<asp:Label id="NoHayDatos" runat="server" Visible="False" Font-Bold="True">No hay datos que mostrar</asp:Label>
			</asp:panel>
			<asp:button id="Button2" style="Z-INDEX: 131; LEFT: 728px; POSITION: absolute; TOP: 480px" runat="server"
				Height="23px" Width="152px" Text="Ver ventana de edición" ToolTip="Permite ver directamente la ventana de edición de expedientes, en caso de que no necesite hacer una búsqueda (por ejemplo, si quiere comenzar a añadir directamente)"></asp:button>
			<asp:radiobutton id="RadioButtonPDF" style="Z-INDEX: 147; LEFT: 768px; POSITION: absolute; TOP: 448px"
				runat="server" Width="48px" Text=".pdf" Enabled="False" Checked="True" GroupName="Formato"></asp:radiobutton>
			<asp:radiobutton id="RadioButtonXLS" style="Z-INDEX: 148; LEFT: 824px; POSITION: absolute; TOP: 448px"
				runat="server" Text=".xls" Enabled="False" GroupName="Formato"></asp:radiobutton>
		</form>
	</body>
</HTML>
