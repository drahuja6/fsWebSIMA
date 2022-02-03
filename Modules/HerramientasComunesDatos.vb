Imports System.Data.SqlClient
Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging


Imports BarcodeLib

Module HerramientasComunesDatos

    Public Sub EjecutaComando(Comando As String, Parametros As SqlParameter(), CadenaConexion As String)
        Dim cmd As New SqlCommand
        Dim cn As New SqlConnection With {
            .ConnectionString = CadenaConexion
        }
        Try
            cn.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = cn
            cmd.Parameters.AddRange(Parametros)
            cmd.CommandText = Comando

            cmd.ExecuteNonQuery()

        Catch ex As Exception

        End Try
    End Sub

    Public Sub CargaListBox(MyListBox As ListBox, ConnString As String, StoredProcedure As String, idParameter As Integer, MyDataTextField As String, MyDataValueField As String)
        'Rutina para llenar un combobox
        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try
            'MyListBox.Items.Clear()

            'Abro la conexión
            cn.ConnectionString = ConnString

            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = StoredProcedure
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            param = cmd.Parameters.Add("idParameter", Data.OleDb.OleDbType.Integer)
            param.Value = idParameter

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

            'Lleno los campos que ligan el DataReader con el ListBox
            MyListBox.DataSource = dr
            MyListBox.DataTextField = MyDataTextField
            MyListBox.DataValueField = MyDataValueField

            'Hago efectivo el enlace
            MyListBox.DataBind()

            'Cierro el DataReader y la colección de parámetros
            '(la conexión se cerró automáticamente luego de que se llenó
            'el dr, gracias al parámetro CommandBehavior.CloseConnection)
            dr.Close()
            cmd.Parameters.Clear()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)

        End Try

    End Sub

    Public Function GetBarCode39(CodeNumber As String, Length As Integer, Height As Integer, FontSize As Integer) As Byte()
        Dim barcode As New Barcode
        Dim ms As New MemoryStream

        barcode.IncludeLabel = True
        barcode.Alignment = AlignmentPositions.CENTER
        barcode.LabelFont = New Font(FontFamily.GenericMonospace, FontSize * Barcode.DotsPerPointAt96Dpi, FontStyle.Bold, GraphicsUnit.Pixel)
        barcode.AspectRatio = 3.0

        Dim barcodeImage As Image
        barcodeImage = barcode.Encode(TYPE.CODE39, CodeNumber, Color.Black, Color.White, Height, Length)
        barcodeImage.Save(ms, ImageFormat.Png)

        Dim reader As New BinaryReader(ms)
        Dim bytes As Byte() = reader.ReadBytes(ms.Length)

        reader.Dispose()
        ms.Dispose()
        'Dim unico As New Guid
        'Dim archivo As String = DirTemporal & unico.ToString & ".png"

        'barcode.SaveImage(archivo, SaveTypes.PNG)

        Return bytes

    End Function

End Module
