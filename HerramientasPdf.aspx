<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HerramientasPdf.aspx.vb" Inherits="fsWebS_SEN.HerramientasPdf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Herramientas para archivos PDF</title>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="Scripts/sima.js"></script>
    <link type="text/css" rel="stylesheet" href="Senado.css" />
    <style>
        .tabla {
            min-width: 500px;
            max-width: 30%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
            <div class="loading" align="center">
                Por favor espere<br />
                <br />
                <img src="Images/loader.gif" alt="" />
            </div>
        	<table class="tabla">
				<tr>
					<th class="etiqueta-titulo" colspan="4">
						<asp:Label ID="lblTitulo" runat="server" Text="Herramientas para manejo de archivos PDF" />
					</th>
				</tr>
                <tr>
                    <td colspan="2" onclick="ShowProgress()">
                        <asp:Button ID="btnActualizatitulo" runat="server" Text="Actualizar título" />
                    </td>
                    <td>
                        <asp:Label ID="lblCaja" runat="server" Text="Caja:" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtCaja" runat="server" />
                    </td>
                </tr>
            </table>
    </form>
</body>
</html>
