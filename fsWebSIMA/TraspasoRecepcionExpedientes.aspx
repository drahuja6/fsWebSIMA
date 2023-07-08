<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TraspasoRecepcionExpedientes.aspx.vb" Inherits="fsWebSIMA.TraspasoRecepcionExpedientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Recepción de expedientes</title>
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
				<th class="etiqueta-titulo" colspan="8">
					<asp:Label ID="lblTitulo" runat="server" Text="Recepción de expedientes" />
				</th>
			</tr>
            <tr>
                <td colspan="2">
                    <asp:dropdownlist id="ddlUnidAdm" runat="server" Width="184px" ToolTip="Seleccione la unidad administrativa" />
                </td>
                <td colspan="2">
                    <asp:button id="btnBuscaLotes" CssClass="etiqueta-boton" runat="server" Text="(1)Buscar lotes" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:label id="Label2" runat="server" Text="Lotes por atender:" />
                </td>
                <td colspan="2">
                    <asp:dropdownlist id="ddlBatches" runat="server" AutoPostBack="True" ToolTip="Lotes disponibles para esa unidad administrativa" />
                </td>
                <td></td>
                <td onclick="ShowProgress()">
                    <asp:button id="btnTraerLote" runat="server" CssClass="etiqueta-boton" Text="(2)Traer lote" ToolTip="Cargar detalle de expedientes en el lote" />
                </td>
                <td>
                    <asp:button id="btnRevisaExp" runat="server" CssClass="etiqueta-boton" Text="Revisar expediente" ToolTip="Ver detalles de un expediente" />
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
                    <asp:textbox id="txtCaja" runat="server" CssClass="etiqueta-textbox" ToolTip="Escriba el número de caja que será asignado al expediente transferido" />
                    <asp:label id="lblValidaCaja" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                </td>
                <td onclick="ShowProgress()">
                    <asp:button id="btnAsignaCaja" runat="server" CssClass="etiqueta-boton" Text="(3)Asignar caja" />
                </td>
            </tr>
            <tr>
                <td colspan="7">
                    <asp:listbox id="lbExpConCaja" runat="server" Width="100%" Height="176px" SelectionMode="Multiple" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="col" onclick="ShowProgress()">
                    <asp:button id="btnImprimeResguardo" runat="server" CssClass="etiqueta-boton" Text="(4)Imprimir resguardo" ToolTip="Imprimir resguardo" />
                    <asp:label id="lblValidaLoteAtendido" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                </td>
                <td colspan="2" class="col" onclick="ShowProgress()">
                    <asp:button id="btnFinalizarLote" runat="server" CssClass="etiqueta-boton" Text="(5)Finalizar lote" ToolTip="Finalizar el lote" />
                    <asp:label id="lblValidaLoteAtendidoEImpreso" runat="server" CssClass="etiqueta error" Text="*" Visible="False" />
                </td>
                <td colspan="2"></td>
                <td onclick="ShowProgress()"> 
                    <asp:button id="btnQuitar" runat="server" CssClass="etiqueta-boton" Text="Remover expediente" ToolTip="Remover expediente de la lista de traspaso" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
