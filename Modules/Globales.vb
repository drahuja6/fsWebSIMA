Module Globales
    Public ReadOnly LogoCliente As String = My.Settings.LogoCliente
    Public ReadOnly DirImagenes As String = My.Settings.DirImagenes
    Public ReadOnly DirTemporal As String = My.Settings.DirTemporal
    Public ReadOnly BaseDatos As String = My.Settings.BaseDatos
    Public ReadOnly VersionNumero As String = "1.0.15.2044"

    Public CadenaConexion As String

    Public ListaIdExpedientes As New Generic.List(Of Integer)
    Public OrdenExpedientes As String


    Public Function FechaLatinaAGringa(FechaLatina As String) As String
        Return FechaLatina

        'Dim MyDia As String
        'Dim MyMes As String
        'Dim MyAnno As String

        'Dim PosSlash1 As Integer
        'Dim PosSlash2 As Integer

        'PosSlash1 = InStr(FechaLatina, "/")
        'PosSlash2 = InStr(PosSlash1 + 1, FechaLatina, "/")
        'MyMes = Mid(FechaLatina, PosSlash1 + 1, PosSlash2 - PosSlash1 - 1)
        'MyDia = Mid(FechaLatina, 1, PosSlash1 - 1)
        'MyAnno = Mid(FechaLatina, PosSlash2 + 1)
        'FechaLatinaAGringa = CDate(MyMes & "/" & MyDia & "/" & MyAnno)

    End Function
End Module
