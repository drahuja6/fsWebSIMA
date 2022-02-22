Imports System.Data.OleDb

Public Class RecepEnConc
    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents lblFechaDeCorteVigente As Label
    Protected WithEvents Label1 As Label
    Protected WithEvents txtCajaConc As TextBox
    Protected WithEvents btnQuitar As Button
    Protected WithEvents btnRevisaExp As Button
    Protected WithEvents ddlBatches As DropDownList
    Protected WithEvents btnBuscaLote As Button
    Protected WithEvents lbExpDelLote As ListBox
    Protected WithEvents lbExpConCajaConc As ListBox
    Protected WithEvents btnAsignaCajaConc As Button
    Protected WithEvents lblValidaCajaConc As Label
    Protected WithEvents btnImprimeResguardo As Button
    Protected WithEvents lblValidaLoteAtendido As Label
    Protected WithEvents ddlUnidAdm As DropDownList
    Protected WithEvents Label2 As Label
    Protected WithEvents btnBuscaLotes As Button
    Protected WithEvents btnFinalizarLote As Button
    Protected WithEvents lblValidaLoteAtendidoEImpreso As Label

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

        If Not Page.IsPostBack Then
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlUnidAdm, "UnidadesAdministrativasDeUnUsuarioReal", Session("IDUsuarioReal"), "idUnidadAdministrativa", "NombreCorto", -1)


            'FillDropDownList(Session("UsuarioVirtualConnString"), ddlBatches, "LotesPorAtender", ddlUnidAdm.SelectedValue, "idBatch", "Descripcion", -1)
            'txtFechaDeCorte.Text = Format(Now, "dd/MM/yyyy")
        Else
        End If

    End Sub

    'Incluye la posibilidad de pasar un parámetro al SP.
    Public Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As DropDownList, _
                        ByVal StoredProcedure As String, _
                        ByVal Parameter1 As Integer, _
                        ByVal FieldItemData As String, _
                        ByVal FieldToShow As String, _
                        ByVal ShowItemData As Integer)

        'Rutina para llenar un DropDownList

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader
        Dim IndexMemo As Integer = -1
        Dim MyIndice As Integer = 0

        Try
            MyDropDownList.Items.Clear()

            'Abro la conexión
            cn.ConnectionString = ConnString
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = StoredProcedure
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'Parameter1
            param = cmd.Parameters.Add("MySPParameter", Data.OleDb.OleDbType.Integer)
            param.Value = Parameter1

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                MyIndice = 0
                While dr.Read()

                    Dim MyDropDownListItem As New ListItem

                    MyDropDownListItem.Text = CStr(dr(FieldToShow))
                    MyDropDownListItem.Value = CInt(dr(FieldItemData))

                    If MyDropDownListItem.Value = ShowItemData Then
                        IndexMemo = MyIndice
                    End If

                    MyDropDownList.Items.Add(MyDropDownListItem)

                    MyIndice += 1

                End While

                MyDropDownList.SelectedIndex = IndexMemo

            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)

        End Try

    End Sub

    'Incluye la posibilidad de pasar un parámetro al SP.
    Public Sub FillDropDownList0( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As DropDownList, _
                        ByVal StoredProcedure As String, _
                        ByVal FieldItemData As String, _
                        ByVal FieldToShow As String, _
                        ByVal ShowItemData As Integer)

        'Rutina para llenar un DropDownList

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader
        Dim IndexMemo As Integer = -1
        Dim MyIndice As Integer = 0

        Try
            MyDropDownList.Items.Clear()

            'Abro la conexión
            cn.ConnectionString = ConnString
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = StoredProcedure
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            ''Parameter1
            'param = cmd.Parameters.Add("MySPParameter", Data.OleDb.OleDbType.Integer)
            'param.Value = Parameter1

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                MyIndice = 0
                While dr.Read()

                    Dim MyDropDownListItem As New ListItem

                    MyDropDownListItem.Text = CStr(dr(FieldToShow))
                    MyDropDownListItem.Value = CInt(dr(FieldItemData))

                    If MyDropDownListItem.Value = ShowItemData Then
                        IndexMemo = MyIndice
                    End If

                    MyDropDownList.Items.Add(MyDropDownListItem)

                    MyIndice += 1

                End While

                MyDropDownList.SelectedIndex = IndexMemo

            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)

        End Try

    End Sub

    Private Sub btnBuscaLote_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBuscaLote.Click

        lbExpDelLote.Items.Clear()
        lbExpConCajaConc.Items.Clear()
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        If ddlBatches.Items.Count = 0 Then
            Return
        End If

        FillListBoxSpecial_1(lbExpDelLote, Session("UsuarioVirtualConnString"), "SelExpDeLote", ddlBatches.SelectedValue, "Expediente", "idExpediente")

        FillListBoxSpecial_1(lbExpConCajaConc, Session("UsuarioVirtualConnString"), "SelExpDeLote2", ddlBatches.SelectedValue, "Expediente", "idExpediente")

    End Sub

    'Rutina para cargar un listbox.
    Public Sub FillListBoxSpecial_1( _
                                ByVal MyListBox As ListBox, _
                                ByVal ConnString As String, _
                                ByVal StoredProcedure As String, _
                                ByVal Parameter1 As Integer, _
                                ByVal MyDataTextField As String, _
                                ByVal MyDataValueField As String)

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
            param.Value = Parameter1

            'param = cmd.Parameters.Add("idParameter", Data.OleDb.OleDbType.Date)
            'param.Value = Parameter2

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

    Private Sub ddlBatches_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ddlBatches.SelectedIndexChanged

        lbExpDelLote.Items.Clear()
        lbExpConCajaConc.Items.Clear()

    End Sub

    Private Sub btnRevisaExp_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRevisaExp.Click

        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        Dim item As ListItem
        For Each item In lbExpDelLote.Items
            If item.Selected Then
                Session("IDExpedienteActivo") = item.Value
                Session("ExpedienteStatus") = 0
                Session("MovimientoStatus") = 0
                Session("CuadroClasificacionStatus") = 0
                Session("UsuarioRealStatus") = 0
                Response.Redirect("./DisplayExpediente.aspx")
            End If
        Next

    End Sub

    Private Sub btnAsignaCajaConc_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAsignaCajaConc.Click

        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        'Validación para evitar Caja Concentracion en blanco
        If Trim(txtCajaConc.Text) = "" Then
            lblValidaCajaConc.Visible = True
            Return
        Else
            lblValidaCajaConc.Visible = False
        End If

        Dim item As ListItem
        For Each item In lbExpDelLote.Items
            If item.Selected Then
                'If Not Mid(item.Text, 1, 5) = "*****" Then
                '    Dim nitem As New ListItem
                '    nitem.Value = item.Value
                '    nitem.Text = "[CAJA CONC " & txtCajaConc.Text & "] - " & item.Text
                '    lbExpConCajaConc.Items.Add(nitem)
                '    item.Text = "*****" & item.Text

                    Batches_Relaciones_UPDATE_CAJAPROV2(ddlBatches.SelectedValue, item.Value, txtCajaConc.Text)

                'End If
            End If
        Next

        'FillListBoxSpecial_1(lbExpDelLote, Session("UsuarioVirtualConnString"), "SelExpDeLote", ddlBatches.SelectedValue, "Expediente", "idExpediente")

        If ddlBatches.Items.Count > 0 Then
            FillListBoxSpecial_1(lbExpDelLote, Session("UsuarioVirtualConnString"), "SelExpDeLote", ddlBatches.SelectedValue, "Expediente", "idExpediente")

            FillListBoxSpecial_1(lbExpConCajaConc, Session("UsuarioVirtualConnString"), "SelExpDeLote2", ddlBatches.SelectedValue, "Expediente", "idExpediente")
        End If



    End Sub

    Public Function Batches_Relaciones_UPDATE_CAJAPROV2( _
        ByVal idBatch As Integer, _
        ByVal idExpediente As Integer, _
        ByVal CajaProv2 As String _
        ) As Integer


        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Batches_Relaciones_UPDATE_CAJAPROV2"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'CajaProv2
            param = cmd.Parameters.Add("CajaProv2", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = CajaProv2

            'idBatchEditado
            param = cmd.Parameters.Add("idBatchEditado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record editado
            Batches_Relaciones_UPDATE_CAJAPROV2 = CInt(cmd.Parameters("idBatchEditado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Batches_Relaciones_UPDATE_CAJAPROV2 = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Public Function Exp_UPD_Stat_Conc(ByVal idBatch As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Exp_UPD_Stat_Conc"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'idBatchEditado
            param = cmd.Parameters.Add("idBatchEditado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record editado
            Exp_UPD_Stat_Conc = CInt(cmd.Parameters("idBatchEditado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Exp_UPD_Stat_Conc = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try


    End Function

    Private Sub btnImprimeResguardo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeResguardo.Click

        lblValidaLoteAtendidoEImpreso.Visible = False

        'Valido que no queden expedientes propuestos para baja
        If lbExpDelLote.Items.Count > 0 Then
            lblValidaLoteAtendido.Visible = True
            Return
        Else
            lblValidaLoteAtendido.Visible = False
        End If

        'Valido que haya expedientes ya dados de baja
        If lbExpConCajaConc.Items.Count = 0 Then
            lblValidaLoteAtendido.Visible = True
            Return
        Else
            lblValidaLoteAtendido.Visible = False
        End If


        'Debo cambiar el status de los expedientes del batch completo hacia 4 (Vig en Conc)
        'y ademas debo escribir la caja conc en cada uno de los expedientes

        Exp_UPD_Stat_Conc(ddlBatches.SelectedValue)

        ImprimeLoteConcTerminado(ddlBatches.SelectedValue)


    End Sub

    Sub ImprimeLoteConcTerminado(ByVal idBatch As Integer)

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New ListaBatchExpFOV

        Try

            'If Not IsNumeric(txtNuevoBatchID2.Text) Then
            '    Return
            'End If

            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = cn
            cmd.Parameters.Clear()
            cmd.CommandText = "ListBatchConcTerminado"
            cmd.CommandTimeout = 0

            param = cmd.Parameters.Add("SQLCondicion", OleDbType.Integer)
            param.Value = idBatch

            da.SelectCommand = cmd
            da.Fill(ds)
            da.Dispose()

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, "Listado de expedientes aceptados en Concentración -  LOTE: " & idBatch)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

            'Write the file directly to the HTTP output stream.
            Response.ContentType = "application/pdf"
            Response.AddHeader("content-Disposition", "inline; filename=recepcionconcentracion.pdf")
            Response.WriteFile(MyFileName)
            Response.Flush()

            If IO.File.Exists(MyFileName) Then
                IO.File.Delete(MyFileName)
            End If

            Reporte.Dispose()

            Response.End()
        Catch ex As Exception

        End Try

    End Sub



    Private Sub btnBuscaLotes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBuscaLotes.Click

        ddlBatches.Items.Clear()
        lbExpDelLote.Items.Clear()
        lbExpConCajaConc.Items.Clear()
        lblValidaLoteAtendido.Visible = False
        lblValidaLoteAtendidoEImpreso.Visible = False

        If ddlUnidAdm.Items.Count = 0 Then
            Return
        End If

        FillDropDownList2(Session("UsuarioVirtualConnString"), ddlBatches, "LotesPorAtender", ddlUnidAdm.SelectedValue, 1, "idBatch", "Descripcion", -1)

    End Sub

    'Incluye la posibilidad de pasar dos parámetros al SP.
    Public Sub FillDropDownList2( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As DropDownList, _
                        ByVal StoredProcedure As String, _
                        ByVal Parameter1 As Integer, _
                        ByVal Parameter2 As Integer, _
                        ByVal FieldItemData As String, _
                        ByVal FieldToShow As String, _
                        ByVal ShowItemData As Integer)

        'Rutina para llenar un DropDownList

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader
        Dim IndexMemo As Integer = -1
        Dim MyIndice As Integer = 0

        Try
            MyDropDownList.Items.Clear()

            'Abro la conexión
            cn.ConnectionString = ConnString
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = StoredProcedure
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'Parameter1
            param = cmd.Parameters.Add("MySPParameter1", Data.OleDb.OleDbType.Integer)
            param.Value = Parameter1

            'Parameter2
            param = cmd.Parameters.Add("MySPParameter2", Data.OleDb.OleDbType.Integer)
            param.Value = Parameter2

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                MyIndice = 0
                While dr.Read()

                    Dim MyDropDownListItem As New ListItem

                    MyDropDownListItem.Text = CStr(dr(FieldToShow))
                    MyDropDownListItem.Value = CInt(dr(FieldItemData))

                    If MyDropDownListItem.Value = ShowItemData Then
                        IndexMemo = MyIndice
                    End If

                    MyDropDownList.Items.Add(MyDropDownListItem)

                    MyIndice += 1

                End While

                MyDropDownList.SelectedIndex = IndexMemo

            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)

        End Try

    End Sub

    Private Sub ddlUnidAdm_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ddlUnidAdm.SelectedIndexChanged

        'FillDropDownList(Session("UsuarioVirtualConnString"), ddlBatches, "LotesPorAtender", -1, "idBatch", "Descripcion", -1)

        ddlBatches.Items.Clear()
        lbExpDelLote.Items.Clear()
        lbExpConCajaConc.Items.Clear()

    End Sub

    Private Sub btnQuitar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnQuitar.Click

        Dim BorreAlgunItem As Boolean
        Dim item As ListItem

        Try
            lblValidaLoteAtendido.Visible = False
            lblValidaLoteAtendidoEImpreso.Visible = False

            Do
                BorreAlgunItem = False
                For Each item In lbExpConCajaConc.Items
                    If item.Selected Then

                        Batches_Relaciones_UPDATE_CAJAPROV2(ddlBatches.SelectedValue, lbExpConCajaConc.SelectedValue, "")

                        lbExpConCajaConc.Items.Remove(item)
                        BorreAlgunItem = True
                        Exit For
                    End If
                Next
            Loop While BorreAlgunItem

            FillListBoxSpecial_1(lbExpDelLote, Session("UsuarioVirtualConnString"), "SelExpDeLote", ddlBatches.SelectedValue, "Expediente", "idExpediente")

            FillListBoxSpecial_1(lbExpConCajaConc, Session("UsuarioVirtualConnString"), "SelExpDeLote2", ddlBatches.SelectedValue, "Expediente", "idExpediente")

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnFinalizarLote_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFinalizarLote.Click

        lblValidaLoteAtendido.Visible = False


        'Compruebo que no queden expedientes en el lote
        'sin tener su caja de Concentracion asignada
        If lbExpDelLote.Items.Count > 0 Then
            lblValidaLoteAtendidoEImpreso.Visible = True
            Return
        Else
            lblValidaLoteAtendidoEImpreso.Visible = False
        End If

        'Compruebo que al menos hay un expediente con caja asignada
        If lbExpConCajaConc.Items.Count = 0 Then
            lblValidaLoteAtendidoEImpreso.Visible = True
            Return
        Else
            lblValidaLoteAtendidoEImpreso.Visible = False
        End If

        'Compruebo que todos los expedientes del lote 
        'tienen estatus 4 (Vigentes en Concentracion)

        If AllExpDeLoteEnStatusX(ddlBatches.SelectedValue, 4) Then

            'Procedo a borrar el lote (no los expedientes, claro)
            Batches_DELETE(ddlBatches.SelectedValue)

            'Y limpio toda la forma
            ddlBatches.Items.Clear()
            lbExpDelLote.Items.Clear()
            lbExpConCajaConc.Items.Clear()
            lblValidaLoteAtendido.Visible = False
            lblValidaLoteAtendidoEImpreso.Visible = False

            If ddlUnidAdm.Items.Count = 0 Then
                Return
            End If

            FillDropDownList(Session("UsuarioVirtualConnString"), ddlBatches, "LotesPorAtender", ddlUnidAdm.SelectedValue, "idBatch", "Descripcion", -1)

        End If

    End Sub

    Public Function Batches_DELETE(ByVal idBatch As Integer) As Integer


        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Batches_DELETE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'idBatchEliminado
            param = cmd.Parameters.Add("idBatchEliminado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            Batches_DELETE = CInt(cmd.Parameters("idBatchEliminado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Batches_DELETE = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function


    Function AllExpDeLoteEnStatusX(ByVal idBatch As Integer, ByVal StatusAComprobar As Integer) As Boolean

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "AllExpDeLoteEnStatusX"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'StatusAComprobar
            param = cmd.Parameters.Add("StatusAComprobar", Data.OleDb.OleDbType.Integer)
            param.Value = StatusAComprobar

            'Respuesta
            param = cmd.Parameters.Add("Respuesta", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Interpreto la respuesta
            If CInt(cmd.Parameters("Respuesta").Value) = 0 Then
                AllExpDeLoteEnStatusX = False
            Else
                AllExpDeLoteEnStatusX = True
            End If

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            AllExpDeLoteEnStatusX = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try


    End Function

End Class
