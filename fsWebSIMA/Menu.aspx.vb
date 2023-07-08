Public Class Menu
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As Label
    Protected WithEvents HyperLink1 As HyperLink
    Protected WithEvents Label2 As Label
    Protected WithEvents HyperLink3 As HyperLink
    Protected WithEvents Label3 As Label
    Protected WithEvents HyperLink2 As HyperLink
    Protected WithEvents HyperLink5 As HyperLink
    Protected WithEvents Label4 As Label
    Protected WithEvents HyperLink4 As HyperLink
    Protected WithEvents HyperLink6 As HyperLink
    Protected WithEvents HyperLink7 As HyperLink
    Protected WithEvents HyperLink8 As HyperLink
    Protected WithEvents HLVET As HyperLink
    Protected WithEvents HLVEC As HyperLink
    Protected WithEvents lnkVerificaArchivos As HyperLink
    Protected WithEvents lnkHerramientasPdf As HyperLink
    Protected WithEvents pnlHerramientas As Panel
    Protected WithEvents usuariosMenu As HtmlAnchor
    Protected WithEvents catalogoMenu As HtmlAnchor
    Protected WithEvents expedientesMenu As HtmlAnchor
    Protected WithEvents procesosMenu As HtmlAnchor
    Protected WithEvents expedientesLink As HyperLink
    Protected WithEvents lnkExpedientesGestionRRHH As HyperLink
    Protected WithEvents auditoriaLink As HyperLink

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        'Permiso de acceso para subversiones
        If Globales.Subversion <> String.Empty Then
            Select Case Globales.Subversion
                Case "RRHH"
                    'Grupo de menú catálogo
                    catalogoMenu.Visible = False
                    'Grupo de menú expedientes
                    expedientesMenu.Visible = True
                    expedientesLink.Visible = False             'Expedientes generales
                    lnkExpedientesGestionRRHH.Visible = True    'Expedientes RRHH
                    auditoriaLink.Visible = False               'Auditoría
                    'Grupo de menú procesos
                    procesosMenu.Visible = False
                Case Else
            End Select
        End If
        'Permiso de acceso a herramientas.
        pnlHerramientas.Visible = Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = Globales.SysAdmin Or Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = Globales.SuperUser

        'LlenaEVT(Today())
        'LlenaEVC(Today())

    End Sub

    Sub LlenaEVC(ByVal MiFechaDeCorte As Date)

        'Rutina para encontrar el total de expedientes vencidos en concentracion para una fecha dada

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "TotExpVencEnConc"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'MiFechaDeCorte
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Date)
            param.Value = MiFechaDeCorte

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()
                    HLVEC.Text = "VEC: " & CStr(dr("EVC"))
                End While
            Else
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Sub

    Sub LlenaEVT(ByVal MiFechaDeCorte As Date)

        'Rutina para encontrar el total de expedientes vencidos en tramite para una fecha dada

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "TotExpVencEnTram"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'MiFechaDeCorte
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Date)
            param.Value = MiFechaDeCorte

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()
                    HLVET.Text = "VET: " & CStr(dr("EVT"))
                End While
            Else
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Sub

End Class
