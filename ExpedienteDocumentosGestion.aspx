﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExpedienteDocumentosGestion.aspx.vb" Inherits="fsWebS_SEN.ExpedienteDocumentosGestion" %>
<!doctype html>
<html>
	<head>
		<title>ExpedienteDocumentosGestion</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link href="Content/bootstrap.min.css" rel="stylesheet">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</head>
<body>
    <form id="Form1" runat="server">
        <div class="container-fluid" margin-left: 20px; margin-top: 10px;">
          <div class="row align-items-center">
              <div class="col">
                  <h4><asp:TextBox ID="txtGestion" runat="server" ReadOnly="true" CssClass="form-text border-0"></asp:TextBox></h4>
              </div>
          </div>
          <div class="row"></div>
          <div class="row">
            <div class="col mt-3">
                <h6>Documentos disponibles para vincular</h6>
                <asp:GridView ID="dgvDocsDisponibles" runat="server" AutoGenerateColumns="False" CssClass="table table-borderless table-striped table-responsive-md table-hover border-0">
                    <SelectedRowStyle Font-Bold="True" />
                    <Columns>
                        <asp:BoundField Visible="False" DataField="IdExpedientePdfRelaciones" HeaderText="IdExpedientePdfRelaciones" />
                        <asp:CommandField SelectText="&gt;" ShowSelectButton="True" />
                        <asp:BoundField Visible="True" DataField="Descripcion" HeaderText="Descripción" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="col align-self-center">
                <asp:Button ID="btnAsigna" runat="server" Text="Asigna" Enabled="false" CssClass="btn btn-primary" />
                <asp:Button ID="btnDesasigna" runat="server" Text="Desasigna" Enabled="false" CssClass="btn btn-primary" />
            </div>
            <div class="col mt-3">
                <h6>Detalle de documentos en la gestión</h6>
                <asp:GridView ID="dgvDocsAsignados" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Size="Small" AutoGenerateColumns="False" ViewStateMode="Disabled">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    <Columns>
                        <asp:BoundField Visible="False" DataField="IdGestionDocumentosInstancia" HeaderText="IdGestionDocumentosInstancia" />
                        <asp:BoundField Visible="False" DataField="IdGestionDocumentos" HeaderText="IdGestionDocumentos" />
                        <asp:BoundField Visible="False" DataField="IdExpedientePdfRelaciones" HeaderText="IdExpedientePdfRelaciones" />
                        <asp:BoundField Visible="False" DataField="Gestion" HeaderText="Gestión" />
                        <asp:CommandField SelectText="&gt;" ShowSelectButton="True" />
                        <asp:BoundField Visible="True" DataField="Seccion" HeaderText="Sección" />
                        <asp:BoundField Visible="True" DataField="CodigoDocumento" HeaderText="Código documento" />
                        <asp:BoundField Visible="True" DataField="Descripcion" HeaderText="Descripción" />
                        <asp:CheckBoxField Visible="True" DataField="Obligatorio" HeaderText="Obligatorio" ItemStyle-HorizontalAlign="Center" >
                        <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:BoundField Visible="True" DataField="FechaDocumento" HeaderText="Fecha" />
                        <asp:BoundField Visible="True" DataField="CampoAdicional1" HeaderText="CampoAdicional 1" />
                        <asp:BoundField Visible="True" DataField="CampoAdicional2" HeaderText="CampoAdicional 2" />
                        <asp:BoundField Visible="True" DataField="CampoAdicional3" HeaderText="CampoAdicional 3" />
                        <asp:BoundField Visible="True" DataField="Observaciones" HeaderText="Observaciones" />
                        <asp:BoundField Visible="True" DataField="NombreArchivo" HeaderText="Imagen" />
                        <asp:TemplateField HeaderText="...">
                            <ItemTemplate>
                                <asp:Button ID="btnDescargaImagen" CommandName="DescargaImagen" CommandArgument="<%# Container.DisplayIndex %>" runat="server" Text="..." />
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
</body>
</html>
