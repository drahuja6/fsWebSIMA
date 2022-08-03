<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExpedienteDocumentosGestion.aspx.vb" Inherits="fsWebS_SEN.ExpedienteDocumentosGestion" %>
<!doctype html>
<html>
	<head>
		<title>ExpedienteDocumentosGestion</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
        <link href="Scripts/jquery-ui-1.13.2/jquery-ui.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <style>
            .id {
                width:1%;
            }
        </style>
	</head>
    <body>
        <form id="Form1" runat="server">
            <div class="container-fluid" margin-left: 20px; margin-top: 10px;">
              <div class="row">
                  <div class="col-12">
                      <h4><asp:Label ID="lblGestion" runat="server" /></h4>
                  </div>
              </div>
              <div class="row">
                  <div class="col-4">                     
                      <h6><asp:Label ID="lblAsunto" runat="server" /></h6>
                      <h6><asp:Label ID="lblTitulo" runat="server" /></h6>
                  </div>
                  <div class="col-3">
                      <h6><asp:Label ID="lblObservaciones" runat="server" /></h6>
                      <h6><asp:Label ID="lblCampoAdicional2" runat="server" /></h6>
                  </div>
                  <div class="col-2">
                      <asp:HyperLink ID="lnkExpedientes" runat="server" CssClass="btn btn-secondary btn-sm" NavigateUrl="./DisplayExpediente.aspx" ToolTip="Ver el expediente actual como expediente general">Ir a expediente general...</asp:HyperLink>
                  </div>
              </div>
              <div class="row"></div>
              <div class="row">
                <div class="col-12 mt-3">
                    <h6>Documentos disponibles para vincular</h6>
                    <asp:GridView ID="dgvDocsDisponibles" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless table-striped table-responsive-md table-hover border-0 drag_drop_grid" ViewStateMode="Disabled">
                        <SelectedRowStyle Font-Bold="True" />
                        <AlternatingRowStyle Font-Size="small" />
                        <RowStyle Font-Size="small" />
                        <Columns>
                            <asp:BoundField DataField="IdExpedientePdfRelaciones" HeaderStyle-CssClass="invisible id" ItemStyle-CssClass="invisible id" />
                            <asp:CommandField SelectText=">" ShowSelectButton="True" ItemStyle-CssClass="btn btn-link btn-lg" />
                            <asp:BoundField Visible="True" DataField="Descripcion" HeaderText="Descripción" />
                            <asp:TemplateField HeaderText="Imagen" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Button ID="btnDescargaImagenDisponible" CommandName="DescargaImagen" CommandArgument="<%# Container.DisplayIndex %>" runat="server" Text="..." ToolTip='<%# Bind("NombreArchivo") %>' CssClass="btn btn-outline-success btn-sm" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="col-12 align-self-center">
                    <asp:Button ID="btnAsigna" runat="server" Text="Asigna" Enabled="false" CssClass="btn btn-primary" />
                    <asp:Button ID="btnDesasigna" runat="server" Text="Desasigna" Enabled="false" CssClass="btn btn-primary" />
                </div>
                <div class="col-12 mt-3">
                    <h6>Detalle de documentos en la gestión</h6>
                    <asp:GridView ID="dgvDocsAsignados" runat="server" AutoGenerateColumns="False" ViewStateMode="Disabled" CssClass="table table-borderless table-striped table-responsive-sm table-hover border-0 drag_drop_grid">
                        <SelectedRowStyle Font-Bold="True" />
                        <AlternatingRowStyle Font-Size="small" />
                        <RowStyle Font-Size="small" />
                        <Columns>
                            <asp:BoundField DataField="idGestionDocumentosInstancia" HeaderStyle-CssClass="invisible id" ItemStyle-CssClass="invisible id" />
                            <asp:CommandField SelectText=">" ShowSelectButton="True" ItemStyle-CssClass="btn btn-link btn-lg" />
                            <asp:TemplateField HeaderText="Sección" SortExpression="Seccion">
                                <HeaderTemplate>
                                    Sección
                                    <asp:DropDownList runat="server" ID="ddlSeccion" AutoPostBack="true" DataTextField="Seccion" DataSource='<%# ListaSecciones %>' DataValueField="Id" OnSelectedIndexChanged="FiltrarSeccion_IndexChanged" OnPreRender="FiltrarSeccion_PreRender" />
                                </HeaderTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Seccion") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Seccion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField Visible="True" DataField="CodigoDocumento" HeaderText="Código documento" />
                            <asp:BoundField Visible="True" DataField="Descripcion" HeaderText="Descripción" />
                            <asp:CheckBoxField Visible="True" DataField="Obligatorio" HeaderText="Obligatorio" ItemStyle-HorizontalAlign="Center" >
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:CheckBoxField>                            
                            <asp:TemplateField HeaderText="Imagen" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Button ID="btnDescargaImagen" CommandName="DescargaImagen" CommandArgument="<%# Container.DisplayIndex %>" runat="server" Text="..." ToolTip='<%# Bind("NombreArchivo") %>' Enabled='<%# Bind("ArchivoAsignado") %>' CssClass="btn btn-outline-success btn-sm" />
                                </ItemTemplate>
                            </asp:TemplateField>
                         </Columns>
                    </asp:GridView>
                </div>
            </div>
           </div>
        </form>
	    <script src="Scripts/jquery-3.6.0.min.js"></script>
	    <script src="Scripts/popper.min.js"></script>
	    <script src="Scripts/bootstrap.min.js"></script>
        <script src="Scripts/jquery-ui-1.13.2/jquery-ui.js"></script>
        <script type="text/javascript">
            $(function () {
                var asignacion = {};
                var procesado = false;
                $(".drag_drop_grid").sortable({
                    items: 'tr:not(tr:first-child)',
                    cursor: 'crosshair',
                    connectWith: '.drag_drop_grid',
                    axis: 'y',
                    dropOnEmpty: true,
                    start: function (e, ui) {
                        asignacion.idExpedientePdfRelaciones = ui.item.find("td:nth-child(1)").html();
                    },
                    update: function (e, ui) {
                        var pos = "tr:nth-child(" + ui.item.index() + ")";
                        asignacion.idGestionDocumentosInstancia = $("[id*=dgvDocsAsignados] " + pos).find("td:nth-child(1)").html();
                        if (!procesado) {
                            $.ajax({
                                type: "POST",
                                url: "FsSimaWebService.asmx/AsignarDocumento",
                                data: '{asignacion: ' + JSON.stringify(asignacion) + '}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: location.reload()
                            });
                            procesado = true;
                        }
                    }
                });
                /*$("[id*=gvDest] tr:not(tr:first-child)").remove();*/
            });
        </script>
    </body>
</html>
