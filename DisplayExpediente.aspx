<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DisplayExpediente.aspx.vb" Inherits="fsWebS_SEN.DisplayExpediente" EnableSessionState="True" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>DisplayExpediente</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#ffffff" style="font:x-small">
		<form id="Form1" method="post" runat="server"  style="font:x-small">
			<asp:label id="lblValidaFechaPaseBajaHistorico" style="Z-INDEX: 151; LEFT: 336px; POSITION: absolute; TOP: 152px"
				runat="server" ForeColor="Red" Visible="False" Text="*">*</asp:label>
			<asp:button id="btnLomo" style="Z-INDEX: 157; LEFT: 464px; POSITION: absolute; TOP: 472px" tabIndex="43"
				runat="server" Text="Lomo" Width="64px"></asp:button>
			<asp:button id="btnCaratula2" style="Z-INDEX: 156; LEFT: 656px; POSITION: absolute; TOP: 472px"
				tabIndex="43" runat="server" Text="Carátula" Width="64px"></asp:button>
			<asp:label id="Label1" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
				Width="56px" Font-Bold="False" Height="16px">Código</asp:label>
			<asp:textbox id="txtCodigo" style="Z-INDEX: 101; LEFT: 64px; POSITION: absolute; TOP: 8px" tabIndex="1"
				runat="server" Text="" Width="112px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>
			<asp:label id="Label2" style="Z-INDEX: 102; LEFT: 248px; POSITION: absolute; TOP: 8px" runat="server"
				Width="136px" Font-Bold="False" Height="16px">Jerarquía superior:</asp:label>
			<asp:label id="Label3" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 32px" runat="server"
				Width="80px" Font-Bold="False" Height="16px">Expediente</asp:label>
			<asp:textbox id="txtExpediente" style="Z-INDEX: 104; LEFT: 88px; POSITION: absolute; TOP: 32px"
				tabIndex="2" runat="server" Text="" Width="128px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>&nbsp;
			<asp:listbox id="lbJerarquia" style="Z-INDEX: 105; LEFT: 248px; POSITION: absolute; TOP: 28px"
				runat="server" Width="456px" Height="60px" Font-Size="XX-Small"></asp:listbox>
			<asp:label id="Label4" style="Z-INDEX: 106; LEFT: 8px; POSITION: absolute; TOP: 56px" runat="server"
				Width="32px" Font-Bold="False" Height="16px">Ref</asp:label>
			<asp:textbox id="txtTipo" style="Z-INDEX: 107; LEFT: 40px; POSITION: absolute; TOP: 56px" tabIndex="3"
				runat="server" Text="" Width="40px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>
			<asp:label id="Label5" style="Z-INDEX: 108; LEFT: 86px; POSITION: absolute; TOP: 56px" runat="server"
				Width="32px" Font-Bold="False" Height="16px" Text="Título"/>
			<asp:textbox id="txtRFC" style="Z-INDEX: 109; LEFT: 136px; POSITION: absolute; TOP: 56px" tabIndex="4"
				runat="server" Text="" Width="96px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>
			<asp:label id="Label6" style="Z-INDEX: 110; LEFT: 8px; POSITION: absolute; TOP: 96px" runat="server"
				Width="56px" Font-Bold="False" Height="16px" Text="Asunto"/>
			<asp:textbox id="txtNombre" style="Z-INDEX: 111; LEFT: 64px; POSITION: absolute; TOP: 88px" tabIndex="6"
				runat="server" Text="" Width="640px" Height="38px" Enabled="False" TextMode="MultiLine" Font-Size="XX-Small"></asp:textbox>
			<asp:label id="Label7" style="Z-INDEX: 112; LEFT: 544px; POSITION: absolute; TOP: 128px" runat="server"
				Width="88px" Font-Bold="False" Height="16px">No. de fojas</asp:label>
			<asp:textbox id="txtNoDeFojas" style="Z-INDEX: 113; LEFT: 632px; POSITION: absolute; TOP: 128px"
				tabIndex="5" runat="server" Text="" Width="56px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>
			<asp:label id="Label8" style="Z-INDEX: 114; LEFT: 8px; POSITION: absolute; TOP: 128px" runat="server"
				Width="160px" Font-Bold="False" Height="16px">Apertura (dd/mm/aaaa)</asp:label>
			<asp:textbox id="txtFechaApertura" style="Z-INDEX: 115; LEFT: 168px; POSITION: absolute; TOP: 128px"
				tabIndex="7" runat="server" Text="" Width="80px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>&nbsp;&nbsp;&nbsp;&nbsp;
			<asp:label id="Label9" style="Z-INDEX: 116; LEFT: 280px; POSITION: absolute; TOP: 128px" runat="server"
				Width="144px" Font-Bold="False" Height="16px">Cierre (dd/mm/aaaa)</asp:label>
			<asp:textbox id="txtFechaCierre" style="Z-INDEX: 117; LEFT: 424px; POSITION: absolute; TOP: 128px"
				tabIndex="8" runat="server" Text="" Width="80px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>&nbsp; 
			&nbsp; &nbsp; &nbsp;
			<asp:label id="Label10" style="Z-INDEX: 118; LEFT: 8px; POSITION: absolute; TOP: 152px" runat="server"
				Visible="False" Text="Pase a Baja/Histórico (dd/mm/aaaa)" Width="240px" Font-Bold="False">Pase a Baja/Histórico (dd/mm/aaaa)</asp:label>
			<asp:label id="Label11" style="Z-INDEX: 119; LEFT: 360px; POSITION: absolute; TOP: 152px" runat="server"
				Visible="False" Text="Autoriza" Width="64px" Font-Bold="False">Autoriza</asp:label>
			<asp:label id="lblAutorizaPaseBajaHistorico" style="Z-INDEX: 120; LEFT: 424px; POSITION: absolute; TOP: 152px"
				runat="server" Visible="False" Text="" Width="184px"></asp:label>
			<asp:textbox id="txtFechaPaseBajaHistorico" style="Z-INDEX: 121; LEFT: 256px; POSITION: absolute; TOP: 152px"
				tabIndex="9" runat="server" Visible="False" Text="" Width="80px" Height="20px" Enabled="False"></asp:textbox>&nbsp;
			<asp:dropdownlist id="lbxUnidadAdmin" style="Z-INDEX: 122; LEFT: 168px; POSITION: absolute; TOP: 176px"
				tabIndex="10" runat="server" Width="184px" Enabled="False" Font-Size="XX-Small"></asp:dropdownlist>
			<asp:label id="Label12" style="Z-INDEX: 123; LEFT: 8px; POSITION: absolute; TOP: 176px" runat="server"
				Text="Unidad Administrativa" Width="152px" Font-Bold="False"></asp:label>
			<asp:label id="Label13" style="Z-INDEX: 124; LEFT: 360px; POSITION: absolute; TOP: 176px" runat="server"
				Text="Calidad Documental" Width="152px" Font-Bold="False"></asp:label>
			<asp:dropdownlist id="lbxCalidadDoc" style="Z-INDEX: 125; LEFT: 520px; POSITION: absolute; TOP: 176px"
				tabIndex="11" runat="server" Width="184px" Enabled="False" Font-Size="XX-Small"></asp:dropdownlist>
			<asp:button id="btnLocalizacion" style="Z-INDEX: 126; LEFT: 8px; POSITION: absolute; TOP: 200px"
				tabIndex="44" runat="server" Text="Localización" BackColor="PaleTurquoise"></asp:button>
			<asp:button id="btnClasificacion" style="Z-INDEX: 127; LEFT: 120px; POSITION: absolute; TOP: 200px"
				tabIndex="45" runat="server" Text="Clasificación" BackColor="#FFE0C0"></asp:button>
			<asp:button id="btnAtributos" style="Z-INDEX: 128; LEFT: 232px; POSITION: absolute; TOP: 200px;"
				tabIndex="46" runat="server" Text="Atributos" BackColor="#C0FFC0"></asp:button>
			<asp:button id="btnVerDocumentos" style="Z-INDEX: 152; LEFT: 312px; POSITION: absolute; TOP: 200px"
				tabIndex="47" runat="server" Text="Ver documentos" BackColor="#C0C0FF"></asp:button>	
			<asp:label id="Label23" style="Z-INDEX: 130; LEFT: 16px; POSITION: absolute; TOP: 440px" runat="server"
				Width="160px" Font-Bold="False" Height="16px">Creación (dd/mm/aaaa)</asp:label>
			<asp:textbox id="txtFechaDeCreacion" style="Z-INDEX: 131; LEFT: 176px; POSITION: absolute; TOP: 440px"
				tabIndex="39" runat="server" Text="" Width="80px" Height="20px" Enabled="False" Font-Size="XX-Small"></asp:textbox>&nbsp;
			<asp:label id="Label24" style="Z-INDEX: 132; LEFT: 280px; POSITION: absolute; TOP: 440px" runat="server"
				Width="72px" Font-Bold="False" Height="16px">Elaborado</asp:label>&nbsp;
			<asp:label id="Label25" style="Z-INDEX: 133; LEFT: 488px; POSITION: absolute; TOP: 440px" runat="server"
				Width="96px" Font-Bold="False" Height="16px">Ultima edición</asp:label>&nbsp;
			<asp:button id="btnGestion" style="Z-INDEX: 134; LEFT: 648px; POSITION: absolute; TOP: 268px"
				tabIndex="37" runat="server" Text="Gestión" Width="72px" Enabled="True"></asp:button>
			<asp:button id="btnSalvar" style="Z-INDEX: 134; LEFT: 648px; POSITION: absolute; TOP: 368px"
				tabIndex="37" runat="server" Text="Salvar" Width="72px" Enabled="False"></asp:button>
			<asp:button id="btnCancelar" style="Z-INDEX: 135; LEFT: 648px; POSITION: absolute; TOP: 400px"
				tabIndex="38" runat="server" Text="Cancelar" Width="72px" Enabled="False"></asp:button>&nbsp;
			<asp:button id="btnAgregar" style="Z-INDEX: 136; LEFT: 152px; POSITION: absolute; TOP: 472px"
				tabIndex="40" runat="server" Text="Agregar" Width="72px"></asp:button>
			<asp:button id="btnEditar" style="Z-INDEX: 137; LEFT: 232px; POSITION: absolute; TOP: 472px"
				tabIndex="41" runat="server" Text="Editar" Width="72px"></asp:button>
			<asp:button id="btnBorrar" style="Z-INDEX: 139; LEFT: 312px; POSITION: absolute; TOP: 472px"
				tabIndex="42" runat="server" Text="Borrar" Width="72px"></asp:button>
			&nbsp;
			<asp:label id="lblElaborPor" style="Z-INDEX: 140; LEFT: 352px; POSITION: absolute; TOP: 448px"
				runat="server" Width="128px" BorderStyle="None" Font-Size="XX-Small"></asp:label>&nbsp;
			<asp:label id="lblUltimaedicion" style="Z-INDEX: 141; LEFT: 592px; POSITION: absolute; TOP: 448px"
				tabIndex="143" runat="server" Text="" Width="128px" Font-Size="XX-Small"></asp:label>
			<asp:label id="lblExpedienteStatus" style="Z-INDEX: 142; LEFT: 536px; POSITION: absolute; TOP: 8px"
				runat="server" ForeColor="Red" Text="(SÓLO LECTURA)" Width="160px" Font-Bold="False" Height="16px"></asp:label>&nbsp; 
			&nbsp; &nbsp;&nbsp;
			<asp:label id="lblValidaCodigo" style="Z-INDEX: 143; LEFT: 176px; POSITION: absolute; TOP: 8px"
				runat="server" ForeColor="Red" Visible="False" Text="*" Font-Bold="False"></asp:label>
			<asp:label id="lblValidaExpediente" style="Z-INDEX: 144; LEFT: 224px; POSITION: absolute; TOP: 32px"
				runat="server" ForeColor="Red" Visible="False" Text="*" Font-Bold="False"></asp:label>
			<asp:label id="lblValidaFechaApertura" style="Z-INDEX: 145; LEFT: 256px; POSITION: absolute; TOP: 128px"
				runat="server" ForeColor="Red" Visible="False" Text="*"></asp:label>
			<asp:label id="lblValidaFechaCreacion" style="Z-INDEX: 146; LEFT: 264px; POSITION: absolute; TOP: 440px"
				runat="server" ForeColor="Red" Visible="False" Text="*"></asp:label>
			<asp:label id="lblValidacionNoDeFojas" style="Z-INDEX: 147; LEFT: 696px; POSITION: absolute; TOP: 128px"
				runat="server" ForeColor="Red" Visible="False" Text="*"></asp:label>
			<asp:label id="lblValidaNombre" style="Z-INDEX: 148; LEFT: 712px; POSITION: absolute; TOP: 104px"
				runat="server" ForeColor="Red" Visible="False" Text="*"></asp:label>
			<asp:label id="lblValidaFechaCierre" style="Z-INDEX: 149; LEFT: 512px; POSITION: absolute; TOP: 128px"
				runat="server" ForeColor="Red" Visible="False" Text="*"></asp:label>
			<asp:panel id="PLocalizacion" style="Z-INDEX: 129; LEFT: 8px; POSITION: absolute; TOP: 224px"
				runat="server" Width="632px" Height="216px" BorderStyle="None" Font-Size="Small">
				<asp:Button id="Button2" style="Z-INDEX: 158; LEFT: 300px; POSITION: absolute; TOP: 5px" tabIndex="20"
					runat="server" Text="Ventana de edición de Movimientos" Enabled="False"></asp:Button>
				<asp:Label id="Label44" style="Z-INDEX: 159; LEFT: 8px; POSITION: absolute; TOP: 0px" runat="server"
					Width="128px" BackColor="PaleTurquoise" Height="12px" Font-Bold="False" Font-Size="XX-Small">Archivo Trámite</asp:Label>
				<asp:Label id="Label14" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 23px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Caja No.</asp:Label>
				<asp:Label id="Label15" style="Z-INDEX: 105; LEFT: 8px; POSITION: absolute; TOP: 47px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Anaquel</asp:Label>
				<asp:Label id="Label16" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 71px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Ubicación </asp:Label>
				<asp:Label id="Label17" style="Z-INDEX: 109; LEFT: 8px; POSITION: absolute; TOP: 95px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Observaciones</asp:Label>
				<HR style="Z-INDEX: 143; LEFT: 8px; WIDTH: 22%; POSITION: absolute; TOP: 108px; HEIGHT: 1px" SIZE="1">
				<asp:Label id="Label18" style="Z-INDEX: 112; LEFT: 8px; POSITION: absolute; TOP: 115px" runat="server"
					Width="144px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Archivo Concentración</asp:Label>
				<asp:Label id="Label19" style="Z-INDEX: 116; LEFT: 8px; POSITION: absolute; TOP: 154px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Anaquel</asp:Label>
				<asp:Label id="Label20" style="Z-INDEX: 120; LEFT: 8px; POSITION: absolute; TOP: 135px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Caja No.</asp:Label>
				<asp:Label id="Label21" style="Z-INDEX: 123; LEFT: 8px; POSITION: absolute; TOP: 172px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Ubicación</asp:Label>
				<asp:Label id="Label45" style="Z-INDEX: 159; LEFT: 8px; POSITION: absolute; TOP: 192px" runat="server"
					Width="64px" Height="16px" Font-Bold="False" Font-Size="XX-Small">Observaciones</asp:Label>
				<asp:TextBox id="txtObservConcentracion" style="Z-INDEX: 159; LEFT: 72px; POSITION: absolute; TOP: 192px"
					tabIndex="18" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtCaja" style="Z-INDEX: 124; LEFT: 72px; POSITION: absolute; TOP: 20px" tabIndex="12"
					runat="server" Text="" Width="81px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtAnaquel" style="Z-INDEX: 127; LEFT: 72px; POSITION: absolute; TOP: 42px"
					tabIndex="13" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtPasillo" style="Z-INDEX: 132; LEFT: 72px; POSITION: absolute; TOP: 66px"
					tabIndex="14" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtEntrepano" style="Z-INDEX: 133; LEFT: 72px; POSITION: absolute; TOP: 90px"
					tabIndex="15" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtRelacionAnterior" style="Z-INDEX: 136; LEFT: 72px; POSITION: absolute; TOP: 154px"
					tabIndex="16" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtCajaAnterior" style="Z-INDEX: 137; LEFT: 72px; POSITION: absolute; TOP: 130px"
					tabIndex="17" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtItemAnterior" style="Z-INDEX: 139; LEFT: 72px; POSITION: absolute; TOP: 172px"
					tabIndex="18" runat="server" Text="" Width="80px" Height="15px" Font-Size="XX-Small" Enabled="False"></asp:TextBox>
				<asp:Panel id="Panel1" style="Z-INDEX: 141; LEFT: 160px; OVERFLOW: auto; POSITION: absolute; TOP: 32px"
					runat="server" Width="464px" Height="168px" BorderStyle="Ridge">
					<asp:DataGrid id="DataGrid1" tabIndex="19" runat="server" Width="184px" Height="138px" BorderStyle="Ridge"
						BorderWidth="1px" BorderColor="Black" PageSize="4" AutoGenerateColumns="False">
						<AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
						<HeaderStyle Font-Underline="True" Font-Bold="False"></HeaderStyle>
						<Columns>
							<asp:ButtonColumn Text="Ir a" ButtonType="PushButton" CommandName="Select"></asp:ButtonColumn>
							<asp:BoundColumn Visible="False" DataField="idMovimientos" HeaderText="idMovimientos"></asp:BoundColumn>
							<asp:BoundColumn DataField="Fecha" HeaderText="Fecha"></asp:BoundColumn>
							<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n">
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
						</Columns>
						<PagerStyle Mode="NumericPages"></PagerStyle>
					</asp:DataGrid>
					<asp:Label id="NoHayDatos" runat="server" Visible="False" Font-Bold="False">No hay datos que mostrar</asp:Label>
				</asp:Panel>
				<asp:Label id="Label22" style="Z-INDEX: 144; LEFT: 160px; POSITION: absolute; TOP: 8px" runat="server"
					Width="104px" Height="16px" Font-Bold="False">Movimientos</asp:Label>
			</asp:panel>
			<asp:panel id="PClasificacion" style="Z-INDEX: 153; LEFT: 8px; POSITION: absolute; TOP: 224px"
				runat="server" Visible="False" Width="632px" BackColor="#FFE0C0" Height="216px" BorderStyle="None" Font-Size="Small">
				<asp:DropDownList id="ddlstStatus" style="Z-INDEX: 100; LEFT: 56px; POSITION: absolute; TOP: 8px"
									tabIndex="21" runat="server" Width="112px" Enabled="False"></asp:DropDownList>
				<asp:Label id="Label26" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
									Width="48px" Height="16px" Font-Bold="False">Status</asp:Label>
				<asp:CheckBox id="chkbxParteDelDocumento" style="Z-INDEX: 108; LEFT: 8px; POSITION: absolute; TOP: 32px"
									tabIndex="22" runat="server" Text="Parte del documento" Font-Bold="False" Enabled="False"
									Checked="False"></asp:CheckBox>
				<asp:Label id="Label27" style="Z-INDEX: 113; LEFT: 176px; POSITION: absolute; TOP: 32px" runat="server"
									Width="40px" Height="16px" Font-Bold="False">Fojas</asp:Label>
				<asp:TextBox id="txtFojas" style="Z-INDEX: 117; LEFT: 216px; POSITION: absolute; TOP: 32px" tabIndex="23"
									runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>
				<asp:Label id="Label28" style="Z-INDEX: 120; LEFT: 8px; POSITION: absolute; TOP: 56px" runat="server"
									Width="208px" Height="16px" Font-Bold="False">Clasificación (dd/mm/aaaa)</asp:Label>
				<asp:TextBox id="txtFechaDeClasificacion" style="Z-INDEX: 124; LEFT: 216px; POSITION: absolute; TOP: 56px"
									tabIndex="24" runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>&nbsp; 
				<asp:Label id="Label29" style="Z-INDEX: 127; LEFT: 8px; POSITION: absolute; TOP: 80px" runat="server"
									Width="208px" Height="16px" Font-Bold="False">Prop. Desclasif. (dd/mm/aaaa)</asp:Label>
				<asp:TextBox id="txtFechaPropuestaDesclasificacion" style="Z-INDEX: 133; LEFT: 216px; POSITION: absolute; TOP: 80px"
									tabIndex="25" runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>&nbsp; 
				<asp:Label id="Label30" style="Z-INDEX: 136; LEFT: 8px; POSITION: absolute; TOP: 112px" runat="server"
									Width="264px" Height="16px" Font-Bold="False">Fundamentos legales de la clasificación</asp:Label>&nbsp; 
				<asp:ListBox id="lbFundamentosLegalesClasificacion" style="Z-INDEX: 141; LEFT: 8px; POSITION: absolute; TOP: 136px"
									tabIndex="26" runat="server" Width="264px" Enabled="False" SelectionMode="Multiple"></asp:ListBox>
				<asp:Label id="Label31" style="Z-INDEX: 144; LEFT: 320px; POSITION: absolute; TOP: 8px" runat="server"
									Width="248px" Height="16px" Font-Bold="False">Ampliación del plazo de clasificación</asp:Label>
				<asp:Label id="Label32" style="Z-INDEX: 150; LEFT: 320px; POSITION: absolute; TOP: 32px" runat="server"
									Width="208px" Height="16px" Font-Bold="False">Nueva desclasif. (dd/mm/aaaa)</asp:Label>&nbsp; 
				<asp:Label id="Label33" style="Z-INDEX: 153; LEFT: 488px; POSITION: absolute; TOP: 56px" runat="server"
									Width="40px" Height="16px" Font-Bold="False">Fojas</asp:Label>
				<asp:TextBox id="txtNuevaFojas" style="Z-INDEX: 155; LEFT: 528px; POSITION: absolute; TOP: 56px"
									tabIndex="29" runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>
				<asp:TextBox id="txtNuevaFechaPropuestaDesclasificacion" style="Z-INDEX: 159; LEFT: 528px; POSITION: absolute; TOP: 32px"
									tabIndex="27" runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>&nbsp; 
				<asp:Label id="Label34" style="Z-INDEX: 161; LEFT: 320px; POSITION: absolute; TOP: 80px" runat="server"
									Width="64px" Height="16px" Font-Bold="False">Autoriza</asp:Label>&nbsp; 
				<asp:Label id="Label35" style="Z-INDEX: 163; LEFT: 320px; POSITION: absolute; TOP: 144px" runat="server"
									Width="208px" Height="16px" Font-Bold="False">Fecha Desclasif. (dd/mm/aaaa)</asp:Label>
				<asp:TextBox id="txtFechaDesclasificacion" style="Z-INDEX: 166; LEFT: 528px; POSITION: absolute; TOP: 144px"
									tabIndex="30" runat="server" Text="" Width="80px" Height="20px" Enabled="False"></asp:TextBox>
				<asp:Label id="Label36" style="Z-INDEX: 168; LEFT: 320px; POSITION: absolute; TOP: 168px" runat="server"
									Width="64px" Height="16px" Font-Bold="False">Autoriza</asp:Label>&nbsp; 
				&nbsp; 
				<asp:Label id="lblAutorizaNuevaDesc" style="Z-INDEX: 170; LEFT: 384px; POSITION: absolute; TOP: 80px"
									runat="server" Text="" Width="232px"></asp:Label>
				<asp:Label id="lblAutorizaDesclasificacion" style="Z-INDEX: 171; LEFT: 384px; POSITION: absolute; TOP: 168px"
									runat="server" Text="" Width="232px"></asp:Label>
				<asp:CheckBox id="chkbxNuevaParteDelDocumento" style="Z-INDEX: 173; LEFT: 320px; POSITION: absolute; TOP: 56px"
									tabIndex="28" runat="server" Text="Parte del documento" Font-Bold="False" Enabled="False"
									Checked="False"></asp:CheckBox>
				<asp:Label id="lblValidaFechaClasificacion" style="Z-INDEX: 176; LEFT: 304px; POSITION: absolute; TOP: 56px"
									runat="server" Text="*" Visible="False" ForeColor="Red"></asp:Label>
				<asp:Label id="lblValidaFechaPropuestaDesclasificacion" style="Z-INDEX: 177; LEFT: 304px; POSITION: absolute; TOP: 80px"
									runat="server" Text="*" Visible="False" ForeColor="Red"></asp:Label>
				<asp:Label id="lblValidaFechaNuevaDesclasificacion" style="Z-INDEX: 179; LEFT: 616px; POSITION: absolute; TOP: 32px"
									runat="server" Text="*" Visible="False" ForeColor="Red"></asp:Label>
				<asp:Label id="lblValidaFechaDesclasificacion" style="Z-INDEX: 180; LEFT: 616px; POSITION: absolute; TOP: 144px"
						runat="server" Text="*" Visible="False" ForeColor="Red"></asp:Label>
			</asp:panel>
			<asp:panel id="PAtributos" style="Z-INDEX: 154; LEFT: 8px; POSITION: absolute; TOP: 224px"
				runat="server" Visible="False" Width="632px" Height="216px" BorderStyle="None" Font-Size="Small">
				<asp:Label id="Label37" style="Z-INDEX: 100; LEFT: 8px; POSITION: absolute; TOP: 8px" runat="server"
					Width="120px" Height="16px" Font-Bold="False">Valor documental</asp:Label>
				<asp:ListBox id="lbxValorDocumental" style="Z-INDEX: 103; LEFT: 8px; POSITION: absolute; TOP: 32px"
					tabIndex="31" runat="server" Width="128px" Enabled="False" SelectionMode="Multiple"></asp:ListBox>
				<asp:Label id="Label38" style="Z-INDEX: 107; LEFT: 144px; POSITION: absolute; TOP: 8px" runat="server"
					Width="168px" Height="16px" Font-Bold="False">Plazos de conservación</asp:Label>
				<asp:Label id="Label39" style="Z-INDEX: 113; LEFT: 144px; POSITION: absolute; TOP: 40px" runat="server"
					Width="56px" Height="16px" Font-Bold="False">Trámite</asp:Label>
				<asp:Label id="Label40" style="Z-INDEX: 118; LEFT: 144px; POSITION: absolute; TOP: 64px" runat="server"
					Width="104px" Height="16px" Font-Bold="False">Concentración</asp:Label>
				<asp:DropDownList id="ddlstTramite" style="Z-INDEX: 122; LEFT: 248px; POSITION: absolute; TOP: 40px"
					tabIndex="32" runat="server" Width="112px" Enabled="False"></asp:DropDownList>
				<asp:DropDownList id="ddlstConcentracion" style="Z-INDEX: 124; LEFT: 248px; POSITION: absolute; TOP: 64px"
					tabIndex="33" runat="server" Width="112px" Enabled="False"></asp:DropDownList>
				<asp:Label id="Label41" style="Z-INDEX: 129; LEFT: 376px; POSITION: absolute; TOP: 8px" runat="server"
					Width="96px" Height="16px" Font-Bold="False">Destino final</asp:Label>
				<asp:Label id="Label42" style="Z-INDEX: 132; LEFT: 376px; POSITION: absolute; TOP: 32px" runat="server"
					Width="48px" Height="16px" Font-Bold="False">Status</asp:Label>
				<asp:DropDownList id="ddlstDestinoFinal" style="Z-INDEX: 137; LEFT: 432px; POSITION: absolute; TOP: 32px"
					tabIndex="34" runat="server" Width="112px" Enabled="False"></asp:DropDownList>
				<asp:Label id="Label43" style="Z-INDEX: 139; LEFT: 376px; POSITION: absolute; TOP: 64px" runat="server"
					Width="248px" Height="16px" Font-Bold="False">Fundamentos legales de destino final</asp:Label>
				<asp:ListBox id="lbxFundamentosLegalesDestinoFinal" style="Z-INDEX: 145; LEFT: 376px; POSITION: absolute; TOP: 88px"
					tabIndex="35" runat="server" Width="248px" Enabled="False" SelectionMode="Multiple"></asp:ListBox>
			</asp:panel>
			<asp:panel id="PPDFs" style="Z-INDEX: 155; LEFT: 8px; OVERFLOW: auto; POSITION: absolute; TOP: 224px"
				runat="server" Visible="False" Width="632px" Height="216px" Font-Size="Small">
				<P>
					<asp:DataGrid id="DataGrid2" tabIndex="36" runat="server" Visible="False" AutoGenerateColumns="False">
						<AlternatingItemStyle Wrap="False"></AlternatingItemStyle>
						<ItemStyle Wrap="False"></ItemStyle>
						<Columns>
							<asp:ButtonColumn Text="Ir a" ButtonType="PushButton" CommandName="Select">
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:ButtonColumn>
							<asp:BoundColumn Visible="False" DataField="idExpediente" HeaderText="idExpediente">
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn Visible="False" DataField="NombrePDF" HeaderText="Nombre Fichero">
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
							<asp:BoundColumn DataField="Descripcion" HeaderText="Descripci&#243;n">
								<ItemStyle Wrap="False"></ItemStyle>
							</asp:BoundColumn>
						</Columns>
					</asp:DataGrid></P>
				<P>
					<asp:Label id="NoHayDatos2" runat="server" Visible="False" Width="192px" Font-Bold="False">No hay datos que mostrar</asp:Label>
				</P>
				<P>&nbsp;</P>
			</asp:panel>
			<asp:button id="btnAbreEscogeCuadro" style="Z-INDEX: 158; LEFT: 192px; POSITION: absolute; TOP: 4px"
				runat="server" Text="..." Width="24px" Height="24px" Enabled="False"></asp:button>
		</form>
	</body>
</HTML>
