Imports System.Linq

Imports fsSimaServicios

Public Class DescargaArchivo
    Inherits Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not IsPostBack Then
            Dim qs As Specialized.NameValueCollection = Request.QueryString
            Dim archivo As String
            Dim nombre As String
            Dim eliminar As Boolean

            If qs.Count > 0 Then
                archivo = If(qs.AllKeys.Contains("FN"), qs("FN").ToString, "")
                nombre = If(qs.AllKeys.Contains("Nombre"), qs("Nombre").ToString, "")
                eliminar = If(qs.AllKeys.Contains("Eliminar"), CBool(qs("Eliminar")), False)

                If Not String.IsNullOrEmpty(archivo) Then
                    If String.IsNullOrEmpty(nombre) Then
                        Title = archivo
                        Accesorios.DescargaArchivo(Response, archivo, LongitudMaximaArchivoDescarga)
                    Else
                        Title = nombre
                        Accesorios.DescargaArchivo(Response, archivo, LongitudMaximaArchivoDescarga, nombre, eliminar)
                    End If
                End If

            End If
        End If

    End Sub


End Class