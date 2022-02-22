Public Class Error404
    Inherits System.Web.UI.Page

    Public versionConBaseDatos As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        versionConBaseDatos = VersionNumero + " " + BaseDatos

    End Sub

End Class