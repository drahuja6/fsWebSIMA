<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TraspasoExpedientesVencidos.aspx.vb" Inherits="fsWebSIMA.TraspasoExpedientesVencidos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Traspaso de expedientes</title>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="Scripts/sima.js"></script>
    <link type="text/css" rel="stylesheet" href="Senado.css" />
</head>
<body>
    <form id="form1" runat="server">
            <div class="loading" align="center">
                Por favor espere<br />
                <br />
                <img src="Images/loader.gif" alt="" />
            </div>
            <table>
			    <tr>
				    <th class="etiqueta-titulo" colspan="12">
					    <asp:Label ID="lblTitulo" runat="server" Text="Traspaso de expedientes" />
				    </th>
			    </tr>
                <tr>
                    <td colspan="2">
                        <asp:dropdownlist id="ddlUnidAdm" runat="server" Width="184px" ToolTip="Seleccione la unidad administrativa" />
                    </td>
                    <td colspan="2">
                        <asp:label id="Label2" runat="server" Text="Fecha de corte (dd/mm/aaaa)" CssClass="etiqueta" />
                    </td>
                    <td>
			            <asp:textbox id="txtFechaDeCorte" runat="server" CssClass="etiqueta-textbox" ToolTip="Fecha para cálculo del vencimiento" />
                        <asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" ControlToValidate="txtFechaDeCorte" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
                    </td>
                    <td>
                        <asp:label id="lblCaja" runat="server" Text="Caja:" CssClass="etiqueta" />
                    </td>
                    <td>
                        <asp:textbox id="txtCaja" runat="server" CssClass="etiqueta-textbox" ToolTip="Número de caja. Dejar vacío para búsqueda general" />
                    </td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnBuscaVencidos" runat="server" Text="(1)Buscar expedientes" CssClass="etiqueta-boton" />
                    </td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnImpListado" runat="server" Text="(2)Imprimir lista" CssClass="etiqueta-boton" />
                    </td>
                    <td>
                        <asp:button id="btnRevisaExp" runat="server" Text="Revisar expediente" CssClass="etiqueta-boton" ToolTip="Ver detalle de un expediente" />
                    </td>
                </tr>
                <tr>
                    <td colspan="12">
                        <asp:listbox id="lbExpedientesVencidos" runat="server" Height="168px" Width="100%" SelectionMode="Multiple" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:label id="lblExpedientesLocalizados" runat="server" Text="Expedientes localizados:" CssClass="etiqueta" />
                    </td>
                    <td>
			            <asp:textbox id="txtExpedientesLocalizados" runat="server" Enabled="False" CssClass="etiqueta-textbox" />
                    </td>
                </tr>
                <tr>
                    <td colspan="12">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:label id="lblLote" runat="server" Text="Lote:" CssClass="etiqueta" />
                    </td>
                    <td>
			            <asp:textbox id="txtNuevoBatchID" runat="server" Enabled="False" CssClass="etiqueta-textbox" />
                    </td>
                    <td>
                        <asp:textbox id="txtFechCorteVig" runat="server" Enabled="False" CssClass="etiqueta-textbox" />
                    </td>
                    <td>
                        <asp:textbox id="txtNuevoBatchDesc" runat="server" CssClass="etiqueta-textbox" />
                    </td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnNuevoBatch" runat="server" Text="(3) Nuevo lote" CssClass="etiqueta-boton" ToolTip="Crear lote para realizar el traspaso" />
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="2">
                        <asp:textbox id="txtCajaProv" runat="server" CssClass="etiqueta-textbox" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCajaProv" ErrorMessage="*" />		
                    </td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnAsignaCaja" runat="server" Text="(4) Asignar caja provisional" CssClass="etiqueta-boton" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:label id="Label3" runat="server" Text="Expedientes listos para envío (caja provisional asignada):" CssClass="etiqueta" />
                    </td>
                </tr>
                <tr>
                    <td colspan="12">
			            <asp:listbox id="lbExpConCaja" runat="server" Width="100%" Height="168px" SelectionMode="Multiple" />		
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:label id="Label4" runat="server" Text="Para lote No." CssClass="etiqueta" />
                    </td>
                    <td>
                        <asp:textbox id="txtNuevoBatchID2"	runat="server" CssClass="etiqueta-textbox" ToolTip="Lote de destino" />
                    </td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnImprimeEnvio" runat="server" Text="(5)Imprimir envío" CssClass="etiqueta-boton" />
                    </td>
                    <td colspan="5"></td>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:button id="btnQuitar" runat="server" Text="Remover expediente" CssClass="etiqueta-boton" ToolTip="Remover expediente de la lista por traspasar" />
                    </td>
                </tr>
            </table>
    </form>
</body>
</html>
