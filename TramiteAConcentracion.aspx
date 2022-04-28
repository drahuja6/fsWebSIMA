<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TramiteAConcentracion.aspx.vb" Inherits="fsWebS_SEN.TramiteAConcentracion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trámite a concentración</title>
	<script type="text/javascript">
        function setHourglass() {
            document.body.style.cursor = 'wait';
        }
    </script>
    <link type="text/css" rel="stylesheet" href="Senado.css" />
</head>
<body>
    <form id="form1" runat="server" onsubmit="return setHourglass()">
        <div>
            <table>
			    <tr>
				    <th class="etiqueta-titulo" colspan="8">
					    <asp:Label ID="lblTitulo" runat="server" Text="Traspaso de expedientes de trámite a concentración" />
				    </th>
			    </tr>
                <tr>
                    <td colspan="2">
                        <asp:dropdownlist id="ddlUnidAdm" runat="server" Width="184px" />
                    </td>
                    <td colspan="2">
                        <asp:label id="Label2" runat="server" Text="Fecha de corte (dd/mm/aaaa)" CssClass="etiqueta" />
                    </td>
                    <td>
			            <asp:textbox id="txtFechaDeCorte" runat="server" CssClass="etiqueta-textbox" />
                        <asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" ControlToValidate="txtFechaDeCorte" ErrorMessage="*" ValidationExpression="^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$" />
                    </td>
                    <td class="col">
                        <asp:button id="btnBuscaVencidos" runat="server" Text="(1)Buscar Exp" CssClass="etiqueta-boton" />
                    </td>
                    <td>
                        <asp:button id="btnImpListado" runat="server" Text="(2)Imprimir lista" CssClass="etiqueta-boton" />
                    </td>
                    <td class="col">
                        <asp:button id="btnRevisaExp" runat="server" Text="Revisar Exp" CssClass="etiqueta-boton" />
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        <asp:listbox id="lbExpVencEnTramite" runat="server" Height="168px" Width="100%" SelectionMode="Multiple" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:label id="Label1" runat="server" Text="Lote:" CssClass="etiqueta" />
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
                    <td>
                        <asp:button id="btnNuevoBatch" runat="server" Text="(3) Nuevo Lote" CssClass="etiqueta-boton" />
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:textbox id="txtCajaProv" runat="server" CssClass="etiqueta-textbox" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCajaProv" ErrorMessage="*" />		
                    </td>
                    <td>
                        <asp:button id="btnAsignaCaja" runat="server" Text="(4) Asignar caja prov" CssClass="etiqueta-boton" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:label id="Label3" runat="server" Text="Expedientes listos para su envío a concentración (caja provisional asignada):" CssClass="etiqueta" />
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
			            <asp:listbox id="lbExpConCaja" runat="server" Width="100%" Height="168px" SelectionMode="Multiple" />		
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="col">
                        <asp:label id="Label4" runat="server" Text="Para Lote No." CssClass="etiqueta" />
                    </td>
                    <td>
                        <asp:textbox id="txtNuevoBatchID2"	runat="server" CssClass="etiqueta-textbox" />
                    </td>
                    <td>
                        <asp:button id="btnImprimeEnvio" runat="server" Text="(5)Imprimir envío" CssClass="etiqueta-boton" />
                    </td>
                    <td colspan="3" class="col"></td>
                    <td>
                        <asp:button id="btnQuitar" runat="server" Text="Quitar Exp" CssClass="etiqueta-boton" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
