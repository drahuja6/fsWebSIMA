Imports System.Data.OleDb

Public Class UsuarioRealDisplay
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNombre As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtLogin As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents txtContrasena As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtVerificacionContrasena As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents ddlstUsuarioVirtualAsociado As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents btnAgregar As System.Web.UI.WebControls.Button
    Protected WithEvents btnEditar As System.Web.UI.WebControls.Button
    Protected WithEvents btnBorrar As System.Web.UI.WebControls.Button
    Protected WithEvents btnSalvar As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelar As System.Web.UI.WebControls.Button
    Protected WithEvents lblUsuarioRealStatus As System.Web.UI.WebControls.Label
    Protected WithEvents lbxUnidadesAdministrativas As System.Web.UI.WebControls.ListBox
    Protected WithEvents lblValidaPassword1 As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaPassword2 As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaLogin As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaNombre As System.Web.UI.WebControls.Label
    Protected WithEvents btnRegresar As System.Web.UI.WebControls.Button

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

        Session("CuadroClasificacionStatus") = 0
        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Select Case Session("UsuarioRealStatus")
            Case 0 'SOLO LECTURA
                FillUsuarioReal(CInt(Session("idUsuarioRealEnEdicionActivo")))
            Case 1 'AÑADIENDO

            Case 2 'EDITANDO
            Case 3 'BORRANDO

        End Select

        If Session("idUsuarioRealEnEdicionActivo") = -1 Then
            btnEditar.Enabled = False
            btnBorrar.Enabled = False
        End If

        MuestraStatus()

    End Sub

    Sub MuestraStatus()

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Select Case Session("UsuarioRealStatus")
            Case 0  '0=SOLO LECTURA
                lblUsuarioRealStatus.Text = "(SÓLO LECTURA)"
                lblUsuarioRealStatus.ForeColor = Drawing.Color.Red
            Case 1  '1=AÑADIENDO
                lblUsuarioRealStatus.Text = "(EDITABLE)"
                lblUsuarioRealStatus.ForeColor = Drawing.Color.Green
            Case 2  '2=EDITANDO
                lblUsuarioRealStatus.Text = "(EDITABLE)"
                lblUsuarioRealStatus.ForeColor = Drawing.Color.Green
            Case 3  '3=BORRANDO
                lblUsuarioRealStatus.Text = "(SÓLO LECTURA)"
                lblUsuarioRealStatus.ForeColor = Drawing.Color.Red
        End Select

    End Sub

    Function FillUsuarioReal(ByVal idUsuarioReal As Integer) As Boolean

        'Rutina para leer y llenar la forma con los datos de UN usuario real
        Dim scrambler As New GITDataTools.ScrambleNET

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try
            LimpiaCamposUsuarioReal()

            'Llenado de combos (sin escoger valor, por si no hay Usuario Virtual)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstUsuarioVirtualAsociado, "UsuariosVirtuales_SELECTALL", "idUsuarioVirtual", "Nombre", -1)

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "UsuariosReales_SELECTONE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idUsuarioReal", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuarioReal

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()

                    txtNombre.Text = CStr(dr("Nombre"))
                    txtLogin.Text = CStr(dr("Login"))
                    txtContrasena.Text = scrambler.Scramble(CStr(dr("password")), Chr(25) & Chr(26))
                    txtVerificacionContrasena.Text = txtContrasena.Text

                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstUsuarioVirtualAsociado, "UsuariosVirtuales_SELECTALL", "idUsuarioVirtual", "Nombre", CInt(dr("idUsuarioVirtual")))

                End While

                'Me conviene leer los CheckListBoxes cada vez que cambio de nodo
                'porque aunque siempre son los mismos, el sp me ordena primero los que se utilizan
                'en este nodo

                'Unidades Administrativas
                '********************************************************************
                'FillListBox2(Session("UsuarioVirtualConnString"), lbxUnidadesAdministrativas, "CargaUsuarioRealUnidadesAdministrativasRelaciones", idUsuarioReal, "idUnidadAdministrativa", "Descripcion", "Activo")
                FillListBox2(Session("UsuarioVirtualConnString"), lbxUnidadesAdministrativas, "CargaUsuarioRealUnidadesAdministrativasRelaciones", idUsuarioReal, "idUnidadAdministrativa", "NombreCorto", "Activo")

                FillUsuarioReal = True
            Else
                FillUsuarioReal = False
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            FillUsuarioReal = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Sub LimpiaCamposUsuarioReal()

        txtNombre.Text = ""
        txtLogin.Text = ""
        txtContrasena.Text = ""
        txtVerificacionContrasena.Text = ""

    End Sub

    'Rutina para cargar datos a un DropDownList.
    Public Shared Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As System.Web.UI.WebControls.DropDownList, _
                        ByVal StoredProcedure As String, _
                        ByVal FieldItemData As String, _
                        ByVal FieldToShow As String, _
                        ByVal ShowItemData As Integer)

        'Rutina para llenar un DropDownList

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
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

    'Sobrecarga de la rutina para cargar datos a un DropDownList. 
    'Incluye la posibilidad de pasar un parámetro al SP.
    Public Shared Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As System.Web.UI.WebControls.DropDownList, _
                        ByVal StoredProcedure As String, _
                        ByVal SPParameter As Integer, _
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

            'MySPParameter
            param = cmd.Parameters.Add("MySPParameter", Data.OleDb.OleDbType.Integer)
            param.Value = SPParameter

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

    'Rutina para cargar una lista y seleccionar algunos items.
    Public Sub FillListBox2( _
                                ByVal ConnString As String, _
                                ByVal MyListBox As ListBox, _
                                ByVal StoredProcedure As String, _
                                ByVal idParameter As Integer, _
                                ByVal FieldItemData As String, _
                                ByVal FieldToShow As String, _
                                ByVal FieldSelected As String)

        'Rutina para llenar un combobox

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader
        Dim IndexMemo As Integer = -1
        Dim MyIndice As Integer = 0

        Try
            MyListBox.Items.Clear()

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
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()

                    Dim MyListItem As New System.Web.UI.WebControls.ListItem

                    MyListItem.Text = CStr(dr(FieldToShow))
                    MyListItem.Value = CInt(dr(FieldItemData))
                    MyListItem.Selected = CBool(dr(FieldSelected))

                    MyListBox.Items.Add(MyListItem)

                End While

            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)

        End Try

    End Sub

    Private Sub btnAgregar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAgregar.Click

        Session("UsuarioRealStatus") = 1
        MuestraStatus()

        LimpiaCamposUsuarioReal()

        EnableDisableControlesDePropiedades(True)

        EnableDisableBotones(False)
        'btnAgregar.Enabled = False
        'btnEditar.Enabled = False
        'btnBorrar.Enabled = False

    End Sub

    Sub EnableDisableControlesDePropiedades(ByVal valor As Boolean)

        'Habilita o desabilita los controles para ver/editar propiedades de los nodos

        txtNombre.Enabled = valor
        txtLogin.Enabled = valor
        txtContrasena.Enabled = valor
        txtVerificacionContrasena.Enabled = valor
        ddlstUsuarioVirtualAsociado.Enabled = valor
        lbxUnidadesAdministrativas.Enabled = valor
        lbxUnidadesAdministrativas.Enabled = valor
        btnSalvar.Enabled = valor
        btnCancelar.Enabled = valor

    End Sub

    Sub EnableDisableBotones(ByVal valor As Boolean)

        btnAgregar.Enabled = valor
        btnRegresar.Enabled = valor
        btnEditar.Enabled = valor
        btnBorrar.Enabled = valor

        If Session("idUsuarioRealEnEdicionActivo") = -1 Then
            btnEditar.Enabled = False
            btnBorrar.Enabled = False
        End If

    End Sub

    Private Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("UsuarioRealStatus") = 0
        MuestraStatus()

        EnableDisableControlesDePropiedades(False)

        EnableDisableBotones(True)
        'btnAgregar.Enabled = True
        'btnEditar.Enabled = True
        'btnBorrar.Enabled = True

        Response.Redirect("./UsuarioRealDisplay.aspx")

    End Sub

    Function RevisaForma() As Boolean

        'Validación para evitar Nombre vacío
        If Trim(txtNombre.Text) = "" Then
            lblValidaNombre.Visible = True
            Return False
        Else
            lblValidaNombre.Visible = False
        End If

        'Validación para evitar Login vacío
        If Trim(txtLogin.Text) = "" Then
            lblValidaLogin.Visible = True
            Return False
        Else
            lblValidaLogin.Visible = False
        End If

        'Validación para evitar Contrasena vacía
        If CInt(Session("UsuarioRealStatus")) <> 3 Then
            If Trim(txtContrasena.Text) = "" Then
                lblValidaPassword1.Visible = True
                Return False
            Else
                lblValidaPassword1.Visible = False
            End If
        End If

        'Validación para evitar segunda Contrasena vacía
        If CInt(Session("UsuarioRealStatus")) <> 3 Then
            If Trim(txtVerificacionContrasena.Text) = "" Then
                lblValidaPassword2.Visible = True
                Return False
            Else
                lblValidaPassword2.Visible = False
            End If
        End If

        'Validación para evitar error en contrasena desigual
        If CInt(Session("UsuarioRealStatus")) <> 3 Then
            If Trim(txtContrasena.Text) <> Trim(txtVerificacionContrasena.Text) Then
                lblValidaPassword1.Visible = True
                lblValidaPassword2.Visible = True
                Return False
            Else
                lblValidaPassword1.Visible = False
                lblValidaPassword2.Visible = False
            End If
        End If

        'Si no hay problemas, regreso TRUE
        Return True

    End Function

    Function UsuariosReales_INSERT(ByVal Nombre As String, _
                                    ByVal Login As String, _
                                    ByVal Password As String, _
                                    ByVal idUsuarioVirtual As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "UsuariosReales_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'Nombre
            param = cmd.Parameters.Add("MyNombre", OleDbType.VarChar, 50)
            param.Value = Nombre

            'Login
            param = cmd.Parameters.Add("MyLogin", OleDbType.VarChar, 25)
            param.Value = Login

            'Password
            param = cmd.Parameters.Add("MyPassword", OleDbType.VarChar, 25)
            param.Value = Password

            'idUsuarioVirtual
            param = cmd.Parameters.Add("MyidUsuarioVirtual", OleDbType.Integer)
            param.Value = idUsuarioVirtual

            'IDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UsuariosReales_INSERT = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            UsuariosReales_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UsuariosReales_UPDATE(ByVal idUsuarioReal As Integer, _
                                ByVal Nombre As String, _
                                ByVal Login As String, _
                                ByVal Password As String, _
                                ByVal idUsuarioVirtual As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "UsuariosReales_UPDATE"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", OleDbType.Integer)
            param.Value = idUsuarioReal

            'Nombre
            param = cmd.Parameters.Add("MyNombre", OleDbType.VarChar, 50)
            param.Value = Nombre

            'Login
            param = cmd.Parameters.Add("MyLogin", OleDbType.VarChar, 25)
            param.Value = Login

            'Password
            param = cmd.Parameters.Add("MyPassword", OleDbType.VarChar, 25)
            param.Value = Password

            'idUsuarioVirtual
            param = cmd.Parameters.Add("MyidUsuarioVirtual", OleDbType.Integer)
            param.Value = idUsuarioVirtual

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UsuariosReales_UPDATE = idUsuarioReal

            cn.Close()

        Catch ex As Exception

            UsuariosReales_UPDATE = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UsuarioRealUnidadesAdministrativasRelaciones_DELETE(ByVal idUsuarioReal As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "UsuarioRealUnidadesAdministrativasRelaciones_DELETE"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", OleDbType.Integer)
            param.Value = idUsuarioReal

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UsuarioRealUnidadesAdministrativasRelaciones_DELETE = idUsuarioReal

            cn.Close()

        Catch ex As Exception

            UsuarioRealUnidadesAdministrativasRelaciones_DELETE = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UsuarioRealUnidadesAdministrativasRelaciones_INSERT( _
                                ByVal idUsuarioReal As Integer, _
                                ByVal idUnidadAdministrativa As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "UsuarioRealUnidadesAdministrativasRelaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", OleDbType.Integer)
            param.Value = idUsuarioReal

            'idUnidadAdministrativa
            param = cmd.Parameters.Add("MyidUnidadAdministrativa", OleDbType.Integer)
            param.Value = idUnidadAdministrativa

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UsuarioRealUnidadesAdministrativasRelaciones_INSERT = idUsuarioReal

            cn.Close()

        Catch ex As Exception

            UsuarioRealUnidadesAdministrativasRelaciones_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UsuariosReales_DELETE(ByVal idUsuarioReal As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "UsuariosReales_DELETE"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idUsuarioReal
            param = cmd.Parameters.Add("MyidUsuarioReal", OleDbType.Integer)
            param.Value = idUsuarioReal

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record
            UsuariosReales_DELETE = idUsuarioReal

            cn.Close()

        Catch ex As Exception

            UsuariosReales_DELETE = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Sub btnSalvar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSalvar.Click
        Dim MyID As Integer
        Dim scrambler As New GITDataTools.ScrambleNET

        If Not RevisaForma() Then
            Return
        End If

        If Session("UsuarioRealStatus") = 1 Then

            'Estoy agregando un nodo nuevo
            MyID = UsuariosReales_INSERT(Trim(txtNombre.Text), _
                                        Trim(txtLogin.Text), _
                                        Trim(scrambler.Scramble(txtContrasena.Text, Chr(25) & Chr(26))), _
                                        CInt(ddlstUsuarioVirtualAsociado.SelectedItem.Value))
            If MyID = 0 Then
                'Me arriesgo a suponer que la fuente del error es que ya existe el login o el nombre
                Beep()
                lblValidaNombre.Visible = True
                lblValidaLogin.Visible = True
                Return
            Else
                lblValidaNombre.Visible = False
                lblValidaLogin.Visible = False
            End If

            'También tengo que revisar los listboxes de ValorDocumental, 
            'Unidades Administrativas y Fundamentos Legales para generar  
            'en las tablas de relaciones, los records correspondientes a los checkmarks 

            'Unidades Administrativas Asociadas
            'Primero borro todas las relaciones anteriores (por si las hubiera) 
            If UsuarioRealUnidadesAdministrativasRelaciones_DELETE(MyID) <> MyID Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
            End If
            'Y ahora ingreso un record por cada checkmark
            For i As Integer = 0 To lbxUnidadesAdministrativas.Items.Count - 1
                If lbxUnidadesAdministrativas.Items(i).Selected Then
                    If UsuarioRealUnidadesAdministrativasRelaciones_INSERT(MyID, lbxUnidadesAdministrativas.Items(i).Value) <> MyID Then
                        'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                End If
            Next

            Session("idUsuarioRealEnEdicionActivo") = MyID
            FillUsuarioReal(CInt(Session("idUsuarioRealEnEdicionActivo")))

        ElseIf Session("UsuarioRealStatus") = 2 Then

            'Edito el usuario
            MyID = UsuariosReales_UPDATE(CInt(Session("idUsuarioRealEnEdicionActivo")), _
                                        Trim(txtNombre.Text), _
                                        Trim(txtLogin.Text), _
                                        Trim(scrambler.Scramble(txtContrasena.Text, Chr(25) & Chr(26))), _
                                        CInt(ddlstUsuarioVirtualAsociado.SelectedItem.Value))
            If MyID = 0 Then
                Beep()
                Return
            Else
                'También tengo que revisar los listboxes de ValorDocumental, 
                'Unidades Administrativas y Fundamentos Legales para generar  
                'en las tablas de relaciones, los records correspondientes a los checkmarks 

                'Unidades Administrativas Asociadas
                'Primero borro todas las relaciones anteriores (por si las hubiera) 
                If UsuarioRealUnidadesAdministrativasRelaciones_DELETE(CInt(Session("idUsuarioRealEnEdicionActivo"))) <> CInt(Session("idUsuarioRealEnEdicionActivo")) Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                End If
                'Y ahora ingreso un record por cada checkmark
                For i As Integer = 0 To lbxUnidadesAdministrativas.Items.Count - 1
                    If lbxUnidadesAdministrativas.Items(i).Selected Then
                        If UsuarioRealUnidadesAdministrativasRelaciones_INSERT(CInt(Session("idUsuarioRealEnEdicionActivo")), lbxUnidadesAdministrativas.Items(i).Value) <> CInt(Session("idUsuarioRealEnEdicionActivo")) Then
                            'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                    End If
                Next

                FillUsuarioReal(CInt(Session("idUsuarioRealEnEdicionActivo")))

            End If

        ElseIf Session("UsuarioRealStatus") = 3 Then

            'Borro el UsuarioReal (el sp borra tambien las unidades administrativas asociadas)
            If UsuariosReales_DELETE(CInt(Session("idUsuarioRealEnEdicionActivo"))) = 0 Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en UnidadesAdministrativasRelaciones")
            End If

            Session("UsuarioRealStatus") = 0

            MuestraStatus()

            btnSalvar.Text = "Salvar"
            'btnSalvar.Enabled = False
            'btnCancelar.Enabled = False
            'btnAgregar.Enabled = True
            'btnEditar.Enabled = True
            'btnBorrar.Enabled = True

            EnableDisableControlesDePropiedades(False)
            EnableDisableBotones(True)

            Response.Redirect("./UsuarioRealBuscar.aspx")

        End If

        Session("UsuarioRealStatus") = 0

        MuestraStatus()

        btnSalvar.Text = "Salvar"
        'btnSalvar.Enabled = False
        'btnCancelar.Enabled = False
        'btnAgregar.Enabled = True
        'btnEditar.Enabled = True
        'btnBorrar.Enabled = True

        EnableDisableControlesDePropiedades(False)
        EnableDisableBotones(True)

    End Sub

    Private Sub btnEditar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEditar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("UsuarioRealStatus") = 2
        MuestraStatus()

        EnableDisableControlesDePropiedades(True)

        EnableDisableBotones(False)
        'btnAgregar.Enabled = False
        'btnEditar.Enabled = False
        'btnBorrar.Enabled = False

    End Sub

    Private Sub btnBorrar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBorrar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("UsuarioRealStatus") = 3
        MuestraStatus()

        btnSalvar.Text = "Borrar"
        'btnSalvar.Enabled = True
        'btnCancelar.Enabled = True

        'btnAgregar.Enabled = False
        'btnEditar.Enabled = False
        'btnBorrar.Enabled = False

        EnableDisableControlesDePropiedades(False)
        EnableDisableBotones(False)

        'btnAgregar.Enabled = False
        'btnEditar.Enabled = False
        'btnBorrar.Enabled = False

        btnSalvar.Enabled = True
        btnCancelar.Enabled = True

    End Sub

    Private Sub btnRegresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRegresar.Click

        Session("UsuarioRealStatus") = 0
        Response.Redirect("./UsuarioRealBuscar.aspx")

    End Sub
End Class
