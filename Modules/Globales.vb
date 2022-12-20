﻿Imports System.Collections.Generic

Module Globales
#Region "Variables globales vinculadas a propiedades"
    Public ReadOnly LogoCliente As String = My.Settings.LogoCliente
    Public ReadOnly DirImagenes As String = My.Settings.DirImagenes
    Public ReadOnly DirTemporal As String = My.Settings.DirTemporal
    Public ReadOnly BaseDatos As String = My.Settings.BaseDatos
    Public ReadOnly RegistrosMaximos As Long = My.Settings.RegistrosMaximos
    Public ReadOnly LongitudMaximaArchivoDescarga As Long = My.Settings.LongitudMaximaArchivoDescarga
    Public ReadOnly ImagenNuevaVentana As Boolean = My.Settings.ImagenNuevaVentana
    Public ReadOnly CodigoAcceso As String = My.Settings.CodigoAcceso
    Public ReadOnly Subversion As String = My.Settings.Subversion

#End Region

#Region "Variables globales"
    Public ReadOnly VersionNumero As String = "1.1.10.2353"
    Public ReadOnly OrdenExpedientes As String = " Nombre "
    Public ReadOnly ConexionAdministrativa As String = "Provider=MSOLEDBSQL;Server=192.168.11.64,1433;UID=SenadoSIMA;Pwd=f5*SENADOsima;Persist Security Info=True;Connect Timeout=15;Database=" & BaseDatos & ";Encryption=True;"
    Public ReadOnly ConexionAdministrativaSql As String = "Server=192.168.11.64,1433;UID=SenadoSIMA;Pwd=f5*SENADOsima;Persist Security Info=True;Connect Timeout=15;Database=" & BaseDatos & ";Encrypt=Yes;TrustServerCertificate=Yes;"
    Public ReadOnly SysAdmin As String = "SENADOSIMA"
    Public ReadOnly SuperUser As String = "SUPERUSER"

#End Region

End Module
