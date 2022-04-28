<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RecepcionEnConcentracion.aspx.vb" Inherits="fsWebS_SEN.RecepcionEnConcentracion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recepción en concentración</title>
	<script type="text/javascript">
        function setHourglass() {
            document.body.style.cursor = 'wait';
        }
    </script>
    <link type="text/css" rel="stylesheet" href="Senado.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
			    <tr>
				    <th class="etiqueta-titulo" colspan="8">
					    <asp:Label ID="lblTitulo" runat="server" Text="Recepción de expedientes en concentración" />
				    </th>
			    </tr>
                <tr>
                    <td colspan="2">
                        <asp:dropdownlist id="ddlUnidAdm" runat="server" Width="184px" />
                    </td>
                    <td colspan="2">
                        <asp:button id="btnBuscaLotes" CssClass="etiqueta-boton" runat="server" Text="(1)Buscar Lotes" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:label id="Label2" runat="server" Text="Lotes por atender:" />
                    </td>
                    <td colspan="2">
                        <asp:dropdownlist id="ddlBatches" runat="server" AutoPostBack="True" />
                    </td>
                    <td></td>
                    <td>
                        <asp:button id="btnTraerLote" runat="server" CssClass="etiqueta-boton" Text="(2)Traer Lote" />
                    </td>
                    <td>
                        <asp:button id="btnRevisaExp" runat="server" CssClass="etiqueta-boton" Text="Revisar Exp" />
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:listbox id="lbExpDelLote" runat="server" Width="100%" Height="176px" SelectionMode="Multiple" />
                    </td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                    <td>
                        <asp:textbox id="txtCajaConc" runat="server" CssClass="etiqueta-textbox" />
                        <asp:label id="lblValidaCajaConc" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                    </td>
                    <td>
                        <asp:button id="btnAsignaCajaConc" runat="server" CssClass="etiqueta-boton" Text="(3)Asignar caja Conc" />
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <asp:listbox id="lbExpConCajaConc" runat="server" Width="100%" Height="176px" SelectionMode="Multiple" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="col">
                        <asp:button id="btnImprimeResguardo" runat="server" CssClass="etiqueta-boton" Text="(4)Imprimir Resg." ToolTip="Imprimir resguardo" />
                        <asp:label id="lblValidaLoteAtendido" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                    </td>
                    <td colspan="2" class="col">
                        <asp:button id="btnFinalizarLote" runat="server" CssClass="etiqueta-boton" Text="(5)Finalizar lote" ToolTip="Finalizar el lote" />
                        <asp:label id="lblValidaLoteAtendidoEImpreso" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                    </td>
                    <td colspan="2"></td>
                    <td>
                        <asp:button id="btnQuitar" runat="server" CssClass="etiqueta-boton" Text="Quitar Exp" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
