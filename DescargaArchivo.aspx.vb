Imports System.IO

Imports fsSimaServicios

Public Class DescargaArchivo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim queryString As String = Request.QueryString("FN")

        Me.Title = queryString

        If Not Me.IsPostBack Then
            Dim archivo As String = Path.Combine(DirImagenes, queryString)
            Accesorios.DescargaArchivo(Response, archivo, LongitudMaximaArchivoDescarga)
        End If
    End Sub

End Class