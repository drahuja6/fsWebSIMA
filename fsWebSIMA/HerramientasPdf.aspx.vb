Imports fsSimaServicios

Public Class HerramientasPdf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub BtnActualizatitulo_Click(sender As Object, e As EventArgs) Handles btnActualizatitulo.Click
        VariosPdf.CambiaTitulo("D:\Temp\PdfSIMA\Senado\DGAHML\00001\DGAHML_0001_2800.PDF")
    End Sub

    Protected Sub BtnContarPaginas_Click(sender As Object, e As EventArgs) Handles btnContarPaginas.Click
        txtPaginas.Text = VariosPdf.CuentaPaginas("D:\Temp\PdfSIMA\Senado\DGAHML\00001\DGAHML_0001_2800.PDF")
    End Sub
End Class