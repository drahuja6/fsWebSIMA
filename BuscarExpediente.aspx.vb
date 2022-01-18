Imports System.Data.OleDb

Public Class BuscarExpediente
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents lbUnidAdmin As System.Web.UI.WebControls.ListBox
    Protected WithEvents lblCodigo As System.Web.UI.WebControls.Label
    Protected WithEvents txtCodigo As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFApertInic As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtFApertFinal As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents Label7 As System.Web.UI.WebControls.Label
    Protected WithEvents txtExpInic As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtExpFinal As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label8 As System.Web.UI.WebControls.Label
    Protected WithEvents txtCaractExclu As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label9 As System.Web.UI.WebControls.Label
    Protected WithEvents txtTipo As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label10 As System.Web.UI.WebControls.Label
    Protected WithEvents txtRFC As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label11 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNombre As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label12 As System.Web.UI.WebControls.Label
    Protected WithEvents txtCaja As System.Web.UI.WebControls.TextBox
    Protected WithEvents cbBusqExacta As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Button1 As System.Web.UI.WebControls.Button
    Protected WithEvents RegularExpressionValidator1 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents RegularExpressionValidator2 As System.Web.UI.WebControls.RegularExpressionValidator
    Protected WithEvents Panel1 As System.Web.UI.WebControls.Panel
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents NoHayDatos As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents txtRelAnt As System.Web.UI.WebControls.TextBox
    Protected WithEvents btnImprimeGuiaDeExpedientes As System.Web.UI.WebControls.Button
    Protected WithEvents btnImprimeListadoDeExpedientes As System.Web.UI.WebControls.Button
    Protected WithEvents btnImprimeCaratulas As System.Web.UI.WebControls.Button
    Protected WithEvents btnCaratulasNoCredito As System.Web.UI.WebControls.Button
    Protected WithEvents btnEtiquetas As System.Web.UI.WebControls.Button
    Protected WithEvents btnLomos As System.Web.UI.WebControls.Button
    Protected WithEvents btnVencidosTramite As System.Web.UI.WebControls.Button
    Protected WithEvents btnExpedientesActivos As System.Web.UI.WebControls.Button
    Protected WithEvents btnEnTraspasoAConcentracion As System.Web.UI.WebControls.Button
    Protected WithEvents btnVigentesConcentracion As System.Web.UI.WebControls.Button
    Protected WithEvents btnVencidosConcentracion As System.Web.UI.WebControls.Button
    Protected WithEvents btnEnArchivoHistorico As System.Web.UI.WebControls.Button
    Protected WithEvents btnExpedientesDadosDeBaja As System.Web.UI.WebControls.Button
    Protected WithEvents RadioButtonPDF As System.Web.UI.WebControls.RadioButton
    Protected WithEvents RadioButtonXLS As System.Web.UI.WebControls.RadioButton
    Protected WithEvents Label13 As System.Web.UI.WebControls.Label
    Protected WithEvents Label14 As System.Web.UI.WebControls.Label
    Protected WithEvents txtLimite As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtReal As System.Web.UI.WebControls.TextBox
    Protected WithEvents lblLimiteExcedido As System.Web.UI.WebControls.Label
    Protected WithEvents Label15 As System.Web.UI.WebControls.Label
    Protected WithEvents txtUbicTr As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtAnaqTr As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label16 As System.Web.UI.WebControls.Label
    Protected WithEvents txtObsTr As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label17 As System.Web.UI.WebControls.Label

    'NOTA: el Diseñador de Web Forms necesita la siguiente declaración del marcador de posición.
    'No se debe eliminar o mover.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: el Diseñador de Web Forms requiere esta llamada de método
        'No la modifique con el editor de código.
        InitializeComponent()
    End Sub

#End Region

    'Clase para contener los parámetros que se pasarán al SP de búsqueda de expedientes
    Public Class SQLParameters
        Public Codigo As String
        Public Expediente As String
        Public ExpedienteFinal As String
        Public Tipo As String
        Public RFC As String
        Public Asunto As String
        Public Cajas As String
        Public FechaInicial As Date
        Public FechaFinal As Date
        Public RelacionAnterior As String
        Public CajaAnterior As String
        Public ItemAnterior As String
        Public CampoAdicional3 As String
    End Class

    Dim ProcessedRecords As Integer = 0

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then
            FillListBox(lbUnidAdmin, Session("UsuarioVirtualConnString"), "UnidadesAdministrativasDeUnUsuarioReal", Session("IDUsuarioReal"), "NombreCorto", "idUnidadAdministrativa")
            lbUnidAdmin.SelectedIndex = 0
            txtLimite.Text = CStr(Session("LimiteDeRecordsEnBusqueda"))
        Else
            If Trim(txtLimite.Text) = "" Or Not IsNumeric(txtLimite.Text) Then
                txtLimite.Text = "50"
                Session("LimiteDeRecordsEnBusqueda") = CInt(txtLimite.Text)
            End If
        End If

    End Sub

    'Rutina para cargar un listbox.
    Public Sub FillListBox( _
                                ByVal MyListBox As ListBox, _
                                ByVal ConnString As String, _
                                ByVal StoredProcedure As String, _
                                ByVal idParameter As Integer, _
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

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        If Page.IsValid Then

            Session("LimiteDeRecordsEnBusqueda") = CInt(txtLimite.Text)
            txtReal.Text = CuentaRecords()

            DataGrid1.Visible = False
            NoHayDatos.Visible = False

            btnImprimeGuiaDeExpedientes.Enabled = False
            btnImprimeListadoDeExpedientes.Enabled = False
            btnImprimeCaratulas.Enabled = False
            btnCaratulasNoCredito.Enabled = False
            btnEtiquetas.Enabled = False
            btnLomos.Enabled = False

            btnExpedientesActivos.Enabled = False
            btnVencidosTramite.Enabled = False
            btnEnTraspasoAConcentracion.Enabled = False
            btnVigentesConcentracion.Enabled = False
            btnVencidosConcentracion.Enabled = False
            btnEnArchivoHistorico.Enabled = False
            btnExpedientesDadosDeBaja.Enabled = False
            RadioButtonPDF.Enabled = False
            RadioButtonXLS.Enabled = False

            'If Trim(txtLimite.Text) = "" Or Not IsNumeric(txtLimite.Text) Then
            '    txtLimite.Text = "50"
            '    Session("LimiteDeRecordsEnBusqueda") = CInt(txtLimite.Text)
            'End If

            If CInt(txtReal.Text) > CInt(txtLimite.Text) Then
                lblLimiteExcedido.Visible = True
            Else
                lblLimiteExcedido.Visible = False
                LlenaGrid()
            End If
        End If
    End Sub

    Sub LlenaGrid()

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsExpedientes As New Data.DataSet
        Dim MiOperador As String
        Dim MiLista As String
        Dim MiCondicionAux As String
        Dim MiCondicion As String = ""
        Dim SQLString As String
        Dim HayRangoDeExpedientes As Boolean

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure
        cmd.CommandText = "Expedientes_BUSCA_WEB"
        cmd.Connection = cn
        cmd.CommandType = Data.CommandType.StoredProcedure

        MiOperador = CStr(IIf(Not cbBusqExacta.Checked, " LIKE ", " = "))

        'Unidades Administrativas
        MiLista = ""
        Dim item As ListItem
        For Each item In lbUnidAdmin.Items
            If item.Selected Then
                If MiLista <> "" Then
                    MiLista = MiLista & "," & CStr(item.Value)
                Else
                    MiLista = CStr(item.Value)
                End If
            End If
        Next

        If MiLista <> "" Then
            MiCondicionAux = ""
            MiCondicionAux = " e.idUnidadAdministrativa IN (" & MiLista & ") "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
            'Else
            '    Throw New ApplicationException("Debe escoger al menos una unidad administrativa")
        End If

        'Codigo
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtCodigo.Text) <> "", "dbo.fnNombreDeJerarquia(e.idClasificacion) " & MiOperador & " @Codigo ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Nombre (de expediente)
        HayRangoDeExpedientes = False
        If Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) <> "" Then
            'Rango de expedientes
            HayRangoDeExpedientes = True
            MiCondicionAux = " e.Nombre >=  @Expediente AND e.Nombre <= @ExpedienteFinal "
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        ElseIf Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) = "" Then
            'Condición normal para LIKE, usando txtExpediente
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtExpInic.Text) <> "", " e.Nombre " & MiOperador & " @Expediente ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtExpInic.Text) = "" And Trim(txtExpFinal.Text) <> "" Then
            'Condición normal para LIKE, usando txtExpedienteFinal
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtExpFinal.Text) <> "", " e.Nombre " & MiOperador & " @ExpedienteFinal ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        Else
            'No hay rango de expedientes
        End If

        'Caracteres excluídos
        MiCondicionAux = CondicionDeCaracteresExcluidos(txtCaractExclu.Text)
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Ref
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtTipo.Text) <> "", " e.CampoAdicional2 " & MiOperador & " @Tipo ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'RFC
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtRFC.Text) <> "", " e.CampoAdicional1 " & MiOperador & " @RFC ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Asunto
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtNombre.Text) <> "", " e.Asunto " & MiOperador & " @Asunto ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'CajaC
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtCaja.Text) <> "", " e.Caja " & MiOperador & " @Caja ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'CajaTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtRelAnt.Text) <> "", " e.RelacionAnterior " & MiOperador & " @RelacionAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'AnaqTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtAnaqTr.Text) <> "", " e.CajaAnterior " & MiOperador & " @CajaAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'UbicTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtUbicTr.Text) <> "", " e.ItemAnterior " & MiOperador & " @ItemAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'ObsTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtObsTr.Text) <> "", " e.CampoAdicional3 " & MiOperador & " @CampoAdicional3 ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        If Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) <> "" Then
            'Rango normal entre dos fechas
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura BETWEEN @FechaInicial AND @FechaFinal "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) = "" Then
            'A partir de una fecha hacia adelante
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura >= @FechaInicial "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtFApertInic.Text) = "" And Trim(txtFApertFinal.Text) <> "" Then
            'A partir de una fecha hacia atrás
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura <= @FechaFinal "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        Else
            'No hay rango de fechas
        End If

        'SQLString
        SQLString = _
            "SELECT dbo.fnNombreDeJerarquia(e.idClasificacion) as Codigo, " & _
            "e.idExpediente, " & _
            "e.Nombre as Expediente, " & _
            "e.CampoAdicional2  as Tipo, " & _
            "e.CampoAdicional1  as RFC, " & _
            "e.Asunto, " & _
            "e.RelacionAnterior as CajaT, " & _
            "e.Caja, " & _
            "CONVERT(varchar(10),e.FechaApertura,103) as [F.Apertura], " & _
            "[F.Cierre] = CASE WHEN (FechaCierreChecked = 1) THEN CONVERT(CHAR(10), e.FechaCierre, 103) ELSE '' END, " & _
            "ua.NombreCorto " & _
            "FROM Expedientes e " & _
            "JOIN UnidadesAdministrativas ua ON e.idUnidadAdministrativa = ua.idUnidadAdministrativa " & _
            CStr(IIf(MiCondicion <> "", " WHERE " & MiCondicion, ""))

        'Cierre = CASE WHEN (FechaCierreChecked = 1) THEN CONVERT(CHAR(10), e.FechaCierre, 103) ELSE '' END,
        '"CONVERT(varchar(10),e.FechaCierre,103) as [F.Cierre], " & _


        'Si llego aquí y no hay siquiera un WHERE, lo pongo ahora y con una condición imposible,
        'para que no devuelva nada
        SQLString = SQLString & CStr(IIf(InStr(UCase(SQLString), "WHERE") > 0, "", " WHERE idExpediente < -1000"))

        SQLString = SQLString & " ORDER BY " & Session("OrdenDeGridDeExpedientes")
        'SQLString = SQLString & " ORDER BY e.Nombre "

        'MySQLString = "SELECT * FROM Expedientes"

        param = cmd.Parameters.Add("SQLString", Data.OleDb.OleDbType.VarChar, 4000)
        param.Value = SQLString

        'Codigo
        param = cmd.Parameters.Add("Codigo", Data.OleDb.OleDbType.VarChar, 50)
        If cbBusqExacta.Checked Then
            param.Value = txtCodigo.Text
        Else
            param.Value = IIf(Trim(txtCodigo.Text) <> "", "%" & Trim(txtCodigo.Text) & "%", "%")
        End If

        'Expediente
        param = cmd.Parameters.Add("Expediente", Data.OleDb.OleDbType.VarChar, 50)
        If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
            param.Value = txtExpInic.Text
        Else
            param.Value = IIf(Trim(txtExpInic.Text) <> "", "%" & Trim(txtExpInic.Text) & "%", "%")
        End If

        'ExpedienteFinal
        param = cmd.Parameters.Add("ExpedienteFinal", Data.OleDb.OleDbType.VarChar, 50)
        If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
            param.Value = txtExpFinal.Text
        Else
            param.Value = IIf(Trim(txtExpFinal.Text) <> "", "%" & Trim(txtExpFinal.Text) & "%", "%")
        End If

        'Tipo 
        param = cmd.Parameters.Add("Tipo", Data.OleDb.OleDbType.VarChar, 50)
        If cbBusqExacta.Checked Then
            param.Value = txtTipo.Text
        Else
            param.Value = IIf(Trim(txtTipo.Text) <> "", "%" & Trim(txtTipo.Text) & "%", "%")
        End If

        'RFC
        param = cmd.Parameters.Add("RFC", Data.OleDb.OleDbType.VarChar, 50)
        If cbBusqExacta.Checked Then
            param.Value = txtRFC.Text
        Else
            param.Value = IIf(Trim(txtRFC.Text) <> "", "%" & Trim(txtRFC.Text) & "%", "%")
        End If

        'Asunto
        param = cmd.Parameters.Add("Asunto", Data.OleDb.OleDbType.VarChar, 250)
        If cbBusqExacta.Checked Then
            param.Value = txtNombre.Text
        Else
            param.Value = IIf(Trim(txtNombre.Text) <> "", "%" & Trim(txtNombre.Text) & "%", "%")
        End If

        'CajaC
        param = cmd.Parameters.Add("Caja", Data.OleDb.OleDbType.VarChar, 250)
        If cbBusqExacta.Checked Then
            param.Value = txtCaja.Text
        Else
            param.Value = IIf(Trim(txtCaja.Text) <> "", "%" & Trim(txtCaja.Text) & "%", "%")
        End If

        'CajaTr
        param = cmd.Parameters.Add("RelacionAnterior", Data.OleDb.OleDbType.VarChar, 250)
        If cbBusqExacta.Checked Then
            param.Value = txtRelAnt.Text
        Else
            param.Value = IIf(Trim(txtRelAnt.Text) <> "", "%" & Trim(txtRelAnt.Text) & "%", "%")
        End If

        'AnaqTr
        param = cmd.Parameters.Add("AnaqTr", Data.OleDb.OleDbType.VarChar, 25)
        If cbBusqExacta.Checked Then
            param.Value = txtAnaqTr.Text
        Else
            param.Value = IIf(Trim(txtAnaqTr.Text) <> "", "%" & Trim(txtAnaqTr.Text) & "%", "%")
        End If

        'UbicTr
        param = cmd.Parameters.Add("UbicTr", Data.OleDb.OleDbType.VarChar, 25)
        If cbBusqExacta.Checked Then
            param.Value = txtUbicTr.Text
        Else
            param.Value = IIf(Trim(txtUbicTr.Text) <> "", "%" & Trim(txtUbicTr.Text) & "%", "%")
        End If

        'ObsTr
        param = cmd.Parameters.Add("ObsTr", Data.OleDb.OleDbType.VarChar, 25)
        If cbBusqExacta.Checked Then
            param.Value = txtObsTr.Text
        Else
            param.Value = IIf(Trim(txtObsTr.Text) <> "", "%" & Trim(txtObsTr.Text) & "%", "%")
        End If

        'Le tengo que pasar los dos parámetros de fecha, aunque no los use. 
        'Si no los uso, no aparecen en la cadena SQL generada.

        'Fecha de Apertura inicial
        param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            param.Value = CDate("1/1/2000")
        Else
            param.Value = CDate(Trim(txtFApertInic.Text))
        End If

        'Fecha de Apertura final
        param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.DBDate)
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            param.Value = CDate("1/1/2000")
        Else
            param.Value = CDate(Trim(txtFApertFinal.Text))
        End If

        'Creo el objeto DataAdapter
        Dim daExpedientes As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daExpedientes.Fill(dsExpedientes, "Expedientes")
        dsExpedientes.Tables("Expedientes").Rows.Clear()
        daExpedientes.Fill(dsExpedientes, "Expedientes")

        If dsExpedientes.Tables(0).Rows.Count = 0 Then
            DataGrid1.Visible = False
            NoHayDatos.Visible = True

            btnImprimeGuiaDeExpedientes.Enabled = False
            btnImprimeListadoDeExpedientes.Enabled = False
            btnImprimeCaratulas.Enabled = False
            btnCaratulasNoCredito.Enabled = False
            btnEtiquetas.Enabled = False
            btnLomos.Enabled = False

            btnExpedientesActivos.Enabled = False
            btnVencidosTramite.Enabled = False
            btnEnTraspasoAConcentracion.Enabled = False
            btnVigentesConcentracion.Enabled = False
            btnVencidosConcentracion.Enabled = False
            btnEnArchivoHistorico.Enabled = False
            btnExpedientesDadosDeBaja.Enabled = False
            RadioButtonPDF.Enabled = False
            RadioButtonXLS.Enabled = False

        Else
            DataGrid1.Visible = True
            NoHayDatos.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            DataGrid1.DataSource = dsExpedientes

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            DataGrid1.DataMember = "Expedientes"
            DataGrid1.DataKeyField = "idExpediente"
            'GridView1.DataKeyNames(0) = "idExpediente"
            DataGrid1.DataBind()


            btnImprimeGuiaDeExpedientes.Enabled = True
            btnImprimeListadoDeExpedientes.Enabled = True
            btnImprimeCaratulas.Enabled = True
            btnCaratulasNoCredito.Enabled = True
            btnEtiquetas.Enabled = True
            btnLomos.Enabled = True

            btnExpedientesActivos.Enabled = True
            btnVencidosTramite.Enabled = True
            btnEnTraspasoAConcentracion.Enabled = True
            btnVigentesConcentracion.Enabled = True
            btnVencidosConcentracion.Enabled = True
            btnEnArchivoHistorico.Enabled = True
            btnExpedientesDadosDeBaja.Enabled = True
            RadioButtonPDF.Enabled = True
            RadioButtonXLS.Enabled = True

        End If

        'Cierro la colección de parámetros y la conexión
        cmd.Parameters.Clear()

    End Sub

    Private Function CuentaRecords() As Integer

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim SQLString As String = ""
        Dim MiOperador As String = ""
        Dim MiCondicion As String = ""
        Dim MiCondicionAux As String = ""
        Dim MiLista As String = ""
        Dim HayRangoDeExpedientes As Boolean = False

        Try
            'Cursor.Current = Cursors.WaitCursor
            'Application.DoEvents()

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Expedientes_CUENTA_WEB"
            cmd.Connection = cn
            cmd.CommandType = CommandType.StoredProcedure

            MiOperador = CStr(IIf(Not cbBusqExacta.Checked, " LIKE ", " = "))

            'Unidades Administrativas
            MiLista = ""
            Dim item As ListItem
            For Each item In lbUnidAdmin.Items
                If item.Selected Then
                    If MiLista <> "" Then
                        MiLista = MiLista & "," & CStr(item.Value)
                    Else
                        MiLista = CStr(item.Value)
                    End If
                End If
            Next

            If MiLista <> "" Then
                MiCondicionAux = ""
                MiCondicionAux = " e.idUnidadAdministrativa IN (" & MiLista & ") "
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
                'Else
                '    Throw New ApplicationException("Debe escoger al menos una unidad administrativa")
            End If

            'Codigo
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtCodigo.Text) <> "", "dbo.fnNombreDeJerarquia(e.idClasificacion) " & MiOperador & " @Codigo ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Nombre (de expediente)
            HayRangoDeExpedientes = False
            If Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) <> "" Then
                'Rango de expedientes
                HayRangoDeExpedientes = True
                MiCondicionAux = " e.Nombre >=  @Expediente AND e.Nombre <= @ExpedienteFinal "
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            ElseIf Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) = "" Then
                'Condición normal para LIKE, usando txtExpediente
                MiCondicionAux = ""
                MiCondicionAux = CStr(IIf(Trim(txtExpInic.Text) <> "", " e.Nombre " & MiOperador & " @Expediente ", ""))
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
            ElseIf Trim(txtExpInic.Text) = "" And Trim(txtExpFinal.Text) <> "" Then
                'Condición normal para LIKE, usando txtExpedienteFinal
                MiCondicionAux = ""
                MiCondicionAux = CStr(IIf(Trim(txtExpFinal.Text) <> "", " e.Nombre " & MiOperador & " @ExpedienteFinal ", ""))
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
            Else
                'No hay rango de expedientes
            End If

            'Caracteres excluídos
            MiCondicionAux = CondicionDeCaracteresExcluidos(txtCaractExclu.Text)
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Tipo
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtTipo.Text) <> "", " e.CampoAdicional2 " & MiOperador & " @Tipo ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'RFC
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtRFC.Text) <> "", " e.CampoAdicional1 " & MiOperador & " @RFC ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Asunto
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtNombre.Text) <> "", " e.Asunto " & MiOperador & " @Asunto ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Caja
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtCaja.Text) <> "", " e.Caja " & MiOperador & " @Caja ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Relacion anterior
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtRelAnt.Text) <> "", " e.RelacionAnterior " & MiOperador & " @RelacionAnterior ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'AnaqTr
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtAnaqTr.Text) <> "", " e.CajaAnterior " & MiOperador & " @CajaAnterior ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'UbicTr
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtUbicTr.Text) <> "", " e.ItemAnterior " & MiOperador & " @ItemAnterior ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'ObsTr
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtObsTr.Text) <> "", " e.CampoAdicional3 " & MiOperador & " @CampoAdicional3 ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If

            'Rangos de Fechas
            If Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) <> "" Then
                'Rango normal entre dos fechas
                MiCondicionAux = ""
                MiCondicionAux = " FechaApertura BETWEEN @FechaInicial AND @FechaFinal "
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
            ElseIf Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) = "" Then
                'A partir de una fecha hacia adelante
                MiCondicionAux = ""
                MiCondicionAux = " FechaApertura >= @FechaInicial "
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
            ElseIf Trim(txtFApertInic.Text) = "" And Trim(txtFApertFinal.Text) <> "" Then
                'A partir de una fecha hacia atrás
                MiCondicionAux = ""
                MiCondicionAux = " FechaApertura <= @FechaFinal "
                If MiCondicionAux <> "" Then
                    If MiCondicion <> "" Then
                        MiCondicion = MiCondicion & " AND "
                    End If
                    MiCondicion = MiCondicion & MiCondicionAux
                End If
            Else
                'No hay rango de fechas
            End If


            'SQLString
            SQLString = _
                "SET @Contador = (SELECT COUNT(*) FROM Expedientes e " & _
                CStr(IIf(MiCondicion <> "", " WHERE " & MiCondicion, ""))

            'If GITdtpFechaAperturaInicial.GIT_Checked And GITdtpFechaAperturaFinal.GIT_Checked Then
            '    'Rango normal entre dos fechas
            '    SQLString = SQLString & CStr(IIf(InStr(UCase(SQLString), "WHERE") > 0, " AND FechaApertura BETWEEN @FechaInicial AND @FechaFinal ", " WHERE FechaApertura BETWEEN @FechaInicial AND @FechaFinal "))
            'ElseIf GITdtpFechaAperturaInicial.GIT_Checked And Not GITdtpFechaAperturaFinal.GIT_Checked Then
            '    'A partir de una fecha hacia adelante
            '    SQLString = SQLString & CStr(IIf(InStr(UCase(SQLString), "WHERE") > 0, " AND FechaApertura >= @FechaInicial ", " WHERE FechaApertura >= @FechaInicial "))
            'ElseIf Not GITdtpFechaAperturaInicial.GIT_Checked And GITdtpFechaAperturaFinal.GIT_Checked Then
            '    'A partir de una fecha hacia atrás
            '    SQLString = SQLString & CStr(IIf(InStr(UCase(SQLString), "WHERE") > 0, " AND FechaApertura <= @FechaFinal ", " WHERE FechaApertura <= @FechaFinal "))
            'Else
            '    'No hay rango de fechas
            'End If

            'Si llego aquí y no hay siquiera un WHERE, lo pongo ahora y con una condición imposible,
            'para que no devuelva nada
            SQLString = SQLString & CStr(IIf(InStr(UCase(SQLString), "WHERE") > 0, "", " WHERE idExpediente < -1000"))

            param = cmd.Parameters.Add("SQLString", Data.OleDb.OleDbType.VarChar, 4000)
            param.Value = SQLString & ")"

            'Codigo
            param = cmd.Parameters.Add("Codigo", Data.OleDb.OleDbType.VarChar, 50)
            If cbBusqExacta.Checked Then
                param.Value = txtCodigo.Text
            Else
                param.Value = IIf(Trim(txtCodigo.Text) <> "", "%" & Trim(txtCodigo.Text) & "%", "%")
            End If

            'Expediente
            param = cmd.Parameters.Add("Expediente", Data.OleDb.OleDbType.VarChar, 50)
            If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
                param.Value = txtExpInic.Text
            Else
                param.Value = IIf(Trim(txtExpInic.Text) <> "", "%" & Trim(txtExpInic.Text) & "%", "%")
            End If

            'ExpedienteFinal
            param = cmd.Parameters.Add("ExpedienteFinal", Data.OleDb.OleDbType.VarChar, 50)
            If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
                param.Value = txtExpFinal.Text
            Else
                param.Value = IIf(Trim(txtExpFinal.Text) <> "", "%" & Trim(txtExpFinal.Text) & "%", "%")
            End If

            'Tipo 
            param = cmd.Parameters.Add("Tipo", Data.OleDb.OleDbType.VarChar, 50)
            If cbBusqExacta.Checked Then
                param.Value = txtTipo.Text
            Else
                param.Value = IIf(Trim(txtTipo.Text) <> "", "%" & Trim(txtTipo.Text) & "%", "%")
            End If

            'RFC
            param = cmd.Parameters.Add("RFC", Data.OleDb.OleDbType.VarChar, 50)
            If cbBusqExacta.Checked Then
                param.Value = txtRFC.Text
            Else
                param.Value = IIf(Trim(txtRFC.Text) <> "", "%" & Trim(txtRFC.Text) & "%", "%")
            End If

            'Asunto
            param = cmd.Parameters.Add("Asunto", Data.OleDb.OleDbType.VarChar, 250)
            If cbBusqExacta.Checked Then
                param.Value = txtNombre.Text
            Else
                param.Value = IIf(Trim(txtNombre.Text) <> "", "%" & Trim(txtNombre.Text) & "%", "%")
            End If

            'Caja
            param = cmd.Parameters.Add("Caja", Data.OleDb.OleDbType.VarChar, 250)
            If cbBusqExacta.Checked Then
                param.Value = txtCaja.Text
            Else
                param.Value = IIf(Trim(txtCaja.Text) <> "", "%" & Trim(txtCaja.Text) & "%", "%")
            End If

            'Relacion Anterior
            param = cmd.Parameters.Add("RelacionAnterior", Data.OleDb.OleDbType.VarChar, 250)
            If cbBusqExacta.Checked Then
                param.Value = txtRelAnt.Text
            Else
                param.Value = IIf(Trim(txtRelAnt.Text) <> "", "%" & Trim(txtRelAnt.Text) & "%", "%")
            End If

            'AnaqTr
            param = cmd.Parameters.Add("AnaqTr", Data.OleDb.OleDbType.VarChar, 25)
            If cbBusqExacta.Checked Then
                param.Value = txtAnaqTr.Text
            Else
                param.Value = IIf(Trim(txtAnaqTr.Text) <> "", "%" & Trim(txtAnaqTr.Text) & "%", "%")
            End If

            'UbicTr
            param = cmd.Parameters.Add("UbicTr", Data.OleDb.OleDbType.VarChar, 25)
            If cbBusqExacta.Checked Then
                param.Value = txtUbicTr.Text
            Else
                param.Value = IIf(Trim(txtUbicTr.Text) <> "", "%" & Trim(txtUbicTr.Text) & "%", "%")
            End If

            'ObsTr
            param = cmd.Parameters.Add("ObsTr", Data.OleDb.OleDbType.VarChar, 25)
            If cbBusqExacta.Checked Then
                param.Value = txtObsTr.Text
            Else
                param.Value = IIf(Trim(txtObsTr.Text) <> "", "%" & Trim(txtObsTr.Text) & "%", "%")
            End If

            'Le tengo que pasar los dos parámetros de fecha, aunque no los use. 
            'Si no los uso, no aparecen en la cadena SQL generada.

            'Fecha de Apertura inicial
            param = cmd.Parameters.Add("FechaAperturaInicial", Data.OleDb.OleDbType.DBDate)
            If Len(Trim(txtFApertInic.Text)) = 0 Then
                param.Value = CDate("1/1/2000")
            Else
                param.Value = CDate(Trim(txtFApertInic.Text))
            End If

            'Fecha de Apertura final
            param = cmd.Parameters.Add("FechaAperturaFinal", Data.OleDb.OleDbType.DBDate)
            If Len(Trim(txtFApertFinal.Text)) = 0 Then
                param.Value = CDate("1/1/2000")
            Else
                param.Value = CDate(Trim(txtFApertFinal.Text))
            End If

            'Contador
            param = cmd.Parameters.Add("Contador", OleDbType.Integer)
            param.Direction = ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            ProcessedRecords = CInt(cmd.Parameters("Contador").Value)

            'Cierro la colección de parámetros y la conexión
            cmd.Parameters.Clear()
            cn.Close()

            'Cursor.Current = Cursors.Default
            'Application.DoEvents()

        Catch ex As Exception
            'Cursor.Current = Cursors.Default
            'Application.DoEvents()
            If cn.State <> ConnectionState.Closed Then
                cn.Close()
            End If
            'MsgBox(Err.Description)
            ProcessedRecords = -1

        End Try

        Return ProcessedRecords

    End Function


    Public Sub GITPreparaParametros(ByRef Condicion As String, ByRef Parametros As SQLParameters)
        Dim MiOperador As String = ""
        Dim MiCondicion As String = ""
        Dim MiCondicionAux As String = ""
        Dim MiLista As String = ""
        Dim HayRangoDeExpedientes As Boolean = False

        'CONDICION
        '**************************************************************
        MiOperador = CStr(IIf(Not cbBusqExacta.Checked, " LIKE ", " = "))

        ''Codigo
        'MiCondicion = MiCondicion & CStr(IIf(Trim(txtCodigo.Text) <> "", "dbo.fnNombreDeJerarquia(e.idClasificacion) " & MiOperador & " @Codigo ", ""))


        'Unidades Administrativas
        MiLista = ""
        Dim item As ListItem
        For Each item In lbUnidAdmin.Items
            If item.Selected Then
                If MiLista <> "" Then
                    MiLista = MiLista & "," & CStr(item.Value)
                Else
                    MiLista = CStr(item.Value)
                End If
            End If
        Next

        If MiLista <> "" Then
            MiCondicionAux = ""
            MiCondicionAux = " e.idUnidadAdministrativa IN (" & MiLista & ") "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
            'Else
            '    Throw New ApplicationException("Debe escoger al menos una unidad administrativa")
        End If

        'Codigo
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtCodigo.Text) <> "", "dbo.fnNombreDeJerarquia(e.idClasificacion) " & MiOperador & " @Codigo ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Nombre (de expediente)
        HayRangoDeExpedientes = False
        If Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) <> "" Then
            'Rango de expedientes
            HayRangoDeExpedientes = True
            MiCondicionAux = " e.Nombre >=  @Expediente AND e.Nombre <= @ExpedienteFinal "
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        ElseIf Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) = "" Then
            'Condición normal para LIKE, usando txtExpediente
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtExpInic.Text) <> "", " e.Nombre " & MiOperador & " @Expediente ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtExpInic.Text) = "" And Trim(txtExpFinal.Text) <> "" Then
            'Condición normal para LIKE, usando txtExpedienteFinal
            MiCondicionAux = ""
            MiCondicionAux = CStr(IIf(Trim(txtExpFinal.Text) <> "", " e.Nombre " & MiOperador & " @ExpedienteFinal ", ""))
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        Else
            'No hay rango de expedientes
        End If

        'Caracteres excluídos
        MiCondicionAux = CondicionDeCaracteresExcluidos(txtCaractExclu.Text)
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Tipo
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtTipo.Text) <> "", " e.CampoAdicional2 " & MiOperador & " @Tipo ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'RFC
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtRFC.Text) <> "", " e.CampoAdicional1 " & MiOperador & " @RFC ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Asunto
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtNombre.Text) <> "", " e.Asunto " & MiOperador & " @Asunto ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Caja
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtCaja.Text) <> "", " e.Caja " & MiOperador & " @Caja ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'Relacion anterior
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtRelAnt.Text) <> "", " e.RelacionAnterior " & MiOperador & " @RelacionAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'AnaqTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtAnaqTr.Text) <> "", " e.CajaAnterior " & MiOperador & " @CajaAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'UbicTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtUbicTr.Text) <> "", " e.ItemAnterior " & MiOperador & " @ItemAnterior ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        'ObsTr
        MiCondicionAux = ""
        MiCondicionAux = CStr(IIf(Trim(txtObsTr.Text) <> "", " e.CampoAdicional3 " & MiOperador & " @CampoAdicional3 ", ""))
        If MiCondicionAux <> "" Then
            If MiCondicion <> "" Then
                MiCondicion = MiCondicion & " AND "
            End If
            MiCondicion = MiCondicion & MiCondicionAux
        End If

        If Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) <> "" Then
            'Rango normal entre dos fechas
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura BETWEEN @FechaInicial AND @FechaFinal "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) = "" Then
            'A partir de una fecha hacia adelante
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura >= @FechaInicial "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        ElseIf Trim(txtFApertInic.Text) = "" And Trim(txtFApertFinal.Text) <> "" Then
            'A partir de una fecha hacia atrás
            MiCondicionAux = ""
            MiCondicionAux = " FechaApertura <= @FechaFinal "
            If MiCondicionAux <> "" Then
                If MiCondicion <> "" Then
                    MiCondicion = MiCondicion & " AND "
                End If
                MiCondicion = MiCondicion & MiCondicionAux
            End If
        Else
            'No hay rango de fechas
        End If
        Condicion = MiCondicion

        'PARAMETROS
        '**************************************************************

        'Codigo
        If cbBusqExacta.Checked Then
            Parametros.Codigo = txtCodigo.Text
        Else
            Parametros.Codigo = CStr(IIf(Trim(txtCodigo.Text) <> "", "%" & Trim(txtCodigo.Text) & "%", "%"))
        End If

        'Expediente
        If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
            Parametros.Expediente = txtExpInic.Text()
        Else
            Parametros.Expediente = CStr(IIf(Trim(txtExpInic.Text) <> "", "%" & Trim(txtExpInic.Text) & "%", "%"))
        End If

        'ExpedienteFinal
        If cbBusqExacta.Checked Or HayRangoDeExpedientes Then
            Parametros.ExpedienteFinal = txtExpFinal.Text()
        Else
            Parametros.ExpedienteFinal = CStr(IIf(Trim(txtExpFinal.Text) <> "", "%" & Trim(txtExpFinal.Text) & "%", "%"))
        End If

        'Tipo 
        If cbBusqExacta.Checked Then
            Parametros.Tipo = txtTipo.Text
        Else
            Parametros.Tipo = CStr(IIf(Trim(txtTipo.Text) <> "", "%" & Trim(txtTipo.Text) & "%", "%"))
        End If

        'RFC
        If cbBusqExacta.Checked Then
            Parametros.RFC = txtRFC.Text
        Else
            Parametros.RFC = CStr(IIf(Trim(txtRFC.Text) <> "", "%" & Trim(txtRFC.Text) & "%", "%"))
        End If

        'Asunto
        If cbBusqExacta.Checked Then
            Parametros.Asunto = txtNombre.Text
        Else
            Parametros.Asunto = CStr(IIf(Trim(txtNombre.Text) <> "", "%" & Trim(txtNombre.Text) & "%", "%"))
        End If

        'Caja
        If cbBusqExacta.Checked Then
            Parametros.Cajas = txtCaja.Text
        Else
            Parametros.Cajas = CStr(IIf(Trim(txtCaja.Text) <> "", "%" & Trim(txtCaja.Text) & "%", "%"))
        End If

        'RelacionAnterior
        If cbBusqExacta.Checked Then
            Parametros.RelacionAnterior = txtRelAnt.Text
        Else
            Parametros.RelacionAnterior = CStr(IIf(Trim(txtRelAnt.Text) <> "", "%" & Trim(txtRelAnt.Text) & "%", "%"))
        End If

        'CajaAnterior (AnaqTr)
        If cbBusqExacta.Checked Then
            Parametros.CajaAnterior = txtAnaqTr.Text
        Else
            Parametros.CajaAnterior = CStr(IIf(Trim(txtAnaqTr.Text) <> "", "%" & Trim(txtAnaqTr.Text) & "%", "%"))
        End If

        'ItemAnterior (txtUbicTr)
        If cbBusqExacta.Checked Then
            Parametros.ItemAnterior = txtUbicTr.Text
        Else
            Parametros.ItemAnterior = CStr(IIf(Trim(txtUbicTr.Text) <> "", "%" & Trim(txtUbicTr.Text) & "%", "%"))
        End If

        'CampoAdicional3 (txtObsTr)
        If cbBusqExacta.Checked Then
            Parametros.CampoAdicional3 = txtObsTr.Text
        Else
            Parametros.CampoAdicional3 = CStr(IIf(Trim(txtObsTr.Text) <> "", "%" & Trim(txtObsTr.Text) & "%", "%"))
        End If

        'Fecha de Apertura inicial
        'Parametros.FechaInicial = CDate(Trim(txtFApertInic.Text)) ' GITdtpFechaAperturaInicial.GIT_Value
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            Parametros.FechaInicial = CDate("1/1/2000")
        Else
            Parametros.FechaInicial = CDate(Trim(txtFApertInic.Text))
        End If


        'Fecha de Apertura final
        'Parametros.FechaFinal = CDate(Trim(txtFApertFinal.Text)) 'GITdtpFechaAperturaFinal.GIT_Value
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            Parametros.FechaFinal = CDate("1/1/2000")
        Else
            Parametros.FechaFinal = CDate(Trim(txtFApertFinal.Text))
        End If

    End Sub

    Public Shared Function FechaLatinaAGringa(ByVal FechaLatina As String) As String
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

    Function CondicionDeCaracteresExcluidos(ByVal CaracteresAExcluir As String) As String
        Try
            Dim MiCondicion As String = ""
            Dim MiCondicionAux As String = ""

            If Trim(CaracteresAExcluir) <> "" Then
                For i As Integer = 1 To Len(Trim(CaracteresAExcluir))
                    MiCondicionAux = " CHARINDEX('" & Mid(CaracteresAExcluir, i, 1) & "',e.Nombre) = 0 "
                    If MiCondicion <> "" Then
                        MiCondicion &= " AND "
                    End If
                    MiCondicion &= MiCondicionAux
                Next
            End If
            Return MiCondicion

        Catch ex As Exception
            'MsgBox(ex.Message)
            Return ""
        End Try

    End Function

    Private Sub DataGrid1_SortCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridSortCommandEventArgs) Handles DataGrid1.SortCommand

        Select Case e.SortExpression
            Case "Codigo"
                Session("OrdenDeGridDeExpedientes") = " e.Codigo "
            Case "Expediente"
                Session("OrdenDeGridDeExpedientes") = " e.Nombre "
            Case "Tipo"
                Session("OrdenDeGridDeExpedientes") = " e.CampoAdicional2 "
            Case "RFC"
                Session("OrdenDeGridDeExpedientes") = " e.CampoAdicional1 "
            Case "Nombre"
                Session("OrdenDeGridDeExpedientes") = " e.Asunto "
            Case "CajaT"
                Session("OrdenDeGridDeExpedientes") = " e.RelacionAnterior "
            Case "Caja"
                Session("OrdenDeGridDeExpedientes") = " e.Caja "
            Case "FechaApertura"
                Session("OrdenDeGridDeExpedientes") = " e.FechaApertura "
            Case "FechaCierre"
                Session("OrdenDeGridDeExpedientes") = " e.FechaCierre "
            Case "UnidAdmin"
                Session("OrdenDeGridDeExpedientes") = " ua.NombreCorto "
            Case Else
                Session("OrdenDeGridDeExpedientes") = " e.Nombre "
        End Select

        LlenaGrid()

    End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand

        If e.Item.ItemIndex >= 0 Then
            Session("IDExpedienteActivo") = DataGrid1.DataKeys.Item(e.Item.ItemIndex)
            Session("ExpedienteStatus") = 0
            Session("MovimientoStatus") = 0
            Session("CuadroClasificacionStatus") = 0
            Session("UsuarioRealStatus") = 0
            Response.Redirect("./DisplayExpediente.aspx")
        End If

    End Sub

    Private Sub LinkButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

        'Session("IDExpedienteActivo") = -1
        'Session("ExpedienteStatus") = 0
        'Session("MovimientoStatus") = 0
        'Session("CuadroClasificacionStatus") = 0
        'Session("UsuarioRealStatus") = 0
        'Response.Redirect("./DisplayExpediente.aspx")

    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Session("IDExpedienteActivo") = -1
        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0
        Response.Redirect("./DisplayExpediente.aspx")
    End Sub

    Private Sub btnImprimeGuiaDeExpedientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeGuiaDeExpedientes.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New GuiaDeExpedientesFOVISSSTE
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaGuiaDeExpedientesExistentesSQL"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Listado guía de expedientes existentes por Unidad Administrativa")
        Reporte.SetParameterValue(1, "")

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

    End Sub

    Private Sub btnImprimeListadoDeExpedientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeListadoDeExpedientes.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New ListaDeExpedientesFOVISSSTE
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "ListadoDeExpedientesSQL2"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "Listado de expedientes por Unidad Administrativa conforme a criterio de búsqueda")
        'Reporte.SetParameterValue(1, "700 FOVISSSTE")

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

    End Sub

    Private Sub btnImprimeCaratulas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeCaratulas.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New CaratulaFOVISSSTECredito
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTESQL2"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("Orden", OleDbType.VarChar)
        Select Case Session("OrdenDeGridDeExpedientes").ToString
            Case " e.Codigo " 'Codigo del expediente
                param.Value = " Codigo "
            Case " e.Nombre " 'Numero del expediente
                param.Value = " Numero "
            Case " e.CampoAdicional2 " 'REF 
                param.Value = " Ref "
            Case " e.CampoAdicional1 " 'RFC
                param.Value = " RFC "
            Case " e.Asunto " 'Nombre del expediente
                param.Value = " Asunto "
            Case " e.RelacionAnterior "
                param.Value = " CajaAnterior "
            Case " e.Caja "
                param.Value = " Caja "
            Case " e.FechaApertura "
                param.Value = " e.FechaApertura "
            Case " e.FechaCierre " 'FechaCierre
                param.Value = " e.FechaCierre "
            Case " ua.NombreCorto " 'Unidad Administrativa
                param.Value = " Unidad "
            Case Else
                param.Value = " Numero "
        End Select

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "SENADO")
        Reporte.SetParameterValue(1, "")

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

    End Sub

    Private Sub btnCaratulasNoCredito_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCaratulasNoCredito.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New CaratulaCONACYT3 'CaratulaFOVISSSTE2
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTESQL2"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("Orden", OleDbType.VarChar)
        Select Case Session("OrdenDeGridDeExpedientes").ToString
            Case " e.Codigo " 'Codigo del expediente
                param.Value = " Codigo "
            Case " e.Nombre " 'Numero del expediente
                param.Value = " Numero "
            Case " e.CampoAdicional2 " 'REF 
                param.Value = " Ref "
            Case " e.CampoAdicional1 " 'RFC
                param.Value = " RFC "
            Case " e.Asunto " 'Nombre del expediente
                param.Value = " Asunto "
            Case " e.RelacionAnterior "
                param.Value = " CajaAnterior "
            Case " e.Caja "
                param.Value = " Caja "
            Case " e.FechaApertura "
                param.Value = " e.FechaApertura "
            Case " e.FechaCierre " 'FechaCierre
                param.Value = " e.FechaCierre "
            Case " ua.NombreCorto " 'Unidad Administrativa
                param.Value = " Unidad "
            Case Else
                param.Value = " Numero "
        End Select

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "SENADO")
        Reporte.SetParameterValue(1, "")

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

    End Sub

    Private Sub btnEtiquetas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEtiquetas.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New NuevasEtiquetasFOVISSSTE
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "EtiquetasFOVISSSTE_NEW2"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("Orden", OleDbType.VarChar)
        Select Case Session("OrdenDeGridDeExpedientes").ToString
            Case " e.Codigo " 'Codigo del expediente
                param.Value = " Codigo "
            Case " e.Nombre " 'Numero del expediente
                param.Value = " Numero "
            Case " e.CampoAdicional2 " 'REF 
                param.Value = " Ref "
            Case " e.CampoAdicional1 " 'RFC
                param.Value = " RFC "
            Case " e.Asunto " 'Nombre del expediente
                param.Value = " Asunto "
            Case " e.RelacionAnterior "
                param.Value = " CajaAnterior "
            Case " e.Caja "
                param.Value = " Caja "
            Case " e.FechaApertura "
                param.Value = " e.FechaApertura "
            Case " e.FechaCierre " 'FechaCierre
                param.Value = " e.FechaCierre "
            Case " ua.NombreCorto " 'Unidad Administrativa
                param.Value = " Unidad "
            Case Else
                param.Value = " Numero "
        End Select

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        'Reporte.SetParameterValue(0, "ISSSTE")
        'Reporte.SetParameterValue(1, "700 FOVISSSTE")

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

        'Dim Reporte As New EtiquetasFOVISSSTE
        'Dim MisParametros As New FSWeb2.BuscarExpediente.SQLParameters
        'Dim MiCondicion As String

        'GITPreparaParametros(MiCondicion, MisParametros)

        'cn.ConnectionString = Session("UsuarioVirtualConnString")
        'cn.Open()

        'cmd.CommandType = CommandType.StoredProcedure
        'cmd.Connection = cn
        'cmd.Parameters.Clear()
        'cmd.CommandText = "CargaFormatoCaratulaFOVISSSTESQL"
        'cmd.CommandTimeout = 0

        'param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        'param.Value = MiCondicion

        'param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        'param.Value = MisParametros.Codigo

        'param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        'param.Value = MisParametros.Expediente

        'param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        'param.Value = MisParametros.ExpedienteFinal

        'param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        'param.Value = MisParametros.Tipo

        'param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        'param.Value = MisParametros.RFC

        'param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        'param.Value = MisParametros.Asunto

        'param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        'param.Value = MisParametros.Cajas

        'param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        'param.Value = MisParametros.RelacionAnterior

        'param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        'param.Value = MisParametros.FechaInicial

        'param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        'param.Value = MisParametros.FechaFinal

        'da.SelectCommand = cmd
        'da.Fill(ds)
        'da.Dispose()

        'Reporte.SetDataSource(ds.Tables(0))

        ''Reporte.SetParameterValue(0, "ISSSTE")
        'Reporte.SetParameterValue(0, "700. FOVISSSTE")


        'Dim guid1 As Guid = Guid.NewGuid
        'Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

        ''Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
        ''ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
        'Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        'Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
        'Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

        ''Write the file directly to the HTTP output stream.
        'Response.ContentType = "Application/pdf"
        'Response.WriteFile(MyFileName)
        'Response.End()

    End Sub

    Private Sub btnLomos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLomos.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        'Dim Reporte As New LomoFOVISSSTE
        Dim Reporte As New LomoFOVISSSTE_NEW

        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTESQL2"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("Orden", OleDbType.VarChar)
        Select Case Session("OrdenDeGridDeExpedientes").ToString()

            Case " e.Codigo " 'Codigo del expediente
                param.Value = " Codigo "
            Case " e.Nombre " 'Numero del expediente
                param.Value = " Numero "
            Case " e.CampoAdicional2 " 'REF 
                param.Value = " Ref "
            Case " e.CampoAdicional1 " 'RFC
                param.Value = " RFC "
            Case " e.Asunto " 'Nombre del expediente
                param.Value = " Asunto "
            Case " e.RelacionAnterior "
                param.Value = " CajaAnterior "
            Case " e.Caja "
                param.Value = " Caja "
            Case " e.FechaApertura "
                param.Value = " e.FechaApertura "
            Case " e.FechaCierre " 'FechaCierre
                param.Value = " e.FechaCierre "
            Case " ua.NombreCorto " 'Unidad Administrativa
                param.Value = " Unidad "
            Case Else
                param.Value = " Numero "
        End Select

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        'Reporte.SetParameterValue(0, "ISSSTE")
        'Reporte.SetParameterValue(1, "700 FOVISSSTE")

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

    End Sub

    Sub ActualizaStatusDeExpedientes()

        Dim cmd As New OleDbCommand
        Dim cn As New OleDbConnection
        Dim param As OleDbParameter

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "ActualizaEstatusExpedientesVencidos"

        param = cmd.Parameters.Add("IDExpediente", OleDbType.Date)
        param.Value = Now

        cmd.ExecuteNonQuery()

    End Sub

    Private Sub btnVencidosTramite_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) _
            Handles btnExpedientesActivos.Click,
            btnVencidosTramite.Click,
            btnEnTraspasoAConcentracion.Click,
            btnVigentesConcentracion.Click,
            btnVencidosConcentracion.Click,
            btnEnArchivoHistorico.Click,
            btnExpedientesDadosDeBaja.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New ListaDeExpedientesFOVISSSTE
        Dim MisParametros As New BuscarExpediente.SQLParameters
        Dim MiCondicion As String

        ActualizaStatusDeExpedientes()

        GITPreparaParametros(MiCondicion, MisParametros)

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "ListadoDeExpedientesPorEstatusSQL3"
        cmd.CommandTimeout = 0

        param = cmd.Parameters.Add("SQLCondicion", OleDbType.VarChar)
        param.Value = MiCondicion

        param = cmd.Parameters.Add("Codigo", OleDbType.VarChar)
        param.Value = MisParametros.Codigo

        param = cmd.Parameters.Add("Expediente", OleDbType.VarChar)
        param.Value = MisParametros.Expediente

        param = cmd.Parameters.Add("ExpedienteFinal", OleDbType.VarChar)
        param.Value = MisParametros.ExpedienteFinal

        param = cmd.Parameters.Add("Tipo", OleDbType.VarChar)
        param.Value = MisParametros.Tipo

        param = cmd.Parameters.Add("RFC", OleDbType.VarChar)
        param.Value = MisParametros.RFC

        param = cmd.Parameters.Add("Asunto", OleDbType.VarChar)
        param.Value = MisParametros.Asunto

        param = cmd.Parameters.Add("Caja", OleDbType.VarChar)
        param.Value = MisParametros.Cajas

        param = cmd.Parameters.Add("RelacionAnterior", OleDbType.VarChar)
        param.Value = MisParametros.RelacionAnterior

        param = cmd.Parameters.Add("CajaAnterior", OleDbType.VarChar)
        param.Value = MisParametros.CajaAnterior

        param = cmd.Parameters.Add("ItemAnterior", OleDbType.VarChar)
        param.Value = MisParametros.ItemAnterior

        param = cmd.Parameters.Add("CampoAdicional3", OleDbType.VarChar)
        param.Value = MisParametros.CampoAdicional3

        param = cmd.Parameters.Add("FechaInicial", OleDbType.Date)
        param.Value = MisParametros.FechaInicial

        param = cmd.Parameters.Add("FechaFinal", OleDbType.Date)
        param.Value = MisParametros.FechaFinal

        param = cmd.Parameters.Add("IDExpediente", OleDbType.Integer)
        Select Case CType(sender, System.Web.UI.WebControls.Button).ID
            Case "btnExpedientesActivos"
                param.Value = 1
                Reporte.SetParameterValue(0, "Listado de expedientes en Archivo de Trámite vigentes por Unidad Administrativa")
            Case "btnVencidosTramite"
                param.Value = 2
                Reporte.SetParameterValue(0, "Listado de expedientes en Archivo de Trámite vencidos por Unidad Administrativa")
            Case "btnEnTraspasoAConcentracion"
                param.Value = 3
                Reporte.SetParameterValue(0, "Listado de expedientes en traspaso a Archivo de Concentración por Unidad Administrativa")
            Case "btnVigentesConcentracion"
                param.Value = 4
                Reporte.SetParameterValue(0, "Listado de expedientes en Archivo de Concentración vigentes por Unidad Administrativa")
            Case "btnVencidosConcentracion"
                param.Value = 5
                Reporte.SetParameterValue(0, "Listado de expedientes en Archivo de Concentración vencidos por Unidad Administrativa")
            Case "btnEnArchivoHistorico"
                param.Value = 6
                Reporte.SetParameterValue(0, "Listado de expedientes en Archivo Histórico por Unidad Administrativa")
            Case "btnExpedientesDadosDeBaja"
                param.Value = 7
                Reporte.SetParameterValue(0, "Listado de expedientes dados de baja por Unidad Administrativa")
        End Select

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        'Reporte.SetParameterValue(1, "700. FOVISSSTE")

        If RadioButtonPDF.Checked Then
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

        Else
            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".xls"

            'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
            'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.Excel, MyFileName)
            Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.xls")
            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.Excel, MyFileName)

            'Write the file directly to the HTTP output stream.
            Response.ContentType = "Application/vnd.ms-excel"
            Response.WriteFile(MyFileName)
            Response.End()

        End If

    End Sub

End Class
