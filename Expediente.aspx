<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Expediente.aspx.vb" Inherits="fsWebS_SEN.Expediente" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
    <title></title>  
    <style type="text/css">  
        .col1 {  
            width: 218px;  
        }  
        .col2 {  
            width: 224px;  
        }  
        .col3 {  
            width: 50px;  
        }  
        .col4 {  
            width: 408px;  
        }  
        .col5 {  
            width: 218px;  
        }
        .col-pie1 .col-pie2 {
            width: 100px;
        }
        .col-pie2 {
            font-size: x-small;
        }
    </style>  
</head>  
<body>  
    <form id="form1" runat="server">  
        <div>  
            <asp:Panel ID="PanelEncabezado" runat="server">
                <table style="width: 100%;">
                    <tr>  
                        <td class="col1"><strong>Código:</strong></td>
                        <td class="col2">  
                            <asp:TextBox ID="codigoTextbox" runat="server"/>
                        </td>
                        <td class="col3">
                            <asp:Button ID="codigoButton" runat="server" Width="50px" Text="..."></asp:Button>
                        </td>
                        <td class="col4">Jerarquía</td>
                        <th class="col5">
                            <asp:Label ID="estatusEdicionLabel" runat="server" Text="(Sólo lectura)" ForeColor="Red"></asp:Label>
                        </th>
                    </tr>  
                    <tr>  
                        <td class="col1">Expediente:</td>  
                        <td class="col2" colspan="2">  
                            <asp:TextBox ID="expedienteTextbox" runat="server" Width="230px"/>
                        </td>
                        <td class="col4" colspan="2" rowspan="3"/>
                        <asp:ListBox ID="ListBox1" runat="server" Width="500px"></asp:ListBox>
                    </tr>  
                    <tr>  
                        <td class="col1">Título:</td>  
                        <td class="col2" colspan="2">  
                            <asp:TextBox ID="tituloTextbox" runat="server" Width="230px"></asp:TextBox>
                        </td>  
                    </tr>  
                    <tr>  
                        <td class="col1">Referencia:</td>
                        <td class="col2" colspan="2">  
                            <asp:TextBox ID="referenciaTextbox" runat="server" Width="230px"></asp:TextBox>
                        </td>  
                    </tr>
                    <tr>
                        <td class="col1">Asunto:</td>
                        <td class="col2" colspan="4" rowspan="2">
                            <asp:TextBox ID="asuntoTextbox" runat="server" Width="750px" Height="32px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="col1"></td>
                    </tr>
                    </table>  
            </asp:Panel>
            <asp:MultiView ID="expedienteMultiView" runat="server">  
                <asp:View ID="localizacionView" runat="server">
                    <table style="width: 100%;">
                        <tr>
                            <th class="col1" colspan="5">Localización</th>
                        </tr>
                        <tr>  
                            <th class="col1" colspan="2">Archivo trámite</th>
                            <td class="col3">Movimientos:</td>
                            <td class="col4">
                                <asp:Button ID="edicionMovientosButton" runat="server" Text="Edición de movimientos" />
                            </td>
                            <td></td>
                        </tr>  
                        <tr>  
                            <td class="col1">Caja:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="cajaTramiteTextbox" runat="server"></asp:TextBox>
                            </td>
                            <td class="col3" colspan="3" rowspan="9">
                                <asp:Label ID="labelSinMovimientos" runat="server" Text="No hay movimientos que mostrar"></asp:Label>
                            </td>  
                        </tr>  
                        <tr>  
                            <td class="col1">Anaquel:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="anaquelTextbox" runat="server"></asp:TextBox>
                            </td> 
                        </tr>  
                        <tr>  
                            <td class="col1">Ubicación:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="ubicacionTextbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">Observaciones:</td> 
                            <td class="col2">  
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th class="col1" colspan="2">Archivo concentración</th>
                        </tr>
                        <tr>
                            <td class="col1">Caja:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="cajaConcentracionTextbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">Anaquel:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="anaquelConcentracionTextbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">Ubicacion:</td>  
                            <td class="col2">  
                                <asp:TextBox ID="ubicacionConcentracionTextbox" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col1">Observaciones:</td> 
                            <td class="col2">  
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>  
  
                </asp:View>  
                <asp:View ID="View2" runat="server">  
                    <table style="width: 100%;">  
                        <tr>  
                            <td class="auto-style3"><strong>Student Course Detail</strong></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style3">Student Course</td>  
                            <td>  
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style3">Student Branch</td>  
                            <td>  
                                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style3">  
                                <asp:Button ID="Button3" runat="server" Text="Previous" OnClick="Button3_Click" />  
                            </td>  
                            <td>  
                                <asp:Button ID="Button4" runat="server" Text="Next" OnClick="Button4_Click" />  
                            </td>  
                        </tr>  
                    </table>  
  
  
                </asp:View>  
                <asp:View ID="View3" runat="server">  
  
                    <table style="width: 100%;">  
                        <tr>  
                            <td class="auto-style2"><strong>Student Personal Detail</strong></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style2">Student EmailId</td>  
                            <td>  
                                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style2">Student City</td>  
                            <td>  
                                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style2">Student State</td>  
                            <td>  
                                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>  
  
                        </tr>  
                        <tr>  
                            <td class="auto-style2">  
                                <asp:Button ID="Button5" runat="server" Text="Previous" OnClick="Button5_Click" />  
                            </td>  
                            <td>  
                                <asp:Button ID="Button6" runat="server" Text="Next" OnClick="Button6_Click" style="height: 26px" />  
                            </td>  
                        </tr>  
                    </table>  
  
                </asp:View>  
                <asp:View ID="View4" runat="server">  
  
                    <table class="auto-style1">  
                        <tr>  
                            <td><strong>Student Details</strong></td>  
  
                            <td> </td>  
  
                        </tr>  
                        <tr>  
                            <td>Student FirstName:</td>  
                            <td>  
                                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>  
                            </td>  
                            <td> </td>  
  
                        </tr>  
                        <tr>  
                            <td>Student LastName:</td>  
  
                            <td>  
                                <asp:Label ID="Label2" runat="server" Text=""></asp:Label>  
                            </td>  
  
                        </tr>  
  
                        <tr>  
                            <td></td>  
                            <td> </td>  
                        </tr>  
                        <tr>  
                            <td><strong>Student Course Details</strong></td>  
                            <td> </td>  
                        </tr>  
  
                        <tr>  
                            <td>Student Course:</td>  
                            <td>  
                                <asp:Label ID="Label3" runat="server" Text=""></asp:Label>  
                            </td>  
                        </tr>  
                        <tr>  
                            <td>Student Branch:</td>  
                            <td>  
                                <asp:Label ID="Label4" runat="server" Text=""></asp:Label>  
                            </td>  
                        </tr>  
  
                        <tr>  
                            <td> </td>  
                            <td> </td>  
                        </tr>  
                        <tr>  
                            <td><strong>Student Personal Details</strong></td>  
                            <td> </td>  
                        </tr>  
                        <tr>  
                            <td>Student EmailId:</td>  
                            <td>  
                                <asp:Label ID="Label5" runat="server" Text=""></asp:Label>  
                            </td>  
                        </tr>  
                        <tr>  
                            <td>Student City:</td>  
                            <td>  
                                <asp:Label ID="Label6" runat="server" Text=""></asp:Label>  
                            </td>  
                        </tr>  
                        <tr>  
                            <td>Student State:</td>  
                            <td>  
                                <asp:Label ID="Label7" runat="server" Text=""></asp:Label>  
                            </td>  
                        </tr>  
  
                    </table>  
                </asp:View>  
            </asp:MultiView>  
            <asp:Panel ID="panelPie" runat="server">
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
            </asp:Panel>
        </div>  
    </form>  
</body>  
</html>  
