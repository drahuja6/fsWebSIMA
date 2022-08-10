<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Expediente.aspx.vb" Inherits="fsWebS_SEN.Expediente" %>

<!doctype html>

<html>  
<head runat="server">  
    <title></title>  
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="Content/bootstrap.min.css" rel="stylesheet">
    <link href="Scripts/jquery-ui-1.13.2/jquery-ui.css" rel="stylesheet">
</head>  
<body>  
    <form id="form1" runat="server">
        <div class="container ml-1">
            <div class="card mt-2">
                <div class="card-header">
                    <div class="row">
                        <div class="col-4">
                            <label for="codigoTextbox" class="form-text text-sm-left">Código:</label>
                            <div class="input-group">
                                <asp:TextBox ID="codigoTextbox" runat="server" CssClass="form-control text-sm-left"/>
                                <div class="input-group-append">
                                    <asp:Button ID="codigoButton" runat="server" CssClass="btn btn-outline-primary btn-sm" Text="..."></asp:Button>
                                </div>
                            </div>
                        </div>
                        <div class="col-8">
                            <h5>Jerarquía</h5>
                            <asp:Label ID="estatusEdicionLabel" runat="server" Text="(Sólo lectura)" CssClass="text-danger form-text"></asp:Label> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <label for="expedienteTextbox" class="form-text">Expediente:</label>
                            <asp:TextBox ID="expedienteTextbox" runat="server" CssClass="form-control"/>
                        </div>
                        <div class="col-8">
                            <asp:ListBox ID="ListBox1" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-2">
                            <label for="referenciaTextbox" class="form-text">Referencia:</label>
                        </div>
                        <div class="col-10">
                            <asp:TextBox ID="referenciaTextbox" runat="server" CssClass="form-control" ></asp:TextBox>
                        </div>  
                    </div>
                    <div class="row mt-2">
                        <div class="col-2">
                            <label for="tituloTextbox" class="form-text">Título:</label> 
                        </div>
                        <div class="col-10">
                            <asp:TextBox ID="tituloTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>  
                    </div>
                    <div class="row mt-2">
                        <div class="col-2">
                            <label for="asuntoTextbox" class="form-text">Asunto:</label>
                        </div>
                        <div class="col-10">
                            <asp:TextBox ID="asuntoTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <ul class="nav nav-tabs card-header-tabs mt-2">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="pill" href="#tabLocalizacion">Localización</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="pill" href="#tabClasificacion">Clasificación</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="pill" href="#tabAtributos">Atributos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="pill" href="#tabDocumentos">Documentos</a>
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content" style="height:700px; min-height:250px;">
                        <div ID="tabLocalizacion" class="container tab-pane active" >
                            <div class="row mt-2">
                                <div class="col-5">
                                    <h6>Archivo trámite</h6>
                                </div>
                                <div class="col-3">
                                    Movimientos:
                                </div>
                                <div class="col-2">
                                    <asp:Button ID="edicionMovientosButton" runat="server" Text="Edición de movimientos" CssClass="btn btn-outline-primary" />
                                </div>
                            </div>  
                            <div class="row mt-2">  
                                <div class="col-3">
                                    <div class="container pb-2 border rounded border-black-50">
                                        <div>
                                            <label for="cajaTramiteTextbox" class="form-text">Caja:</label>
                                            <asp:TextBox ID="cajaTramiteTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <label for="anaquelTextbox" class="form-text">Anaquel:</label>
                                            <asp:TextBox ID="anaquelTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <label for="ubicacionTextbox" class="form-text">Ubicación:</label>
                                            <asp:TextBox ID="ubicacionTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <label for="TextBox2" class="form-text">Observaciones:</label>
                                            <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>                                    
                                    <div class="mt-4 mb-3">
                                        <h6>Archivo concentración</h6>
                                    </div>
                                    <div class="container pb-2 border rounded border-black-50">
                                        <div>
                                            <label for="cajaConcentracionTextbox" class="form-text">Caja:</label>
                                            <asp:TextBox ID="cajaConcentracionTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>                            
                                        <div>
                                            <label for="anaquelConcentracionTextbox" class="form-text">Anaquel:</label>
                                            <asp:TextBox ID="anaquelConcentracionTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <label for="ubicacionConcentracionTextbox" class="form-text">Ubicacion:</label>
                                            <asp:TextBox ID="ubicacionConcentracionTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div>
                                            <label for="TextBox1" class="form-text">Observaciones:</label>
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>                            
                                <div class="col-2">
                                    <asp:Label ID="labelSinMovimientos" runat="server" Text="No hay movimientos que mostrar" CssClass="form-text text-info"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div id="tabClasificacion" class="container tab-pane" style="height:250px; min-height:250px;">

                        </div>
                        <div id="tabAtributos" class="container tab-pane" style="height:250px; min-height:250px;">

                        </div>
                        <div id="tabDocumentos" class="container tab-pane">

                        </div>
                                </div>
                </div>
                <div class="card-footer mt-2 mb-2">
                    <table style="width: 100%;">
                    <tr>
                        <td class="col-pie1">
                            <asp:Button ID="agregarButton" runat="server" Text="Agregar" />
                        </td>
                        <td class="col-pie1">
                            <asp:Button ID="editarButton" runat="server" Text="Editar" />
                        </td>
                        <td class="col-pie1">
                            <asp:Button ID="borrarButton" runat="server" Text="Borrar" />
                        </td>
                        <td class="col-pie1"></td>
                        <td class="col-pie1">
                            <asp:Button ID="caratulaButton" runat="server" Text="Carátula" />
                        </td>
                        <td class="col-pie1">
                            <asp:Button ID="lomoButton" runat="server" Text="Lomo" />
                        </td>
                    </tr>
                    <tr>
                        <td class="col-pie2">Creación:</td>
                        <td class="col-pie2">
                            <asp:TextBox ID="creacionTextbox" runat="server"></asp:TextBox>
                        </td>
                        <td class="col-pie2">Elaborado por:</td>
                        <td class="col-pie2">
                            <asp:TextBox ID="elaboradoPor" runat="server"></asp:TextBox>
                        </td>
                        <td class="col-pie2">Última edición:</td>
                        <td class="col-pie2">
                            <asp:TextBox ID="ultimaEdicionTextbox" runat="server"></asp:TextBox>
                        </td>
                    </tr>
            </table>
                </div>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
	<script src="Scripts/popper.min.js"></script>
	<script src="Scripts/bootstrap.min.js"></script>
	<script src="Scripts/jquery-ui-1.13.2/jquery-ui.js"></script>
<%--    <script>
        $(document).ready(function() {
            setInterval(function() {
                var docHeight = $(window).height();
                var footerHeight = $('#footer').height();
                var footerTop = $('#footer').position().top + footerHeight;
                var marginTop = (docHeight - footerTop + 10);

                if (footerTop < docHeight)
                    $('#footer').css('margin-top', marginTop + 'px'); // padding of 30 on footer
                else
                    $('#footer').css('margin-top', '0px');
            }, 250);
        });
    </script>--%>
</body>  
</html>  
