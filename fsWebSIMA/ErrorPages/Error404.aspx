<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Error404.aspx.vb" Inherits="fsWebSIMA.Error404" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>SIMA</h1>
            <h2>La página solicitada no existe.</h2>
            <br />
            <br />
            <h4>Si ha intentado cargar una imagen, es probable que ésta no esté registrada correctamente.</h4>
            <br />
            <h4>Si considera que se trata de un error de la aplicación, por favor notifique al área de soporte. Versión: <%=versionConBaseDatos %></h4>
        </div>
    </form>
</body>
</html>
