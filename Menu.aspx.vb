Public Class Menu
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents HyperLink1 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents HyperLink3 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents HyperLink2 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HyperLink5 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents HyperLink4 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HyperLink6 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HyperLink7 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HyperLink8 As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HLVET As System.Web.UI.WebControls.HyperLink
    Protected WithEvents HLVEC As System.Web.UI.WebControls.HyperLink

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página
        LlenaEVT(Today())
        LlenaEVC(Today())

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
