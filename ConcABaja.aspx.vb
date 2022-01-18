Imports System.Data.OleDb
Imports System.Text.RegularExpressions

Public Class ConcABaja
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents lblFechaDeCorteVigente As System.Web.UI.WebControls.Label
    Protected WithEvents ddlUnidAdm As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaDeCorte As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblValidaFechaDeCorteVigente As System.Web.UI.WebControls.Label
    Protected WithEvents btnBuscaVencidos As System.Web.UI.WebControls.Button
    Protected WithEvents btnImpListado As System.Web.UI.WebControls.Button
    Protected WithEvents btnRevisaExp As System.Web.UI.WebControls.Button
    Protected WithEvents lbExpVencEnConc As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNuevoBatchID As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtFechCorteVig As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblValidaNuevoBatch As System.Web.UI.WebControls.Label
    Protected WithEvents txtNuevoBatchDesc As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnNuevoBatch As System.Web.UI.WebControls.Button
    Protected WithEvents lbExpConCaja As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNuevoBatchID2 As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnImprimeEnvio As System.Web.UI.WebControls.Button
    Protected WithEvents btnQuitar As System.Web.UI.WebControls.Button
    Protected WithEvents txtCajaProv As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblValidaCajaProv As System.Web.UI.WebControls.Label
    Protected WithEvents btnAsignaCaja As System.Web.UI.WebControls.Button

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
            txtFechaDeCorte.Text = Format(Now, "dd/MM/yyyy")
        Else
        End If

    End Sub

    'Incluye la posibilidad de pasar un parámetro al SP.
    Public Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As System.Web.UI.WebControls.DropDownList, _
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

                    Dim MyDropDownListItem As New System.Web.UI.WebControls.ListItem

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

    Private Sub btnBuscaVencidos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBuscaVencidos.Click

        If Not RevisaForma() Then
            Return
        End If

        FillListBoxSpecial(lbExpVencEnConc, Session("UsuarioVirtualConnString"), "SelVencEnConc", ddlUnidAdm.SelectedValue, CDate(txtFechaDeCorte.Text), "Expediente", "idExpediente")

    End Sub

    Function RevisaForma() As Boolean

        'Validación para evitar Fecha en blanco
        If Trim(txtFechaDeCorte.Text) = "" Then
            lblValidaFechaDeCorteVigente.Visible = True
            Return False
        Else
            lblValidaFechaDeCorteVigente.Visible = False
        End If


        'Validación para evitar Fecha de Apertura en formato gringo
        If Not ValidaFechaLatina(txtFechaDeCorte.Text) Then
            lblValidaFechaDeCorteVigente.Visible = True
            Return False
        Else
            lblValidaFechaDeCorteVigente.Visible = False
        End If


        ''Validacion para evitar que la fecha propuesta sea anterior a la vigente
        'If CDate(txtFechaDeCorteVigente.Text) < CDate(LeeMemoStatusVigente()) Then
        '    lblValidaFechaDeCorteVigente.Visible = True
        '    Return False
        'Else
        '    lblValidaFechaDeCorteVigente.Visible = False
        'End If

        ''Validacion para evitar que la fecha propuesta sea posterior en más de 31 días a la vigente
        'If DateDiff(DateInterval.Day, CDate(LeeMemoStatusVigente()), CDate(txtFechaDeCorteVigente.Text)) > 31 Then
        '    lblValidaFechaDeCorteVigente.Visible = True
        '    Return False
        'Else
        '    lblValidaFechaDeCorteVigente.Visible = False
        'End If

        Return True

    End Function

    Function ValidaFechaLatina(ByVal f As String) As Boolean
        If f = "" Then
            Return True
        End If
        Dim re As New Regex("^(((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}|\d))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00|[048])))$")
        ' Get the collection of matches.
        Dim mc As MatchCollection = re.Matches(f)
        ' How many occurrences did we find?
        If mc.Count = 1 Then
            Return True
        Else
            Return False
        End If
    End Function

    'Rutina para cargar un listbox.
    Public Sub FillListBoxSpecial( _
                                ByVal MyListBox As ListBox, _
                                ByVal ConnString As String, _
                                ByVal StoredProcedure As String, _
                                ByVal Parameter1 As Integer, _
                                ByVal Parameter2 As Date, _
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

            param = cmd.Parameters.Add("idParameter", Data.OleDb.OleDbType.Date)
            param.Value = Parameter2

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

    Private Sub btnImpListado_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImpListado.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New ListaExpTramVenc

        Try

            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = cn
            cmd.Parameters.Clear()
            cmd.CommandText = "SelVencEnConc"
            cmd.CommandTimeout = 0

            'Unidad Administrativa
            param = cmd.Parameters.Add("UnidAdm", Data.OleDb.OleDbType.Integer)
            param.Value = CInt(ddlUnidAdm.SelectedValue)

            'Fecha de corte
            param = cmd.Parameters.Add("FechaDeCorte", Data.OleDb.OleDbType.Date)
            param.Value = CDate(txtFechaDeCorte.Text)

            da.SelectCommand = cmd
            da.Fill(ds)
            da.Dispose()

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, ddlUnidAdm.SelectedItem.Text)
            Reporte.SetParameterValue(1, txtFechaDeCorte.Text)
            Reporte.SetParameterValue(2, "Listado de Expedientes de Concentración Vencidos")


            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

            'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
            'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

            'Write the file directly to the HTTP output stream.
            Response.ContentType = "Application/pdf"
            Response.WriteFile(MyFileName)
            Response.End()

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnRevisaExp_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRevisaExp.Click

        Dim item As ListItem
        For Each item In lbExpVencEnConc.Items
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

    Private Sub btnNuevoBatch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNuevoBatch.Click

        'Validación para evitar Fecha en blanco
        If Trim(txtFechaDeCorte.Text) = "" Then
            lblValidaFechaDeCorteVigente.Visible = True
            Return
        Else
            lblValidaFechaDeCorteVigente.Visible = False
        End If

        'Validación para evitar Fecha de Apertura en formato gringo
        If Not ValidaFechaLatina(txtFechaDeCorte.Text) Then
            lblValidaFechaDeCorteVigente.Visible = True
            Return
        Else
            lblValidaFechaDeCorteVigente.Visible = False
        End If

        'Validación para evitar crear un batch si está vacío
        'el listbox de expedientes vencidos
        If lbExpVencEnConc.Items.Count = 0 Then
            lblValidaNuevoBatch.Visible = True
            Return
        Else
            lblValidaNuevoBatch.Visible = False
        End If

        'Validación para evitar crear un batch si no esta
        'en blanco el listbox de expedientes con caja provisional
        If lbExpConCaja.Items.Count <> 0 Then
            lblValidaNuevoBatch.Visible = True
            Return
        Else
            lblValidaNuevoBatch.Visible = False
        End If


        Dim idNuevoBatch As Integer

        idNuevoBatch = Batches_INSERT(txtNuevoBatchDesc.Text, Session("idUsuarioReal"), CDate(Format(Now(), "dd/MM/yyyy")), 2, ddlUnidAdm.SelectedValue, CDate(txtFechaDeCorte.Text))

        'Session("idBatchVigente") = idNuevoBatch
        txtNuevoBatchID.Text = idNuevoBatch
        txtNuevoBatchID2.Text = idNuevoBatch
        txtFechCorteVig.Text = txtFechaDeCorte.Text

        If idNuevoBatch <> 0 Then
        Else
        End If

    End Sub

    Public Function Batches_INSERT( _
        ByVal Descripcion As String, _
        ByVal idOperador As Integer, _
        ByVal FechaCreacion As DateTime, _
        ByVal idTipoDeBatch As Integer, _
        ByVal idUnidAdm As Integer, _
        ByVal FechaCorte As DateTime _
        ) As Integer


        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Batches_INSERT"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'Descripcion
            param = cmd.Parameters.Add("Descripcion", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = Descripcion

            'idOperador
            param = cmd.Parameters.Add("idOperador", Data.OleDb.OleDbType.Integer)
            param.Value = idOperador

            'FechaCreacion
            param = cmd.Parameters.Add("FechaCreacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaCreacion

            'idTipoDeBatch
            param = cmd.Parameters.Add("idTipoDeBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idTipoDeBatch

            'idUnidAdm
            param = cmd.Parameters.Add("idUnidAdm", Data.OleDb.OleDbType.Integer)
            param.Value = idUnidAdm

            'FechaCorte
            param = cmd.Parameters.Add("FechaCorte", Data.OleDb.OleDbType.Date)
            param.Value = FechaCorte

            'idBatchAgregado
            param = cmd.Parameters.Add("idBatchAgregado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            Batches_INSERT = CInt(cmd.Parameters("idBatchAgregado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Batches_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    'Private Sub btnPasarABaja_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    '    'Validación para evitar Batch en blanco
    '    If Trim(txtNuevoBatchID.Text) = "" Then
    '        lblValidaNuevoBatch.Visible = True
    '        Return
    '    Else
    '        lblValidaNuevoBatch.Visible = False
    '    End If

    '    ''Validación para evitar Caja Provisional en blanco
    '    'If Trim(txtCajaProv.Text) = "" Then
    '    '    lblValidaCajaProv.Visible = True
    '    '    Return
    '    'Else
    '    '    lblValidaCajaProv.Visible = False
    '    'End If

    '    Dim item As ListItem
    '    For Each item In lbExpVencEnConc.Items
    '        If item.Selected Then
    '            If Not Mid(item.Text, 1, 5) = "*****" Then
    '                Dim nitem As New ListItem
    '                nitem.Value = item.Value
    '                nitem.Text = item.Text '"[CAJA " & txtCajaProv.Text & "] - " & item.Text
    '                lbExpConCaja.Items.Add(nitem)
    '                item.Text = "*****" & item.Text

    '                Batches_Relaciones_INSERT(txtNuevoBatchID.Text, item.Value, "")
    '                ExpCambiaStatus(item.Value, 7)
    '            End If
    '        End If
    '    Next

    '    FillListBoxSpecial(lbExpVencEnConc, Session("UsuarioVirtualConnString"), "SelVencEnConc", ddlUnidAdm.SelectedValue, CDate(txtFechaDeCorte.Text), "Expediente", "idExpediente")

    'End Sub

    Public Sub ExpCambiaStatus(ByVal idExpediente As Integer, ByVal Status As Integer)

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "ExpCambiaStatus"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'Status
            param = cmd.Parameters.Add("Status", Data.OleDb.OleDbType.Integer)
            param.Value = Status

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Sub

    Public Function Batches_Relaciones_INSERT( _
        ByVal idBatch As Integer, _
        ByVal idExpediente As Integer, _
        ByVal CajaProv As String _
        ) As Integer


        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Batches_Relaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'CajaProv
            param = cmd.Parameters.Add("CajaProv", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = CajaProv

            'idBatchAgregado
            param = cmd.Parameters.Add("idBatchAgregado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            Batches_Relaciones_INSERT = CInt(cmd.Parameters("idBatchAgregado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Batches_Relaciones_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Sub btnImprimeEnvio_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeEnvio.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New ListaBatchExpFOV

        Try

            If Not IsNumeric(txtNuevoBatchID2.Text) Then
                Return
            End If

            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = cn
            cmd.Parameters.Clear()
            cmd.CommandText = "ListBatchTramConc"
            cmd.CommandTimeout = 0

            param = cmd.Parameters.Add("SQLCondicion", OleDbType.Integer)
            param.Value = CInt(txtNuevoBatchID2.Text)

            da.SelectCommand = cmd
            da.Fill(ds)
            da.Dispose()

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, "Listado de expedientes enviados a Baja -  LOTE: " & txtNuevoBatchID2.Text)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

            'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
            'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

            'Write the file directly to the HTTP output stream.
            Response.ContentType = "Application/pdf"
            Response.WriteFile(MyFileName)
            Response.End()

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnQuitar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnQuitar.Click

        Dim BorreAlgunItem As Boolean
        Dim item As ListItem

        Try
            Do
                BorreAlgunItem = False
                For Each item In lbExpConCaja.Items
                    If item.Selected Then
                        Batches_Relaciones_DELETE(txtNuevoBatchID.Text, item.Value, 4)
                        lbExpConCaja.Items.Remove(item)
                        BorreAlgunItem = True
                        Exit For
                    End If
                Next
            Loop While BorreAlgunItem

            FillListBoxSpecial(lbExpVencEnConc, Session("UsuarioVirtualConnString"), "SelVencEnConc", ddlUnidAdm.SelectedValue, CDate(txtFechaDeCorte.Text), "Expediente", "idExpediente")

        Catch ex As Exception

        End Try

    End Sub

    Public Function Batches_Relaciones_DELETE( _
ByVal idBatch As Integer, _
ByVal idExpediente As Integer, _
ByVal StatusDeRegreso As Integer) As Integer


        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Batches_Relaciones_DELETE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idBatch
            param = cmd.Parameters.Add("idBatch", Data.OleDb.OleDbType.Integer)
            param.Value = idBatch

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'StatusDeRegreso
            param = cmd.Parameters.Add("StatusDeRegreso", Data.OleDb.OleDbType.Integer)
            param.Value = StatusDeRegreso

            'idBatchEliminado
            param = cmd.Parameters.Add("idBatchEliminado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            Batches_Relaciones_DELETE = CInt(cmd.Parameters("idBatchEliminado").Value)

            cn.Close()

        Catch ex As Exception

            'lblValidaCodigo.Visible = True
            'lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Batches_Relaciones_DELETE = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Sub btnAsignaCaja_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAsignaCaja.Click

        'Validación para evitar Batch en blanco
        If Trim(txtNuevoBatchID.Text) = "" Then
            lblValidaNuevoBatch.Visible = True
            Return
        Else
            lblValidaNuevoBatch.Visible = False
        End If

        'Validación para evitar Caja Provisional en blanco
        If Trim(txtCajaProv.Text) = "" Then
            lblValidaCajaProv.Visible = True
            Return
        Else
            lblValidaCajaProv.Visible = False
        End If

        Dim item As ListItem
        For Each item In lbExpVencEnConc.Items
            If item.Selected Then
                If Not Mid(item.Text, 1, 5) = "*****" Then
                    Dim nitem As New ListItem
                    nitem.Value = item.Value
                    nitem.Text = "[CAJA " & txtCajaProv.Text & "] - " & item.Text
                    lbExpConCaja.Items.Add(nitem)
                    item.Text = "*****" & item.Text

                    Batches_Relaciones_INSERT(txtNuevoBatchID.Text, item.Value, txtCajaProv.Text)
                    'ExpCambiaStatus(item.Value, 7)
                End If
            End If
        Next

        FillListBoxSpecial(lbExpVencEnConc, Session("UsuarioVirtualConnString"), "SelVencEnConc", ddlUnidAdm.SelectedValue, CDate(txtFechaDeCorte.Text), "Expediente", "idExpediente")

    End Sub
End Class
