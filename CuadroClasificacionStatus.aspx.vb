Imports System.Data.OleDb

Public Class CuadroClasificacionStatus

    Inherits Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Label2 As Label
    Protected WithEvents lbxJerarquia As ListBox
    Protected WithEvents Label3 As Label
    Protected WithEvents Label1 As Label
    Protected WithEvents Label4 As Label
    Protected WithEvents txtCodigo As TextBox
    Protected WithEvents txtDescripcion As TextBox
    Protected WithEvents Label5 As Label
    Protected WithEvents Label6 As Label
    Protected WithEvents Label7 As Label
    Protected WithEvents ddlstTramite As DropDownList
    Protected WithEvents ddlstConcentracion As DropDownList
    Protected WithEvents lbxValorDocumental As ListBox
    Protected WithEvents Label37 As Label
    Protected WithEvents Label8 As Label
    Protected WithEvents Label9 As Label
    Protected WithEvents lbxFundamentosLegalesClasificacion As ListBox
    Protected WithEvents Label10 As Label
    Protected WithEvents ddlstStatus As DropDownList
    Protected WithEvents Label11 As Label
    Protected WithEvents Label12 As Label
    Protected WithEvents Label13 As Label
    Protected WithEvents lbxFundamentosLegalesDestinoFinal As ListBox
    Protected WithEvents ddlstDestinoFinal As DropDownList
    Protected WithEvents Label14 As Label
    Protected WithEvents lbxUnidadesAdministrativas As ListBox
    Protected WithEvents btnAgregar As Button
    Protected WithEvents btnEditar As Button
    Protected WithEvents btnBorrar As Button
    Protected WithEvents btnSalvar As Button
    Protected WithEvents btnCancelar As Button
    Protected WithEvents lblValidaCodigo As Label
    Protected WithEvents lblValidaDescripcion As Label
    Protected WithEvents lblCuadroClasificacionStatus As Label
    Protected WithEvents Label15 As Label

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

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("UsuarioRealStatus") = 0

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Select Case Session("CuadroClasificacionStatus")
            Case 0 'SOLO LECTURA
                'Label1.Text = Session("idCuadroClasificacionActivo")
                Label2.Text = Session("CodigoCompletoCuadroClasificacion")
                FillJerarquiaMenosElUltimo(Session("CodigoCompletoCuadroClasificacion"))
                FillCuadroClasificacion(Session("idCuadroClasificacionActivo"))
            Case 1 'AÑADIENDO

            Case 2 'EDITANDO
            Case 3 'BORRANDO

        End Select

        MuestraStatus()

    End Sub

    Sub MuestraStatus()

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Select Case Session("CuadroClasificacionStatus")
            Case 0  '0=SOLO LECTURA
                lblCuadroClasificacionStatus.Text = "(SÓLO LECTURA)"
                lblCuadroClasificacionStatus.ForeColor = Drawing.Color.Red
            Case 1  '1=AÑADIENDO
                lblCuadroClasificacionStatus.Text = "(EDITABLE)"
                lblCuadroClasificacionStatus.ForeColor = Drawing.Color.Green
            Case 2  '2=EDITANDO
                lblCuadroClasificacionStatus.Text = "(EDITABLE)"
                lblCuadroClasificacionStatus.ForeColor = Drawing.Color.Green
            Case 3  '3=BORRANDO
                lblCuadroClasificacionStatus.Text = "(SÓLO LECTURA)"
                lblCuadroClasificacionStatus.ForeColor = Drawing.Color.Red
        End Select

    End Sub

    Function FillJerarquiaMenosElUltimo(ByVal CodigoCompleto As String) As Boolean

        'Rutina para llenar el ListBox de Jeraraquía

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try

            lbxJerarquia.Items.Clear()

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "IDDeJerarquia"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'CodigoCompleto
            param = cmd.Parameters.Add("CodigoCompleto", Data.OleDb.OleDbType.VarChar, 250)
            param.Value = CodigoCompleto

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()
                    lbxJerarquia.Items.Insert(CInt(dr("orden")) - 1, CStr(dr("Nombre")) & " " & CStr(dr("Descripcion")))

                    'Aunque paso por aquí tantas veces como niveles tenga el código,
                    'estas variables se quedan con el valor del último nivel del código,
                    'que es precisamente el que me interesa para heredárselo al expediente
                    Session("idPlazoDeConservacionTramiteActivo") = CInt(dr("idPlazoDeConservacionTramite"))
                    Session("idPlazoDeConservacionConcentracionActivo") = CInt(dr("idPlazoDeConservacionConcentracion"))
                    Session("idDestinoFinalActivo") = CInt(dr("idDestinoFinal"))
                    Session("idInformacionClasificadaActivo") = CInt(dr("idInformacionClasificada"))
                    Session("idClasificacionActivo") = CInt(dr("idClasificacion"))
                End While

                'Quito el ultimo, porque es el que voy a editar
                lbxJerarquia.Items.Remove(lbxJerarquia.Items(lbxJerarquia.Items.Count - 1))

                FillJerarquiaMenosElUltimo = True
            Else
                FillJerarquiaMenosElUltimo = False
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            FillJerarquiaMenosElUltimo = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If
            'MsgBox(ex.Message.ToString)

        End Try

    End Function

    Function FillCuadroClasificacion(ByVal idCuadroClasificacion As Integer) As Boolean

        'Rutina para leer y llenar la forma con los datos de UN expediente

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try
            LimpiaCamposCuadroClasificacion()

            'Llenado de combos (sin escoger valor, por si no hay Expediente)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", -1)

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "ClasificacionStatus_SELECT_ONE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idCuadroClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idCuadroClasificacion

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()

                    Session("idCuadroClasificacionActivo") = idCuadroClasificacion
                    Session("HijosActivo") = CInt(dr("Hijos"))
                    Session("AfectableActivo") = CInt(dr("Afectable"))

                    txtCodigo.Text = CStr(dr("Nombre"))
                    txtDescripcion.Text = CStr(dr("Descripcion"))
                    Session("idPadre") = CInt(dr("idPadre"))
                    Label2.Text = MyNombreDeJerarquia(idCuadroClasificacion)

                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", CInt(dr("idInformacionClasificada")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", CInt(dr("idPlazoDeConservacionTramite")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", CInt(dr("idPlazoDeConservacionConcentracion")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", CInt(dr("idDestinoFinal")))

                End While

                'Me conviene leer los CheckListBoxes cada vez que cambio de nodo
                'porque aunque siempre son los mismos, el sp me ordena primero los que se utilizan
                'en este nodo

                'Fundamentos Legales de Clasificacion
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbxFundamentosLegalesClasificacion, "CargaFundamentosLegalesDeClasificacion", idCuadroClasificacion, "idFundamentosLegalesDeClasificacion", "Descripcion", "Activo")

                'Valor Documental
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbxValorDocumental, "CargaValorDocumental", idCuadroClasificacion, "idValorDocumental", "Descripcion", "Activo")

                'Fundamentos Legales De Destino Final
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbxFundamentosLegalesDestinoFinal, "CargaFundamentosLegalesDeDestinoFinal", idCuadroClasificacion, "idFundamentoLegalDeDestinoFinal", "Descripcion", "Activo")

                'Unidades Administrativas
                '********************************************************************
                'FillListBox2(Session("UsuarioVirtualConnString"), lbxUnidadesAdministrativas, "CargaUnidadesAdministrativas", idCuadroClasificacion, "idUnidadAdministrativa", "Descripcion", "Activo")
                FillListBox2(Session("UsuarioVirtualConnString"), lbxUnidadesAdministrativas, "CargaUnidadesAdministrativas", idCuadroClasificacion, "idUnidadAdministrativa", "NombreCorto", "Activo")

                FillCuadroClasificacion = True
            Else
                FillCuadroClasificacion = False
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            FillCuadroClasificacion = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Sub LimpiaCamposCuadroClasificacion()

        txtCodigo.Text = ""
        txtDescripcion.Text = ""

    End Sub

    'Rutina para cargar datos a un DropDownList.
    Public Shared Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As DropDownList, _
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

    'Sobrecarga de la rutina para cargar datos a un DropDownList. 
    'Incluye la posibilidad de pasar un parámetro al SP.
    Public Shared Sub FillDropDownList( _
                        ByVal ConnString As String, _
                        ByVal MyDropDownList As DropDownList, _
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

                    Dim MyListItem As New ListItem

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

    Sub EnableDisableControlesDePropiedades(ByVal valor As Boolean)

        'Habilita o desabilita los controles para ver/editar propiedades de los nodos

        txtCodigo.Enabled = valor
        txtDescripcion.Enabled = valor
        ddlstTramite.Enabled = valor
        ddlstConcentracion.Enabled = valor
        lbxValorDocumental.Enabled = valor
        ddlstStatus.Enabled = valor
        lbxFundamentosLegalesClasificacion.Enabled = valor
        ddlstDestinoFinal.Enabled = valor
        lbxFundamentosLegalesDestinoFinal.Enabled = valor
        lbxUnidadesAdministrativas.Enabled = valor
        btnSalvar.Enabled = valor
        btnCancelar.Enabled = valor

    End Sub

    Private Sub btnAgregar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAgregar.Click

        Session("CuadroClasificacionStatus") = 1
        MuestraStatus()
        Session("IDPadre") = Session("idCuadroClasificacionActivo")
        Label2.Text = Label2.Text & "."

        txtCodigo.Text = ""
        txtDescripcion.Text = ""

        EnableDisableControlesDePropiedades(True)

        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False

    End Sub

    Private Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("CuadroClasificacionStatus") = 0
        MuestraStatus()

        EnableDisableControlesDePropiedades(False)
        btnAgregar.Enabled = True
        btnEditar.Enabled = True
        btnBorrar.Enabled = True

        Response.Redirect("./CuadroClasificacionStatus.aspx")

    End Sub

    Function RevisaForma() As Boolean

        'Validación para evitar Codigo en blanco
        If Trim(txtCodigo.Text) = "" Then
            lblValidaCodigo.Visible = True
            Return False
        Else
            lblValidaCodigo.Visible = False
        End If

        'Validación para evitar Descripcion en blanco
        If Trim(txtDescripcion.Text) = "" Then
            lblValidaDescripcion.Visible = True
            Return False
        Else
            lblValidaDescripcion.Visible = False
        End If

        'Si no hay problemas, regreso TRUE
        Return True

    End Function

    Private Sub btnSalvar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSalvar.Click

        Dim MyID As Integer

        If Not RevisaForma() Then
            Return
        End If

        If Session("CuadroClasificacionStatus") = 1 Then

            'Estoy agregando un nodo nuevo
            MyID = CuadroClasificacion_Insert(CInt(Session("IDPadre")), _
                                                txtCodigo.Text, _
                                                txtDescripcion.Text, _
                                                CInt(ddlstTramite.SelectedItem.Value), _
                                                CInt(ddlstConcentracion.SelectedItem.Value), _
                                                CInt(ddlstDestinoFinal.SelectedItem.Value), _
                                                CInt(ddlstStatus.SelectedItem.Value))

            If MyID = 0 Then
                'Me arriesgo a suponer que la fuente del error es que ya existe el código para ese padre
                Beep()
                lblValidaCodigo.Visible = True
                Return
            Else
                lblValidaCodigo.Visible = False
            End If

            'También tengo que revisar los listboxes de ValorDocumental, 
            'Unidades Administrativas y Fundamentos Legales para generar  
            'en las tablas de relaciones, los records correspondientes a los checkmarks 

            'Valor Documental
            'Primero borro todas las relaciones anteriores (por si las hubiera) 
            If ValorDocumentalRelaciones_DELETE_ALL(MyID) <> MyID Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
            End If
            'Y ahora ingreso un record por cada checkmark
            For i As Integer = 0 To lbxValorDocumental.Items.Count - 1
                If lbxValorDocumental.Items(i).Selected Then
                    If ValorDocumentalRelaciones_INSERT(MyID, lbxValorDocumental.Items(i).Value) <> MyID Then
                        'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                End If
            Next

            'Fundamentos Legales de Clasificacion
            'Primero borro todas las relaciones anteriores (por si las hubiera) 
            If FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL(MyID) <> MyID Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
            End If
            'Y ahora ingreso un record por cada checkmark
            For i As Integer = 0 To lbxFundamentosLegalesClasificacion.Items.Count - 1
                If lbxFundamentosLegalesClasificacion.Items(i).Selected Then
                    If FundamentosLegalesDeClasificacionRelaciones_INSERT(MyID, lbxFundamentosLegalesClasificacion.Items(i).Value) <> MyID Then
                        'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                End If
            Next

            'Fundamentos Legales de Destino Final
            'Primero borro todas las relaciones anteriores (por si las hubiera) 
            If FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL(MyID) <> MyID Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
            End If
            'Y ahora ingreso un record por cada checkmark
            For i As Integer = 0 To lbxFundamentosLegalesDestinoFinal.Items.Count - 1
                If lbxFundamentosLegalesDestinoFinal.Items(i).Selected Then
                    If FundamentosLegalesDeDestinoFinalRelaciones_INSERT(MyID, lbxFundamentosLegalesDestinoFinal.Items(i).Value) <> MyID Then
                        'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                End If
            Next

            'Unidades Administrativas
            'Primero borro todas las relaciones anteriores (por si las hubiera) 
            If UnidadesAdministrativasRelaciones_DELETE_ALL(MyID) <> MyID Then
                'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
            End If
            'Y ahora ingreso un record por cada checkmark
            For i As Integer = 0 To lbxUnidadesAdministrativas.Items.Count - 1
                If lbxUnidadesAdministrativas.Items(i).Selected Then
                    If UnidadesAdministrativasRelaciones_INSERT(MyID, lbxUnidadesAdministrativas.Items(i).Value) <> MyID Then
                        'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                End If
            Next

            Session("idCuadroClasificacionActivo") = MyID
            Session("CodigoCompletoCuadroClasificacion") = Session("CodigoCompletoCuadroClasificacion") & "." & txtCodigo.Text

            Label2.Text = Session("CodigoCompletoCuadroClasificacion")
            FillJerarquiaMenosElUltimo(Session("CodigoCompletoCuadroClasificacion"))
            FillCuadroClasificacion(Session("idCuadroClasificacionActivo"))


        ElseIf Session("CuadroClasificacionStatus") = 2 Then

            'Edito el Cuadro de Clasificacion
            MyID = CuadroClasificacion_Update(CInt(Session("idCuadroClasificacionActivo")), _
                                            CInt(Session("idPadre")), _
                                            txtCodigo.Text, _
                                            txtDescripcion.Text, _
                                            CInt(ddlstTramite.SelectedItem.Value), _
                                            CInt(ddlstConcentracion.SelectedItem.Value), _
                                            CInt(ddlstDestinoFinal.SelectedItem.Value), _
                                            CInt(ddlstStatus.SelectedItem.Value))
            If MyID = 0 Then
                Beep()
                Return
            Else
                'También tengo que revisar los listboxes de ValorDocumental, 
                'Unidades Administrativas y Fundamentos Legales para generar  
                'en las tablas de relaciones, los records correspondientes a los checkmarks 

                'Valor Documental
                'Primero borro todas las relaciones anteriores (por si las hubiera) 
                If ValorDocumentalRelaciones_DELETE_ALL(MyID) <> MyID Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                End If
                'Y ahora ingreso un record por cada checkmark
                For i As Integer = 0 To lbxValorDocumental.Items.Count - 1
                    If lbxValorDocumental.Items(i).Selected Then
                        If ValorDocumentalRelaciones_INSERT(MyID, lbxValorDocumental.Items(i).Value) <> MyID Then
                            'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                    End If
                Next

                'Fundamentos Legales de Clasificacion
                'Primero borro todas las relaciones anteriores (por si las hubiera) 
                If FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL(MyID) <> MyID Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                End If
                'Y ahora ingreso un record por cada checkmark
                For i As Integer = 0 To lbxFundamentosLegalesClasificacion.Items.Count - 1
                    If lbxFundamentosLegalesClasificacion.Items(i).Selected Then
                        If FundamentosLegalesDeClasificacionRelaciones_INSERT(MyID, lbxFundamentosLegalesClasificacion.Items(i).Value) <> MyID Then
                            'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                    End If
                Next

                'Fundamentos Legales de Destino Final
                'Primero borro todas las relaciones anteriores (por si las hubiera) 
                If FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL(MyID) <> MyID Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                End If
                'Y ahora ingreso un record por cada checkmark
                For i As Integer = 0 To lbxFundamentosLegalesDestinoFinal.Items.Count - 1
                    If lbxFundamentosLegalesDestinoFinal.Items(i).Selected Then
                        If FundamentosLegalesDeDestinoFinalRelaciones_INSERT(MyID, lbxFundamentosLegalesDestinoFinal.Items(i).Value) <> MyID Then
                            'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                    End If
                Next

                'Unidades Administrativas
                'Primero borro todas las relaciones anteriores (por si las hubiera) 
                If UnidadesAdministrativasRelaciones_DELETE_ALL(MyID) <> MyID Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                End If
                'Y ahora ingreso un record por cada checkmark
                For i As Integer = 0 To lbxUnidadesAdministrativas.Items.Count - 1
                    If lbxUnidadesAdministrativas.Items(i).Selected Then
                        If UnidadesAdministrativasRelaciones_INSERT(MyID, lbxUnidadesAdministrativas.Items(i).Value) <> MyID Then
                            'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                    End If
                Next

                FillCuadroClasificacion(Session("idCuadroClasificacionActivo"))

            End If

        ElseIf Session("CuadroClasificacionStatus") = 3 Then
            If CInt(Session("HijosActivo")) > 0 Then
                'Si el nodo tiene hijos, no lo puedo borrar
                Beep()
                'Return
            Else

                'Extraigo el idClasificacion del nodo a borrar
                MyID = Session("idCuadroClasificacionActivo")

                'Borro las relaciones a FundamentosLegalesDeClasificacion que pudieran existir
                If FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL(MyID) = 0 Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeClasificacionRelaciones")
                End If

                'Borro las relaciones a FundamentosLegalesDeDestinoFinal que pudieran existir
                If FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL(MyID) = 0 Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeDestinoFinalRelaciones")
                End If

                'Borro las relaciones a ValorDocumental que pudieran existir
                If ValorDocumentalRelaciones_DELETE_ALL(MyID) = 0 Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumentalRelaciones")
                End If

                'Borro las relaciones a UnidadesAdministrativas que pudieran existir
                If UnidadesAdministrativasRelaciones_DELETE_ALL(MyID) = 0 Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en UnidadesAdministrativasRelaciones")
                End If

                'Trato de borrar la clasificación
                If CuadroClasificacion_Delete(MyID) = 0 Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en UnidadesAdministrativasRelaciones")
                End If

                Session("CuadroClasificacionStatus") = 0

                MuestraStatus()

                btnSalvar.Text = "Salvar"
                btnSalvar.Enabled = False
                btnCancelar.Enabled = False
                btnAgregar.Enabled = True
                btnEditar.Enabled = True
                btnBorrar.Enabled = True

                EnableDisableControlesDePropiedades(False)
                Response.Redirect("./CuadroClasificacion.aspx")

            End If
        End If

        Session("CuadroClasificacionStatus") = 0

        MuestraStatus()

        btnSalvar.Text = "Salvar"
        btnSalvar.Enabled = False
        btnCancelar.Enabled = False
        btnAgregar.Enabled = True
        btnEditar.Enabled = True
        btnBorrar.Enabled = True

        EnableDisableControlesDePropiedades(False)


    End Sub

    Function CuadroClasificacion_Delete(ByVal idClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "CuadroClasificacion_DELETE"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'IDCuenta
            param = cmd.Parameters.Add("MyIDCuenta", OleDbType.Integer)
            param.Value = idClasificacion

            'MyIDBorrado
            param = cmd.Parameters.Add("MyIDBorrado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            CuadroClasificacion_Delete = CInt(cmd.Parameters("MyIDBorrado").Value)

            cn.Close()
        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            CuadroClasificacion_Delete = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Public Function CuadroClasificacion_Update(ByVal idClasificacion As Integer, _
                                            ByVal idPadre As Integer, _
                                            ByVal Nombre As String, _
                                            ByVal Descripcion As String, _
                                            ByVal idPlazoDeConservacionTramite As Integer, _
                                            ByVal idPlazoDeConservacionConcentracion As Integer, _
                                            ByVal idDestinoFinal As Integer, _
                                            ByVal idInformacionClasificada As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Cursor.Current = Cursors.WaitCursor

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "CuadroClasificacion_UPDATE"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'IDClasificacion
            param = cmd.Parameters.Add("MyIDClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'IDPadre
            param = cmd.Parameters.Add("MyIDPadre", OleDbType.Integer)
            param.Value = idPadre

            'Nombre
            param = cmd.Parameters.Add("MyNombre", OleDbType.VarChar, 50)
            param.Value = Nombre

            'Descripcion
            param = cmd.Parameters.Add("MyDescripcion", OleDbType.VarChar, 250)
            param.Value = Descripcion

            'idPlazoDeConservacionTramite
            param = cmd.Parameters.Add("MyidPlazoDeConservacionTramite", OleDbType.Integer)
            param.Value = idPlazoDeConservacionTramite

            'idPlazoDeConservacionConcentracion
            param = cmd.Parameters.Add("MyidPlazoDeConservacionConcentracion", OleDbType.Integer)
            param.Value = idPlazoDeConservacionConcentracion

            'idDestinoFinal
            param = cmd.Parameters.Add("MyidDestinoFinal", OleDbType.Integer)
            param.Value = idDestinoFinal

            'idInformacionClasificada
            param = cmd.Parameters.Add("MyidInformacionClasificada", OleDbType.Integer)
            param.Value = idInformacionClasificada

            'idIDEditado
            param = cmd.Parameters.Add("MyidIDEditado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            CuadroClasificacion_Update = CInt(cmd.Parameters("MyidIDEditado").Value)

            cn.Close()

        Catch ex As Exception

            'Cursor.Current = Cursors.Default
            'MsgBox(ex.Message.ToString)
            CuadroClasificacion_Update = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function MyNombreDeJerarquia(ByVal idClasificacion As Integer) As String
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "SELECT Nomenclatura = dbo.fnNombreDeJerarquia(" & CStr(idClasificacion) & ")"
            cmd.Connection = cn
            cmd.CommandType = CommandType.Text

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()
                    MyNombreDeJerarquia = dr("Nomenclatura")
                End While
            End If

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            MyNombreDeJerarquia = ""
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UnidadesAdministrativasRelaciones_INSERT(ByVal idClasificacion As Integer, ByVal idUnidadAdministrativa As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "UnidadesAdministrativasRelaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idUnidadAdministrativa
            param = cmd.Parameters.Add("MyidUnidadAdministrativa", OleDbType.Integer)
            param.Value = idUnidadAdministrativa

            'IDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UnidadesAdministrativasRelaciones_INSERT = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            UnidadesAdministrativasRelaciones_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function UnidadesAdministrativasRelaciones_DELETE_ALL(ByVal idClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "UnidadesAdministrativasRelaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idClasificacionBorrado
            param = cmd.Parameters.Add("MyidClasificacionBorrado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            UnidadesAdministrativasRelaciones_DELETE_ALL = CInt(cmd.Parameters("MyidClasificacionBorrado").Value)

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            UnidadesAdministrativasRelaciones_DELETE_ALL = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeDestinoFinalRelaciones_INSERT(ByVal idClasificacion As Integer, ByVal idFundamentoLegalDeDestinoFinal As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeDestinoFinalRelaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idFundamentoLegalDeDestinoFinal
            param = cmd.Parameters.Add("MyidValorDocumental", OleDbType.Integer)
            param.Value = idFundamentoLegalDeDestinoFinal

            'IDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeDestinoFinalRelaciones_INSERT = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeDestinoFinalRelaciones_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL(ByVal idClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idClasificacionBorrado
            param = cmd.Parameters.Add("MyidClasificacionBorrado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL = CInt(cmd.Parameters("MyidClasificacionBorrado").Value)

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeDestinoFinalRelaciones_DELETE_ALL = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeClasificacionRelaciones_INSERT(ByVal idClasificacion As Integer, ByVal idFundamentosLegalesDeClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeClasificacionRelaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idFundamentosLegalesDeClasificacion
            param = cmd.Parameters.Add("MyidFundamentosLegalesDeClasificacion", OleDbType.Integer)
            param.Value = idFundamentosLegalesDeClasificacion

            'IDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeClasificacionRelaciones_INSERT = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeClasificacionRelaciones_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL(ByVal idClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idClasificacionBorrado
            param = cmd.Parameters.Add("MyidClasificacionBorrado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL = CInt(cmd.Parameters("MyidClasificacionBorrado").Value)

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeClasificacionRelaciones_DELETE_ALL = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function ValorDocumentalRelaciones_INSERT(ByVal idClasificacion As Integer, ByVal idValorDocumental As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "ValorDocumentalRelaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idValorDocumental
            param = cmd.Parameters.Add("MyidValorDocumental", OleDbType.Integer)
            param.Value = idValorDocumental

            'IDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            ValorDocumentalRelaciones_INSERT = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            ValorDocumentalRelaciones_INSERT = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function ValorDocumentalRelaciones_DELETE_ALL(ByVal idClasificacion As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "ValorDocumentalRelaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("MyidClasificacion", OleDbType.Integer)
            param.Value = idClasificacion

            'idClasificacionBorrado
            param = cmd.Parameters.Add("MyidClasificacionBorrado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            ValorDocumentalRelaciones_DELETE_ALL = CInt(cmd.Parameters("MyidClasificacionBorrado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            ValorDocumentalRelaciones_DELETE_ALL = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function CuadroClasificacion_Insert(ByVal idPadre As Integer, _
                                            ByVal Nombre As String, _
                                            ByVal Descripcion As String, _
                                            ByVal idPlazoDeConservacionTramite As Integer, _
                                            ByVal idPlazoDeConservacionConcentracion As Integer, _
                                            ByVal idDestinoFinal As Integer, _
                                            ByVal idInformacionClasificada As Integer) As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter

        Try
            'Cursor.Current = Cursors.WaitCursor

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "CuadroClasificacion_INSERT"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            'IDPadre
            param = cmd.Parameters.Add("MyIDPadre", OleDbType.Integer)
            param.Value = idPadre

            'Nombre
            param = cmd.Parameters.Add("MyNombre", OleDbType.VarChar, 50)
            param.Value = Nombre

            'Descripcion
            param = cmd.Parameters.Add("MyDescripcion", OleDbType.VarChar, 250)
            param.Value = Descripcion

            'idPlazoDeConservacionTramite
            param = cmd.Parameters.Add("MyidPlazoDeConservacionTramite", OleDbType.Integer)
            param.Value = idPlazoDeConservacionTramite

            'idPlazoDeConservacionConcentracion
            param = cmd.Parameters.Add("MyidPlazoDeConservacionConcentracion", OleDbType.Integer)
            param.Value = idPlazoDeConservacionConcentracion

            'idDestinoFinal
            param = cmd.Parameters.Add("MyidDestinoFinal", OleDbType.Integer)
            param.Value = idDestinoFinal

            'idInformacionClasificada
            param = cmd.Parameters.Add("MyidInformacionClasificada", OleDbType.Integer)
            param.Value = idInformacionClasificada

            'idIDInsertado
            param = cmd.Parameters.Add("MyIDInsertado", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            CuadroClasificacion_Insert = CInt(cmd.Parameters("MyIDInsertado").Value)

            cn.Close()
            'Cursor.Current = Cursors.Default

        Catch ex As Exception

            'Cursor.Current = Cursors.Default
            'MsgBox(ex.Message.ToString)
            CuadroClasificacion_Insert = 0
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Sub btnEditar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEditar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("CuadroClasificacionStatus") = 2
        MuestraStatus()

        EnableDisableControlesDePropiedades(True)

        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False

    End Sub

    Private Sub btnBorrar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBorrar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("CuadroClasificacionStatus") = 3
        MuestraStatus()

        btnSalvar.Text = "Borrar"
        btnSalvar.Enabled = True
        btnCancelar.Enabled = True
        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False

        EnableDisableControlesDePropiedades(False)

        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False
        btnSalvar.Enabled = True
        btnCancelar.Enabled = True


    End Sub
End Class
