Imports fsSimaServicios

Public Class DescargaArchivo
    Inherits Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim archivo As String = Request.QueryString("FN")
        Dim nombreNuevo As String = Request.QueryString("Nombre")

        Title = If(String.IsNullOrEmpty(nombreNuevo), archivo, nombreNuevo)

        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(archivo) Then
                If String.IsNullOrEmpty(nombreNuevo) Then
                    Accesorios.DescargaArchivo(Response, archivo, LongitudMaximaArchivoDescarga)
                Else
                    Accesorios.DescargaArchivo(Response, archivo, LongitudMaximaArchivoDescarga, nombreNuevo, True)
                End If
            End If

        End If
    End Sub

End Class