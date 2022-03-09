Imports System.Collections.Generic

Module Globales
#Region "Variables globales vinculadas a propiedades"
    Public ReadOnly LogoCliente As String = My.Settings.LogoCliente
    Public ReadOnly DirImagenes As String = My.Settings.DirImagenes
    Public ReadOnly DirTemporal As String = My.Settings.DirTemporal
    Public ReadOnly BaseDatos As String = My.Settings.BaseDatos
    Public ReadOnly RegistrosMaximos As Long = My.Settings.RegistrosMaximos
    Public ReadOnly LongitudMaximaArchivoDescarga As Long = My.Settings.LongitudMaximaArchivoDescarga

#End Region

#Region "Variables globales"
    Public ReadOnly VersionNumero As String = "1.0.23.2063"

    Public sesionIniciada As Boolean = False
    Public CadenaConexion As String
    Public ListaIdExpedientes As New List(Of Integer)
    Public OrdenExpedientes As String = " e.Nombre "

#End Region

End Module
