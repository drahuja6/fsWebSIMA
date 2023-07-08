Imports System.ComponentModel
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient

Imports fsSimaServicios

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class FsSimaWebService
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function AsignarDocumento(asignacion As AsignacionDocumento) As Boolean
        Dim sqlCliente As New ClienteSQL(Globales.ConexionAdministrativaSql)
        Dim params(1) As SqlParameter

        params(0) = New SqlParameter("@IdGestionDocumentosInstancia", asignacion.idGestionDocumentosInstancia)
        params(1) = New SqlParameter("@IdExpedientePdfRelaciones", asignacion.idExpedientePdfRelaciones)

        Return sqlCliente.EjecutaProcedimientoSql(params, "Gestion_AsignaDocumento")
    End Function

    Public Class AsignacionDocumento
        Public idGestionDocumentosInstancia As Integer
        Public idExpedientePdfRelaciones As Integer
    End Class

End Class