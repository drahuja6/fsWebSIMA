Imports System.Text.RegularExpressions
Imports System.Data.OleDb
Imports System.IO

Public Class DisplayExpediente
    Inherits System.Web.UI.Page

#Region " Código generado por el Diseñador de Web Forms "

    'El Diseñador de Web Forms requiere esta llamada.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Protected WithEvents Label1 As System.Web.UI.WebControls.Label
    Protected WithEvents txtCodigo As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label2 As System.Web.UI.WebControls.Label
    Protected WithEvents Label3 As System.Web.UI.WebControls.Label
    Protected WithEvents txtExpediente As System.Web.UI.WebControls.TextBox
    Protected WithEvents lbJerarquia As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label4 As System.Web.UI.WebControls.Label
    Protected WithEvents txtTipo As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label5 As System.Web.UI.WebControls.Label
    Protected WithEvents txtRFC As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label6 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNombre As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label7 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNoDeFojas As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label8 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaApertura As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label9 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaCierre As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label10 As System.Web.UI.WebControls.Label
    Protected WithEvents Label11 As System.Web.UI.WebControls.Label
    Protected WithEvents lblAutorizaPaseBajaHistorico As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaPaseBajaHistorico As System.Web.UI.WebControls.TextBox
    Protected WithEvents lbxUnidadAdmin As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label12 As System.Web.UI.WebControls.Label
    Protected WithEvents Label13 As System.Web.UI.WebControls.Label
    Protected WithEvents lbxCalidadDoc As System.Web.UI.WebControls.DropDownList
    Protected WithEvents btnLocalizacion As System.Web.UI.WebControls.Button
    Protected WithEvents btnClasificacion As System.Web.UI.WebControls.Button
    Protected WithEvents btnAtributos As System.Web.UI.WebControls.Button
    Protected WithEvents Label15 As System.Web.UI.WebControls.Label
    Protected WithEvents Label16 As System.Web.UI.WebControls.Label
    Protected WithEvents Label17 As System.Web.UI.WebControls.Label
    Protected WithEvents Label18 As System.Web.UI.WebControls.Label
    Protected WithEvents Label19 As System.Web.UI.WebControls.Label
    Protected WithEvents Label20 As System.Web.UI.WebControls.Label
    Protected WithEvents Label21 As System.Web.UI.WebControls.Label
    Protected WithEvents txtCaja As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtAnaquel As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtPasillo As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtEntrepano As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtRelacionAnterior As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtCajaAnterior As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtItemAnterior As System.Web.UI.WebControls.TextBox
    Protected WithEvents Panel1 As System.Web.UI.WebControls.Panel
    Protected WithEvents Label22 As System.Web.UI.WebControls.Label
    Protected WithEvents PLocalizacion As System.Web.UI.WebControls.Panel
    Protected WithEvents ddlstStatus As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label26 As System.Web.UI.WebControls.Label
    Protected WithEvents chkbxParteDelDocumento As System.Web.UI.WebControls.CheckBox
    Protected WithEvents Label27 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFojas As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label28 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaDeClasificacion As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label29 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaPropuestaDesclasificacion As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label30 As System.Web.UI.WebControls.Label
    Protected WithEvents lbFundamentosLegalesClasificacion As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label31 As System.Web.UI.WebControls.Label
    Protected WithEvents Label32 As System.Web.UI.WebControls.Label
    Protected WithEvents Label33 As System.Web.UI.WebControls.Label
    Protected WithEvents txtNuevaFojas As System.Web.UI.WebControls.TextBox
    Protected WithEvents txtNuevaFechaPropuestaDesclasificacion As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label34 As System.Web.UI.WebControls.Label
    Protected WithEvents Label35 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaDesclasificacion As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label36 As System.Web.UI.WebControls.Label
    Protected WithEvents lblAutorizaNuevaDesc As System.Web.UI.WebControls.Label
    Protected WithEvents lblAutorizaDesclasificacion As System.Web.UI.WebControls.Label
    Protected WithEvents chkbxNuevaParteDelDocumento As System.Web.UI.WebControls.CheckBox
    Protected WithEvents lblValidaFechaClasificacion As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaPropuestaDesclasificacion As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaNuevaDesclasificacion As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaDesclasificacion As System.Web.UI.WebControls.Label
    Protected WithEvents PClasificacion As System.Web.UI.WebControls.Panel
    Protected WithEvents Label37 As System.Web.UI.WebControls.Label
    Protected WithEvents lbxValorDocumental As System.Web.UI.WebControls.ListBox
    Protected WithEvents Label38 As System.Web.UI.WebControls.Label
    Protected WithEvents Label39 As System.Web.UI.WebControls.Label
    Protected WithEvents Label40 As System.Web.UI.WebControls.Label
    Protected WithEvents ddlstTramite As System.Web.UI.WebControls.DropDownList
    Protected WithEvents ddlstConcentracion As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label41 As System.Web.UI.WebControls.Label
    Protected WithEvents Label42 As System.Web.UI.WebControls.Label
    Protected WithEvents ddlstDestinoFinal As System.Web.UI.WebControls.DropDownList
    Protected WithEvents Label43 As System.Web.UI.WebControls.Label
    Protected WithEvents lbxFundamentosLegalesDestinoFinal As System.Web.UI.WebControls.ListBox
    Protected WithEvents PAtributos As System.Web.UI.WebControls.Panel
    Protected WithEvents Label23 As System.Web.UI.WebControls.Label
    Protected WithEvents txtFechaDeCreacion As System.Web.UI.WebControls.TextBox
    Protected WithEvents Label24 As System.Web.UI.WebControls.Label
    Protected WithEvents Label25 As System.Web.UI.WebControls.Label
    Protected WithEvents btnSalvar As System.Web.UI.WebControls.Button
    Protected WithEvents btnCancelar As System.Web.UI.WebControls.Button
    Protected WithEvents btnAgregar As System.Web.UI.WebControls.Button
    Protected WithEvents btnEditar As System.Web.UI.WebControls.Button
    Protected WithEvents btnBorrar As System.Web.UI.WebControls.Button
    Protected WithEvents lblElaborPor As System.Web.UI.WebControls.Label
    Protected WithEvents lblUltimaedicion As System.Web.UI.WebControls.Label
    Protected WithEvents lblExpedienteStatus As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaCodigo As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaExpediente As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaApertura As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaCreacion As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidacionNoDeFojas As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaNombre As System.Web.UI.WebControls.Label
    Protected WithEvents lblValidaFechaCierre As System.Web.UI.WebControls.Label
    Protected WithEvents btnCaratula As System.Web.UI.WebControls.Button
    Protected WithEvents DataGrid1 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents NoHayDatos As System.Web.UI.WebControls.Label
    Protected WithEvents Label14 As System.Web.UI.WebControls.Label
    Protected WithEvents Button2 As System.Web.UI.WebControls.Button
    Protected WithEvents lblValidaFechaPaseBajaHistorico As System.Web.UI.WebControls.Label
    Protected WithEvents DataGrid2 As System.Web.UI.WebControls.DataGrid
    Protected WithEvents NoHayDatos2 As System.Web.UI.WebControls.Label
    Protected WithEvents PPDFs As System.Web.UI.WebControls.Panel
    Protected WithEvents btnVerDocumentos As System.Web.UI.WebControls.Button
    Protected WithEvents btnCaratula2 As System.Web.UI.WebControls.Button
    Protected WithEvents btnLomo As System.Web.UI.WebControls.Button
    Protected WithEvents btnAbreEscogeCuadro As System.Web.UI.WebControls.Button
    Protected WithEvents Label44 As System.Web.UI.WebControls.Label
    Protected WithEvents Label45 As System.Web.UI.WebControls.Label
    Protected WithEvents txtObservConcentracion As System.Web.UI.WebControls.TextBox

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
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then
            'Beep()
            '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
            Select Case Session("ExpedienteStatus")
                Case 0, 5 'SOLO LECTURA
                    FillExpediente(CInt(Session("IDExpedienteActivo")))
                    Session("ExpedienteStatus") = 0

                Case 1 'AÑADIENDO

                Case 2 'EDITANDO
                Case 3 'BORRANDO

                    'Case 5 'REGRESANDO DE UNA EDICION DE MOVIMIENTOS
                    '    FillExpediente(CInt(Session("IDExpedienteActivo")))
                    '    Session("ExpedienteStatus") = 0

            End Select

        End If

        '*****************************************************
        If Session("TextoCuadroClasificacionEscogido") <> "" Then
            If Session("ExpedienteStatus") = 2 Then
                FillExpediente(CInt(Session("IDExpedienteActivo")))
            Else
                'Llenado de combos (sin escoger valor, por si no hay Expediente)
                FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", -1)
                FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", -1)
                FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", -1)
                FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", -1)
                FillDropDownList(Session("UsuarioVirtualConnString"), lbxCalidadDoc, "CalidadDocumental_SELECTALL", "idCalidadDocumental", "Descripcion", -1)
                FillDropDownList(Session("UsuarioVirtualConnString"), lbxUnidadAdmin, "UnidadesAdministrativasDeUnUsuarioReal", CInt(Session("IDUsuarioReal")), "idUnidadAdministrativa", "NombreCorto", -1)

            End If
            txtCodigo.Text = Session("TextoCuadroClasificacionEscogido")

            FillJerarquia(txtCodigo.Text)

            btnSalvar.Text = "Salvar"
            btnSalvar.Enabled = True
            btnCancelar.Enabled = True
            btnAgregar.Enabled = False
            btnEditar.Enabled = False
            btnBorrar.Enabled = False
            btnCaratula.Enabled = False
            btnCaratula2.Enabled = False
            btnLomo.Enabled = False

            EnableDisableControls1(True)
            Button2.Enabled = False

            If Session("ExpedienteStatus") = 1 Then
                EnableDisableControls2(False)
            Else
                EnableDisableControls2(True)
            End If

        End If
        Session("TextoCuadroClasificacionEscogido") = ""
        '*****************************************************

        MuestraStatus()

    End Sub

    Function FillPDF(ByVal idExpediente As Integer) As Boolean

        'Rutina para leer y llenar el grid con los documentos asociados a un expediente

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsPDF As New Data.DataSet

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure para leer los nodos
        cmd.CommandText = "ExpedientesPDF_SELECT_ALL"
        cmd.Connection = cn
        cmd.CommandType = CommandType.StoredProcedure

        'MyidExpediente
        param = cmd.Parameters.Add("MyidExpediente", Data.OleDb.OleDbType.Integer)
        param.Value = idExpediente

        'Creo el objeto DataAdapter
        Dim daPDF As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daPDF.Fill(dsPDF, "PDFs")
        dsPDF.Tables("PDFs").Rows.Clear()
        daPDF.Fill(dsPDF, "PDFs")

        If dsPDF.Tables(0).Rows.Count = 0 Then
            DataGrid2.Visible = False
            NoHayDatos2.Visible = True

        Else
            DataGrid2.Visible = True
            NoHayDatos2.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            DataGrid2.DataSource = dsPDF

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            DataGrid2.DataMember = "PDFs"
            DataGrid2.DataKeyField = "idExpedientePDFRelaciones"
            'DataGrid1.PagerStyle.Mode = PagerMode.NumericPages
            DataGrid2.DataBind()

        End If

        cn.Close()

    End Function

    Function FillMovimientos(ByVal idExpediente As Integer) As Boolean

        'Rutina para leer y llenar el grid con los movimientos de un expediente

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dsMovimientos As New Data.DataSet

        'Abro la conexión
        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        'Asigno el Stored Procedure para leer los nodos
        cmd.CommandText = "Movimientos_idExpediente_SELECT_ALL_2"
        cmd.Connection = cn
        cmd.CommandType = CommandType.StoredProcedure

        'MyidExpediente
        param = cmd.Parameters.Add("MyidExpediente", Data.OleDb.OleDbType.Integer)
        param.Value = idExpediente

        'Creo el objeto DataAdapter
        Dim daMovimientos As New Data.OleDb.OleDbDataAdapter(cmd)

        'Añado al objeto DataSet una nueva tabla,
        'llenándola con datos según instrucciones del DataAdapter
        daMovimientos.Fill(dsMovimientos, "Movimientos")
        dsMovimientos.Tables("Movimientos").Rows.Clear()
        daMovimientos.Fill(dsMovimientos, "Movimientos")

        If dsMovimientos.Tables(0).Rows.Count = 0 Then
            DataGrid1.Visible = False
            NoHayDatos.Visible = True

        Else
            DataGrid1.Visible = True
            NoHayDatos.Visible = False

            'Señalo cuál va a ser el DataSet de este grid
            DataGrid1.DataSource = dsMovimientos

            'Señalo cual va a ser el campo llave.
            'Si en esta propiedad coloco el nombre de una DataTable, el grid se llena
            'con TODO su contenido sin mayor problema. Si en esta propiedad coloco el nombre
            'de una relación, el grid se llena SOLAMENTE con los datos que cumplen con la
            'relación. Hay que poner el nombre completo: "TABLA.RELACION"
            DataGrid1.DataMember = "Movimientos"
            DataGrid1.DataKeyField = "idMovimientos"
            DataGrid1.PagerStyle.Mode = PagerMode.NumericPages
            DataGrid1.DataBind()

        End If

        cn.Close()

    End Function

    Function FillExpediente(ByVal idExpediente As Integer) As Boolean

        'Rutina para leer y llenar la forma con los datos de UN expediente

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try
            LimpiaCampos()

            'Llenado de combos (sin escoger valor, por si no hay Expediente)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), lbxCalidadDoc, "CalidadDocumental_SELECTALL", "idCalidadDocumental", "Descripcion", -1)
            FillDropDownList(Session("UsuarioVirtualConnString"), lbxUnidadAdmin, "UnidadesAdministrativasDeUnUsuarioReal", CInt(Session("IDUsuarioReal")), "idUnidadAdministrativa", "NombreCorto", -1)

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Expedientes_SELECT_ONE_2"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idUsuarioReal 
            param = cmd.Parameters.Add("idUsuarioReal", Data.OleDb.OleDbType.Integer)
            param.Value = Session("IDUsuarioReal")

            'Ejecuto el sp y obtengo el DataSet
            dr = cmd.ExecuteReader()

            'Recorro el DataSet
            If dr.HasRows Then
                While dr.Read()
                    Session("IDExpedienteActivo") = CInt(dr("idExpediente"))

                    Session("NextLeftActivo") = CInt(dr("NextLeft"))
                    Session("NextRightActivo") = CInt(dr("NextRight"))

                    txtCodigo.Text = CStr(dr("Codigo"))
                    FillJerarquia(txtCodigo.Text)
                    txtExpediente.Text = CStr(dr("Nombre"))
                    txtNombre.Text = CStr(dr("Asunto"))
                    txtNoDeFojas.Text = CStr(dr("NumeroDeFojas"))
                    txtFechaApertura.Text = CStr(dr("FechaAperturaDMA"))
                    txtFechaCierre.Text = IIf(CBool(dr("FechaCierreChecked")), dr("FechaCierreDMA"), "")
                    txtFechaPaseBajaHistorico.Text = IIf(CBool(dr("FechaDePaseABajaHistoricoChecked")), dr("FechaDePaseABajaHistoricoDMA"), "")
                    lblAutorizaPaseBajaHistorico.Text = Get_UsuarioReal_from_ID(CInt(dr("idUsuario_AutorizaBajaHistorico")))


                    'txtCaja.Text = CStr(dr("Caja"))
                    'txtAnaquel.Text = CStr(dr("Anaquel"))
                    'txtEntrepano.Text = CStr(dr("Entrepano"))
                    'txtPasillo.Text = CStr(dr("Pasillo"))
                    'txtRelacionAnterior.Text = CStr(dr("RelacionAnterior"))
                    'txtCajaAnterior.Text = CStr(dr("CajaAnterior"))
                    'txtItemAnterior.Text = CStr(dr("ItemAnterior"))


                    txtCaja.Text = CStr(dr("RelacionAnterior"))
                    txtAnaquel.Text = CStr(dr("CajaAnterior"))
                    txtEntrepano.Text = CStr(dr("CampoAdicional3"))
                    txtPasillo.Text = CStr(dr("ItemAnterior"))

                    txtCajaAnterior.Text = CStr(dr("Caja"))
                    txtRelacionAnterior.Text = CStr(dr("Anaquel"))
                    txtItemAnterior.Text = CStr(dr("Pasillo"))
                    txtObservConcentracion.Text = CStr(dr("Entrepano"))



                    txtFechaDeCreacion.Text = dr("FechaDeCreacionDMA")
                    lblElaborPor.Text = Mid(Get_UsuarioReal_from_ID(CInt(dr("idUsuario_ElaboradoPor"))), 1, 20)
                    chkbxParteDelDocumento.Checked = CBool(dr("ClasificaSoloParte"))
                    txtFojas.Text = CStr(dr("FojasParte"))
                    txtFechaDeClasificacion.Text = IIf(dr("FechaClasificacionDMA") = "1/1/1900" Or dr("FechaClasificacionDMA") = "01/01/1900", "", dr("FechaClasificacionDMA"))
                    txtFechaPropuestaDesclasificacion.Text = IIf(dr("FechaPropuestaDesclasificacionDMA") = "1/1/1900" Or dr("FechaPropuestaDesclasificacionDMA") = "01/01/1900", "", dr("FechaPropuestaDesclasificacionDMA"))
                    txtNuevaFechaPropuestaDesclasificacion.Text = IIf(CBool(dr("NuevaFechaDesclasificacionChecked")), dr("NuevaFechaDesclasificacionDMA"), "")
                    chkbxNuevaParteDelDocumento.Checked = CBool(dr("NuevaClasificaSoloParte"))
                    txtNuevaFojas.Text = IIf(CBool(dr("NuevaClasificaSoloParte")), dr("NuevaFojasParte"), "")
                    lblAutorizaNuevaDesc.Text = Get_UsuarioReal_from_ID(CInt(dr("idUsuario_AutorizaAmpliacionClasificacion")))
                    txtFechaDesclasificacion.Text = IIf(CBool(dr("FechaDeDesclasificacionChecked")), dr("FechaDeDesclasificacionDMA"), "")
                    lblAutorizaDesclasificacion.Text = Get_UsuarioReal_from_ID(CInt(dr("idUsuario_AutorizaDesClasificacion")))

                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", CInt(dr("idClasificacionStatus")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", CInt(dr("idPlazoTramite")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", CInt(dr("idPlazoConcentracion")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", CInt(dr("idDestinoFinal")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), lbxCalidadDoc, "CalidadDocumental_SELECTALL", "idCalidadDocumental", "Descripcion", CInt(dr("idCalidadDocumental")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), lbxUnidadAdmin, "UnidadesAdministrativasDeUnUsuarioReal", CInt(Session("IDUsuarioReal")), "idUnidadAdministrativa", "NombreCorto", CInt(dr("idUnidadAdministrativa")))

                    lblUltimaedicion.Text = Mid(Get_UsuarioReal_from_ID(CInt(dr("idUsuarioUltimaEdicion"))), 1, 20)
                    txtRFC.Text = CStr(dr("CampoAdicional1"))
                    txtTipo.Text = CStr(dr("CampoAdicional2"))

                End While

                'Me conviene leer los CheckListBoxes cada vez que cambio de nodo
                'porque aunque siempre son los mismos, el sp me ordena primero los que se utilizan
                'en este nodo

                'Fundamentos Legales de Clasificacion de Expedientes
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbFundamentosLegalesClasificacion, "CargaFundamentosLegalesDeClasificacionDeExpedientes", idExpediente, "idFundamentosLegalesDeClasificacion", "Descripcion", "Activo")

                'Valor Documental de Expedientes
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbxValorDocumental, "CargaValorDocumentalDeExpedientes", idExpediente, "idValorDocumental", "Descripcion", "Activo")

                'Fundamentos Legales De Destino Final de Expedientes
                '********************************************************************
                FillListBox2(Session("UsuarioVirtualConnString"), lbxFundamentosLegalesDestinoFinal, "CargaFundamentosLegalesDeDestinoFinalDeExpedientes", idExpediente, "idFundamentoLegalDeDestinoFinal", "Descripcion", "Activo")

                FillMovimientos(idExpediente)
                FillPDF(idExpediente)

                btnAgregar.Enabled = True
                btnEditar.Enabled = True
                btnBorrar.Enabled = True
                btnCaratula.Enabled = True
                btnCaratula2.Enabled = True
                btnLomo.Enabled = True

                FillExpediente = True
            Else
                btnAgregar.Enabled = True
                btnEditar.Enabled = False
                btnBorrar.Enabled = False
                btnCaratula.Enabled = False
                btnCaratula2.Enabled = False
                btnLomo.Enabled = False

                FillExpediente = False
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            FillExpediente = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Sub LimpiaCampos()

        txtCodigo.Text = ""
        txtExpediente.Text = ""
        txtTipo.Text = ""
        txtRFC.Text = ""
        txtNoDeFojas.Text = ""
        txtNombre.Text = ""
        txtFechaApertura.Text = ""
        txtFechaCierre.Text = ""
        txtFechaPaseBajaHistorico.Text = ""
        txtCaja.Text = ""
        txtAnaquel.Text = ""
        txtPasillo.Text = ""
        txtEntrepano.Text = ""
        txtRelacionAnterior.Text = ""
        txtCajaAnterior.Text = ""
        txtItemAnterior.Text = ""
        txtFechaDeCreacion.Text = ""
        lbJerarquia.Items.Clear()
        lblElaborPor.Text = ""
        lblUltimaedicion.Text = ""

        chkbxParteDelDocumento.Checked = False
        txtFojas.Text = ""
        txtFechaDeClasificacion.Text = ""
        txtFechaPropuestaDesclasificacion.Text = ""
        txtNuevaFechaPropuestaDesclasificacion.Text = ""
        chkbxNuevaParteDelDocumento.Checked = False
        txtNuevaFojas.Text = ""
        txtFechaDesclasificacion.Text = ""
        lblAutorizaDesclasificacion.Text = ""

        FillMovimientos(-1)
        FillPDF(-1)

    End Sub

    Sub MuestraStatus()

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Select Case Session("ExpedienteStatus")
            Case 0  '0=SOLO LECTURA
                lblExpedienteStatus.Text = "(SÓLO LECTURA)"
                lblExpedienteStatus.ForeColor = Drawing.Color.Red
            Case 1  '1=AÑADIENDO
                lblExpedienteStatus.Text = "(EDITABLE)"
                lblExpedienteStatus.ForeColor = Drawing.Color.Green
            Case 2  '2=EDITANDO
                lblExpedienteStatus.Text = "(EDITABLE)"
                lblExpedienteStatus.ForeColor = Drawing.Color.Green
            Case 3  '3=BORRANDO
                lblExpedienteStatus.Text = "(SÓLO LECTURA)"
                lblExpedienteStatus.ForeColor = Drawing.Color.Red
        End Select

    End Sub

    Function FillJerarquia(ByVal CodigoCompleto As String) As Boolean

        'Rutina para llenar el ListBox de Jeraraquía

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter
        Dim dr As Data.OleDb.OleDbDataReader

        Try

            lbJerarquia.Items.Clear()

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
                    lbJerarquia.Items.Insert(CInt(dr("orden")) - 1, CStr(dr("Nombre")) & " " & CStr(dr("Descripcion")))

                    'Aunque paso por aquí tantas veces como niveles tenga el código,
                    'estas variables se quedan con el valor del último nivel del código,
                    'que es precisamente el que me interesa para heredárselo al expediente
                    Session("idPlazoDeConservacionTramiteActivo") = CInt(dr("idPlazoDeConservacionTramite"))
                    Session("idPlazoDeConservacionConcentracionActivo") = CInt(dr("idPlazoDeConservacionConcentracion"))
                    Session("idDestinoFinalActivo") = CInt(dr("idDestinoFinal"))
                    Session("idInformacionClasificadaActivo") = CInt(dr("idInformacionClasificada"))
                    Session("idClasificacionActivo") = CInt(dr("idClasificacion"))
                End While
                FillJerarquia = True
            Else
                FillJerarquia = False
            End If

            'Cierro el DataReader, la colección de parámetros, y la conexión
            dr.Close()
            cmd.Parameters.Clear()
            cn.Close()

        Catch ex As Exception
            FillJerarquia = False
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If
            'MsgBox(ex.Message.ToString)

        End Try

    End Function

    Public Function Get_UsuarioReal_from_ID(ByVal idUsuarioReal As Integer) As String

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Get_UsuarioReal_from_ID"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idUsuarioReal
            param = cmd.Parameters.Add("idUsuarioReal", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuarioReal

            'Nombre
            param = cmd.Parameters.Add("Nombre", Data.OleDb.OleDbType.VarChar, 50)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            Get_UsuarioReal_from_ID = CStr(cmd.Parameters("Nombre").Value)

            cn.Close()

        Catch ex As Exception

            'Windows.Forms.MessageBox.Show(ex.Message.ToString)
            Get_UsuarioReal_from_ID = ""
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

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

    Private Sub btnLocalizacion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLocalizacion.Click
        PLocalizacion.Visible = True
        PClasificacion.Visible = False
        PAtributos.Visible = False
        PPDFs.Visible = False
    End Sub

    Private Sub btnClasificacion_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClasificacion.Click
        PLocalizacion.Visible = False
        PClasificacion.Visible = True
        PAtributos.Visible = False
        PPDFs.Visible = False
    End Sub

    Private Sub btnAtributos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAtributos.Click
        PLocalizacion.Visible = False
        PClasificacion.Visible = False
        PAtributos.Visible = True
        PPDFs.Visible = False
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

    Protected Sub btnAgregar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAgregar.Click

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("ExpedienteStatus") = 1
        MuestraStatus()

        btnSalvar.Text = "Salvar"
        btnSalvar.Enabled = True
        btnCancelar.Enabled = True
        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False
        btnCaratula.Enabled = False
        btnCaratula2.Enabled = False
        btnLomo.Enabled = False

        EnableDisableControls1(True)
        Button2.Enabled = False
        EnableDisableControls2(False)

        LimpiaCampos()
        'txtCodigo.Focus()

    End Sub

    Sub EnableDisableControls1(ByVal MySwitch As Boolean)

        txtCodigo.Enabled = MySwitch
        btnAbreEscogeCuadro.Enabled = MySwitch
        'txtExpediente.Enabled = MySwitch 'Comentado porque el No. de Expediente se genera automaticamente
        txtTipo.Enabled = MySwitch
        txtRFC.Enabled = MySwitch
        txtNoDeFojas.Enabled = MySwitch
        txtNombre.Enabled = MySwitch
        txtFechaApertura.Enabled = MySwitch
        txtFechaCierre.Enabled = MySwitch
        txtFechaPaseBajaHistorico.Enabled = MySwitch
        lbxUnidadAdmin.Enabled = MySwitch
        lbxCalidadDoc.Enabled = MySwitch
        txtCaja.Enabled = MySwitch
        txtAnaquel.Enabled = MySwitch
        txtPasillo.Enabled = MySwitch
        txtEntrepano.Enabled = MySwitch
        txtRelacionAnterior.Enabled = MySwitch
        txtCajaAnterior.Enabled = MySwitch
        txtItemAnterior.Enabled = MySwitch
        txtObservConcentracion.Enabled = MySwitch
        'txtFechaDeCreacion.Enabled = MySwitch

        If Session("idExpedienteActivo") <> -1 Then
            Button2.Enabled = MySwitch
        Else
            Button2.Enabled = False
        End If

    End Sub

    Sub EnableDisableControls2(ByVal MySwitch As Boolean)

        ddlstStatus.Enabled = MySwitch
        chkbxParteDelDocumento.Enabled = MySwitch
        txtFojas.Enabled = MySwitch
        txtFechaDeClasificacion.Enabled = MySwitch
        txtFechaPropuestaDesclasificacion.Enabled = MySwitch
        lbFundamentosLegalesClasificacion.Enabled = MySwitch
        txtNuevaFechaPropuestaDesclasificacion.Enabled = MySwitch
        chkbxNuevaParteDelDocumento.Enabled = MySwitch
        txtNuevaFojas.Enabled = MySwitch
        txtFechaDesclasificacion.Enabled = MySwitch
        lbxValorDocumental.Enabled = MySwitch
        ddlstTramite.Enabled = MySwitch
        ddlstConcentracion.Enabled = MySwitch
        ddlstDestinoFinal.Enabled = MySwitch
        lbxFundamentosLegalesDestinoFinal.Enabled = MySwitch

    End Sub

    Protected Sub btnEditar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEditar.Click
        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("ExpedienteStatus") = 2
        MuestraStatus()

        btnSalvar.Text = "Salvar"
        btnSalvar.Enabled = True
        btnCancelar.Enabled = True
        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False
        btnCaratula.Enabled = False
        btnCaratula2.Enabled = False
        btnLomo.Enabled = False


        EnableDisableControls1(True)
        EnableDisableControls2(True)

        'LimpiaCampos()
        'txtCodigo.Focus()

    End Sub

    Protected Sub btnBorrar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBorrar.Click
        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("ExpedienteStatus") = 3
        MuestraStatus()

        btnSalvar.Text = "Borrar"
        btnSalvar.Enabled = True
        btnCancelar.Enabled = True
        btnAgregar.Enabled = False
        btnEditar.Enabled = False
        btnBorrar.Enabled = False
        btnCaratula.Enabled = False
        btnCaratula2.Enabled = False
        btnLomo.Enabled = False


        EnableDisableControls1(False)
        EnableDisableControls2(False)

        'LimpiaCampos()
        'txtCodigo.Focus()

    End Sub

    Protected Sub btnCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelar.Click

        'Dim b As Boolean = FechaCorrecta(txtFechaApertura.Text)

        '0=SOLO LECTURA 1=AÑADIENDO 2=EDITANDO 3=BORRANDO
        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        MuestraStatus()
        'If Page.IsValid Then

        btnSalvar.Text = "Salvar"
        btnSalvar.Enabled = False
        btnCancelar.Enabled = False
        btnAgregar.Enabled = True
        btnEditar.Enabled = True
        btnBorrar.Enabled = True
        btnCaratula.Enabled = True
        btnCaratula2.Enabled = True
        btnLomo.Enabled = True


        EnableDisableControls1(False)
        EnableDisableControls2(False)

        'End If
        'Session("YaHeredeAtributos") = 0
        'ValidaExpedienteVacio.Enabled = False
        Response.Redirect("./DisplayExpediente.aspx")

    End Sub

    Private Sub btnSalvar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSalvar.Click
        'Agregar o editar un expediente

        'Dim MyFaultControl As Control

        Dim IDExpedienteInsertado As Integer
        Dim IDExpedienteInsertado2 As Integer

        Dim IDExpedienteEditado As Integer
        Dim IDExpedienteEditado2 As Integer

        Dim MyFechaCierre As Date
        Dim MyFechaPaseBajaHistorico As Date
        Dim MyFechaDeClasificacion As Date
        Dim MyFechaPropuestaDesclasificacion As Date
        Dim MyNuevaFechaPropuestaDesclasificacion As Date
        Dim MyFechaDesclasificacion As Date

        Try
            'Cursor.Current = Cursors.WaitCursor
            'Application.DoEvents()

            'If Not FindFirstEmptyControl(CType(Me, Form), MyFaultControl) Then

            'If Not FindFirstEmptyControlSpecial() Then

            If Not RevisaForma() Then
                Return
            End If

            'Guardo los valores de las fechas para arrastre

            'FechaDeClasificacionParaArrastre = dtpFechaDeClasificacion.Value
            'FechaPropuestaDeDesclasificacionParaArrastre = dtpFechaPropuestaDeDesclasificacion.Value
            'NuevaFechaDeDesclasificacionParaArrastre = dtpNuevaFechaDesclasificacion.GIT_Value
            'FechaDeDesclasificacionParaArrastre = dtpFechaDesclasificacion.GIT_Value

            'FechaAperturaParaArrastre = dtpFechaApertura.Value
            'FechaCierreParaArrastre = dtpFechaCierre.GIT_Value
            'FechaBajaParaArrastre = dtpFechaDeBaja.GIT_Value
            'FechaCreacionParaArrastre = dtpFechaCreacion.Value

            'Añadiendo un record nuevo
            If Session("ExpedienteStatus") = 1 Then

                'Debo tratar aparte las fechas que en la version convencional 
                'de la aplicacion tienen checkmark

                If Trim(txtFechaCierre.Text) = "" Then
                    MyFechaCierre = CDate("1/1/1900")
                Else
                    MyFechaCierre = CDate(Trim(txtFechaCierre.Text))
                End If

                If Trim(txtFechaPaseBajaHistorico.Text) = "" Then
                    MyFechaPaseBajaHistorico = CDate("1/1/1900")
                Else
                    MyFechaPaseBajaHistorico = CDate(Trim(txtFechaPaseBajaHistorico.Text))
                End If

                'IDExpedienteInsertado = Expedientes_INSERT( _
                '    Session("idClasificacionActivo"), _
                '    CStr(IIf(Trim(txtExpediente.Text) = "", "?", Trim(txtExpediente.Text))), _
                '    Trim(txtNombre.Text), _
                '    CInt(IIf(Trim(txtNoDeFojas.Text) = "", "0", Trim(txtNoDeFojas.Text))), _
                '    CDate(Trim(txtFechaApertura.Text)), _
                '    MyFechaCierre, _
                '    IIf(Trim(txtFechaCierre.Text) = "", False, True), _
                '    MyFechaPaseBajaHistorico, _
                '    IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", False, True), _
                '    CInt(IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                '    txtCaja.Text, _
                '    txtPasillo.Text, _
                '    txtAnaquel.Text, _
                '    txtEntrepano.Text, _
                '    txtRelacionAnterior.Text, _
                '    txtCajaAnterior.Text, _
                '    txtItemAnterior.Text, _
                '    Now(), _
                '    CInt(Session("IDUsuarioReal")), _
                '    txtRFC.Text, _
                '    txtTipo.Text, _
                '    CInt(Session("IDUsuarioReal")), _
                '    lbxUnidadAdmin.SelectedItem.Value, _
                '    lbxCalidadDoc.SelectedItem.Value)

                IDExpedienteInsertado = Expedientes_INSERT( _
                    Session("idClasificacionActivo"), _
                    CStr(IIf(Trim(txtExpediente.Text) = "", "?", Trim(txtExpediente.Text))), _
                    Trim(txtNombre.Text), _
                    CInt(IIf(Trim(txtNoDeFojas.Text) = "", "0", Trim(txtNoDeFojas.Text))), _
                    CDate(Trim(txtFechaApertura.Text)), _
                    MyFechaCierre, _
                    IIf(Trim(txtFechaCierre.Text) = "", False, True), _
                    MyFechaPaseBajaHistorico, _
                    IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", False, True), _
                    CInt(IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                     txtCajaAnterior.Text, _
                     txtItemAnterior.Text, _
                     txtRelacionAnterior.Text, _
                     txtObservConcentracion.Text, _
                     txtCaja.Text, _
                     txtAnaquel.Text, _
                     txtPasillo.Text, _
                    Now(), _
                    CInt(Session("IDUsuarioReal")), _
                    txtRFC.Text, _
                    txtTipo.Text, _
                    CInt(Session("IDUsuarioReal")), _
                    lbxUnidadAdmin.SelectedItem.Value, _
                    lbxCalidadDoc.SelectedItem.Value, _
                     txtEntrepano.Text)


                'CDate(Trim(txtFechaDeCreacion.Text)), _



                'CInt(CType(cbUnidadAdministrativa.SelectedItem, ComboBoxLine).LineItemData), _
                'CInt(CType(cbCalidadDocumental.SelectedItem, ComboBoxLine).LineItemData))

                'CInt(CType(cbUnidadAdministrativa.SelectedItem, MyComboBoxLine).MyLineItemData), _
                'CInt(CType(cbCalidadDocumental.SelectedItem, MyComboBoxLine).MyLineItemData))

                If IDExpedienteInsertado > 0 Then

                    '    'Para el record recién agregado, intento hacer un UPDATE_2 con los datos
                    '    'de sus atributos. Primero utilizo la conexión del usuario virtual.
                    '    'Si falla (porque dicho usuario no tiene permisos para el UPDATE_2),
                    '    'recupero los valores originales de los atributos, y los salvo con la
                    '    'conexión del DBOWNER.

                    '    IDExpedienteInsertado2 = Expedientes_UPDATE_2( _
                    '        MyConnectionString, _
                    '        IDExpedienteInsertado, _
                    '        CType(cbClasificacionStatus.SelectedItem, ComboBoxLine).LineItemData, _
                    '        cbParteDelDocumento.Checked, _
                    '        txtParteFojas.Text, _
                    '        dtpFechaDeClasificacion.Value, _
                    '        True, _
                    '        dtpFechaPropuestaDeDesclasificacion.Value, _
                    '        True, _
                    '        dtpNuevaFechaDesclasificacion.GIT_Value, _
                    '        dtpNuevaFechaDesclasificacion.GIT_Checked, _
                    '        cbNuevaParteDelDocumento.Checked, _
                    '        txtNuevaParteFojas.Text, _
                    '        CInt(IIf(dtpNuevaFechaDesclasificacion.GIT_Checked, MyidUsuarioReal, -1)), _
                    '        dtpFechaDesclasificacion.GIT_Value, _
                    '        dtpFechaDesclasificacion.GIT_Checked, _
                    '        CInt(IIf(dtpFechaDesclasificacion.GIT_Checked, MyidUsuarioReal, -1)), _
                    '        CType(cbPlazoTramite.SelectedItem, ComboBoxLine).LineItemData, _
                    '        CType(cbPlazoConcentracion.SelectedItem, ComboBoxLine).LineItemData, _
                    '        CType(cbDestinoFinal.SelectedItem, ComboBoxLine).LineItemData)

                    '    If IDExpedienteInsertado2 = 0 Then

                    '        MsgBox("Los atributos serán heredados del Cuadro de Clasificación Archivística", CType(MsgBoxStyle.Information + MsgBoxStyle.OkOnly, MsgBoxStyle))

                    '        FillCombo(MyConnectionString, cbClasificacionStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", idInformacionClasificadaActivo)
                    '        FillCombo(MyConnectionString, cbPlazoTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", idPlazoDeConservacionTramiteActivo)
                    '        FillCombo(MyConnectionString, cbPlazoConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", idPlazoDeConservacionConcentracionActivo)
                    '        FillCombo(MyConnectionString, cbDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", idDestinoFinalActivo)

                    '        CopiaValorDocumental(idClasificacionActivo)
                    '        CopiaFundamentosLegalesDeDestinoFinal(idClasificacionActivo)
                    '        CopiaFundamentosLegalesDeClasificacion(idClasificacionActivo)

                    'Debo tratar aparte las fechas 

                    If Trim(txtFechaDeClasificacion.Text) = "" Then
                        MyFechaDeClasificacion = CDate("1/1/1900")
                    Else
                        MyFechaDeClasificacion = CDate(Trim(txtFechaDeClasificacion.Text))
                    End If

                    If Trim(txtFechaPropuestaDesclasificacion.Text) = "" Then
                        MyFechaPropuestaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyFechaPropuestaDesclasificacion = CDate(Trim(txtFechaPropuestaDesclasificacion.Text))
                    End If

                    If Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "" Then
                        MyNuevaFechaPropuestaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyNuevaFechaPropuestaDesclasificacion = CDate(Trim(txtNuevaFechaPropuestaDesclasificacion.Text))
                    End If

                    If Trim(txtFechaDesclasificacion.Text) = "" Then
                        MyFechaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyFechaDesclasificacion = CDate(Trim(txtFechaDesclasificacion.Text))
                    End If

                    IDExpedienteInsertado2 = Expedientes_UPDATE_2( _
                        Session("AdminConnString"), _
                        IDExpedienteInsertado, _
                        ddlstStatus.SelectedItem.Value, _
                        chkbxParteDelDocumento.Checked, _
                        txtFojas.Text, _
                        MyFechaDeClasificacion, _
                        True, _
                        MyFechaPropuestaDesclasificacion, _
                        True, _
                        MyNuevaFechaPropuestaDesclasificacion, _
                        IIf(Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "", False, True), _
                        chkbxNuevaParteDelDocumento.Checked, _
                        txtNuevaFojas.Text, _
                        CInt(IIf(Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                        MyFechaDesclasificacion, _
                        IIf(Trim(txtFechaDesclasificacion.Text) = "", False, True), _
                        CInt(IIf(Trim(txtFechaDesclasificacion.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                        ddlstTramite.SelectedItem.Value, _
                        ddlstConcentracion.SelectedItem.Value, _
                        ddlstDestinoFinal.SelectedItem.Value)
                    'End If

                    'También tengo que revisar los checklistboxes de ValorDocumental,
                    'Fundamentos Legales de Clasificación y de Baja para generar  
                    'en las tablas de relaciones, los records correspondientes a los checkmarks 

                    'Valor Documental
                    'Primero borro todas las relaciones anteriores (por si las hubiera) 
                    If ValorDocumental_Expedientes_Relaciones_DELETE_ALL(IDExpedienteInsertado) <> IDExpedienteInsertado Then
                        'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                    End If
                    'Y ahora ingreso un record por cada checkmark
                    For i As Integer = 0 To lbxValorDocumental.Items.Count - 1
                        'If clbValorDocumental.GetItemChecked(i) Then
                        If lbxValorDocumental.Items(i).Selected Then
                            If ValorDocumental_Expedientes_Relaciones_INSERT(IDExpedienteInsertado, lbxValorDocumental.Items(i).Value) <> IDExpedienteInsertado Then
                                'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                            End If
                        End If
                    Next

                    'Fundamentos Legales de Destino Final
                    'Primero borro todas las relaciones anteriores (por si las hubiera) 
                    If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL(IDExpedienteInsertado) <> IDExpedienteInsertado Then
                        'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                    End If
                    'Y ahora ingreso un record por cada checkmark
                    For i As Integer = 0 To lbxFundamentosLegalesDestinoFinal.Items.Count - 1
                        If lbxFundamentosLegalesDestinoFinal.Items(i).Selected Then
                            If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT(IDExpedienteInsertado, lbxFundamentosLegalesDestinoFinal.Items(i).Value) <> IDExpedienteInsertado Then
                                'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                            End If
                        End If
                    Next

                    'Fundamentos Legales de Clasificación
                    'Primero borro todas las relaciones anteriores (por si las hubiera) 
                    If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL(IDExpedienteInsertado) <> IDExpedienteInsertado Then
                        'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                    End If
                    'Y ahora ingreso un record por cada checkmark
                    For i As Integer = 0 To lbFundamentosLegalesClasificacion.Items.Count - 1
                        If lbFundamentosLegalesClasificacion.Items(i).Selected Then
                            If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT(IDExpedienteInsertado, lbFundamentosLegalesClasificacion.Items(i).Value) <> IDExpedienteInsertado Then
                                'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                            End If
                        End If
                    Next

                    '    EstoyAgregandoExpediente = False

                    '    'Cargo los datos del expediente insertado
                    '    FillForm(IDExpedienteInsertado)
                    Session("IDExpedienteActivo") = IDExpedienteInsertado
                    FillExpediente(CInt(Session("IDExpedienteActivo")))
                Else
                    '    Cursor.Current = Cursors.Default
                    Return
                End If

            ElseIf Session("ExpedienteStatus") = 2 Then

                '    IDExpedienteEditado = Expedientes_UPDATE( _
                '        idExpedienteActivo, _
                '        idClasificacionActivo, _
                '        CStr(IIf(Trim(txtExpediente.Text) = "", "?", txtExpediente.Text)), _
                '        txtAsunto.Text, _
                '        CInt(txtTotalFojas.Text), _
                '        dtpFechaApertura.Value, _
                '        dtpFechaCierre.GIT_Value, _
                '        dtpFechaCierre.GIT_Checked, _
                '        dtpFechaDeBaja.GIT_Value, _
                '        dtpFechaDeBaja.GIT_Checked, _
                '        CInt(IIf(dtpFechaDeBaja.GIT_Checked, MyidUsuarioReal, -1)), _
                '        txtCaja.Text, _
                '        txtPasillo.Text, _
                '        txtAnaquel.Text, _
                '        txtEntrepano.Text, _
                '        txtRelacionAnterior.Text, _
                '        txtCajaAnterior.Text, _
                '        txtItemAnterior.Text, _
                '        dtpFechaCreacion.Value, _
                '        txtRFC.Text, _
                '        txtTipo.Text, _
                '        MyidUsuarioReal, _
                '        CType(cbUnidadAdministrativa.SelectedItem, ComboBoxLine).LineItemData, _
                '        CType(cbCalidadDocumental.SelectedItem, ComboBoxLine).LineItemData)

                If Trim(txtFechaCierre.Text) = "" Then
                    MyFechaCierre = CDate("1/1/1900")
                Else
                    MyFechaCierre = CDate(Trim(txtFechaCierre.Text))
                End If

                If Trim(txtFechaPaseBajaHistorico.Text) = "" Then
                    MyFechaPaseBajaHistorico = CDate("1/1/1900")
                Else
                    MyFechaPaseBajaHistorico = CDate(Trim(txtFechaPaseBajaHistorico.Text))
                End If

                IDExpedienteEditado = Expedientes_UPDATE( _
                    Session("idExpedienteActivo"), _
                    Session("idClasificacionActivo"), _
                    CStr(IIf(Trim(txtExpediente.Text) = "", "?", Trim(txtExpediente.Text))), _
                    Trim(txtNombre.Text), _
                    CInt(IIf(Trim(txtNoDeFojas.Text) = "", "0", Trim(txtNoDeFojas.Text))), _
                    CDate(Trim(txtFechaApertura.Text)), _
                    MyFechaCierre, _
                    IIf(Trim(txtFechaCierre.Text) = "", False, True), _
                    MyFechaPaseBajaHistorico, _
                    IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", False, True), _
                    CInt(IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                                         txtCajaAnterior.Text, _
                     txtItemAnterior.Text, _
                                          txtRelacionAnterior.Text, _
                     txtObservConcentracion.Text, _
                     txtCaja.Text, _
                     txtAnaquel.Text, _
                     txtPasillo.Text, _
                    CDate(Trim(txtFechaDeCreacion.Text)), _
                    txtRFC.Text, _
                    txtTipo.Text, _
                    CInt(Session("IDUsuarioReal")), _
                    lbxUnidadAdmin.SelectedItem.Value, _
                    lbxCalidadDoc.SelectedItem.Value, _
                     txtEntrepano.Text)


                'IDExpedienteEditado = Expedientes_UPDATE( _
                '    Session("idExpedienteActivo"), _
                '    Session("idClasificacionActivo"), _
                '    CStr(IIf(Trim(txtExpediente.Text) = "", "?", Trim(txtExpediente.Text))), _
                '    Trim(txtNombre.Text), _
                '    CInt(IIf(Trim(txtNoDeFojas.Text) = "", "0", Trim(txtNoDeFojas.Text))), _
                '    CDate(Trim(txtFechaApertura.Text)), _
                '    MyFechaCierre, _
                '    IIf(Trim(txtFechaCierre.Text) = "", False, True), _
                '    MyFechaPaseBajaHistorico, _
                '    IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", False, True), _
                '    CInt(IIf(Trim(txtFechaPaseBajaHistorico.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                '    txtCaja.Text, _
                '    txtPasillo.Text, _
                '    txtAnaquel.Text, _
                '    txtEntrepano.Text, _
                '    txtRelacionAnterior.Text, _
                '    txtCajaAnterior.Text, _
                '    txtItemAnterior.Text, _
                '    CDate(Trim(txtFechaDeCreacion.Text)), _
                '    txtRFC.Text, _
                '    txtTipo.Text, _
                '    CInt(Session("IDUsuarioReal")), _
                '    lbxUnidadAdmin.SelectedItem.Value, _
                '    lbxCalidadDoc.SelectedItem.Value)




                If IDExpedienteEditado > 0 Then

                    '        'Para el record recién agregado, intento hacer un UPDATE_2 con los datos
                    '        'de sus atributos. Primero utilizo la conexión del usuario virtual.
                    '        'Si falla (porque dicho usuario no tiene permisos para el UPDATE_2),
                    '        'no salvo los atributos y leo los que había desde antes, mediante el fillform

                    '        IDExpedienteEditado2 = Expedientes_UPDATE_2( _
                    '            MyConnectionString, _
                    '            IDExpedienteEditado, _
                    '            CType(cbClasificacionStatus.SelectedItem, ComboBoxLine).LineItemData, _
                    '            cbParteDelDocumento.Checked, _
                    '            txtParteFojas.Text, _
                    '            dtpFechaDeClasificacion.Value, _
                    '            True, _
                    '            dtpFechaPropuestaDeDesclasificacion.Value, _
                    '            True, _
                    '            dtpNuevaFechaDesclasificacion.GIT_Value, _
                    '            dtpNuevaFechaDesclasificacion.GIT_Checked, _
                    '            cbNuevaParteDelDocumento.Checked, _
                    '            txtNuevaParteFojas.Text, _
                    '            CInt(IIf(dtpNuevaFechaDesclasificacion.GIT_Checked, MyidUsuarioReal, -1)), _
                    '            dtpFechaDesclasificacion.GIT_Value, _
                    '            dtpFechaDesclasificacion.GIT_Checked, _
                    '            CInt(IIf(dtpFechaDesclasificacion.GIT_Checked, MyidUsuarioReal, -1)), _
                    '            CType(cbPlazoTramite.SelectedItem, ComboBoxLine).LineItemData, _
                    '            CType(cbPlazoConcentracion.SelectedItem, ComboBoxLine).LineItemData, _
                    '            CType(cbDestinoFinal.SelectedItem, ComboBoxLine).LineItemData)


                    If Trim(txtFechaDeClasificacion.Text) = "" Then
                        MyFechaDeClasificacion = CDate("1/1/1900")
                    Else
                        MyFechaDeClasificacion = CDate(Trim(txtFechaDeClasificacion.Text))
                    End If

                    If Trim(txtFechaPropuestaDesclasificacion.Text) = "" Then
                        MyFechaPropuestaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyFechaPropuestaDesclasificacion = CDate(Trim(txtFechaPropuestaDesclasificacion.Text))
                    End If

                    If Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "" Then
                        MyNuevaFechaPropuestaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyNuevaFechaPropuestaDesclasificacion = CDate(Trim(txtNuevaFechaPropuestaDesclasificacion.Text))
                    End If

                    If Trim(txtFechaDesclasificacion.Text) = "" Then
                        MyFechaDesclasificacion = CDate("1/1/1900")
                    Else
                        MyFechaDesclasificacion = CDate(Trim(txtFechaDesclasificacion.Text))
                    End If

                    IDExpedienteEditado2 = Expedientes_UPDATE_2( _
                        Session("AdminConnString"), _
                        IDExpedienteEditado, _
                        ddlstStatus.SelectedItem.Value, _
                        chkbxParteDelDocumento.Checked, _
                        txtFojas.Text, _
                        MyFechaDeClasificacion, _
                        True, _
                        MyFechaPropuestaDesclasificacion, _
                        True, _
                        MyNuevaFechaPropuestaDesclasificacion, _
                        IIf(Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "", False, True), _
                        chkbxNuevaParteDelDocumento.Checked, _
                        txtNuevaFojas.Text, _
                        CInt(IIf(Trim(txtNuevaFechaPropuestaDesclasificacion.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                        MyFechaDesclasificacion, _
                        IIf(Trim(txtFechaDesclasificacion.Text) = "", False, True), _
                        CInt(IIf(Trim(txtFechaDesclasificacion.Text) = "", -1, CInt(Session("IDUsuarioReal")))), _
                        ddlstTramite.SelectedItem.Value, _
                        ddlstConcentracion.SelectedItem.Value, _
                        ddlstDestinoFinal.SelectedItem.Value)





                    If IDExpedienteEditado2 = 0 Then

                    Else
                        'También tengo que revisar los checklistboxes de ValorDocumental,
                        'Fundamentos Legales de Clasificación y de Baja para generar  
                        'en las tablas de relaciones, los records correspondientes a los checkmarks 

                        '            'Valor Documental
                        '            'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        '            If ValorDocumental_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                        '                Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                        '            End If
                        '            'Y ahora ingreso un record por cada checkmark
                        '            For i As Integer = 0 To clbValorDocumental.Items.Count - 1
                        '                If clbValorDocumental.GetItemChecked(i) Then
                        '                    If ValorDocumental_Expedientes_Relaciones_INSERT(IDExpedienteEditado, CInt(CType(clbValorDocumental.Items(i), ComboBoxLine).LineItemData)) <> IDExpedienteEditado Then
                        '                        Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                        '                    End If
                        '                End If
                        '            Next

                        '            'Fundamentos Legales de Destino Final
                        '            'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        '            If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                        '                Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                        '            End If
                        '            'Y ahora ingreso un record por cada checkmark
                        '            For i As Integer = 0 To clFundamentosLegalesDeDestinoFinal.Items.Count - 1
                        '                If clFundamentosLegalesDeDestinoFinal.GetItemChecked(i) Then
                        '                    If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT(IDExpedienteEditado, CInt(CType(clFundamentosLegalesDeDestinoFinal.Items(i), ComboBoxLine).LineItemData)) <> IDExpedienteEditado Then
                        '                        Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                        '                    End If
                        '                End If
                        '            Next

                        '            'Fundamentos Legales de Clasificación
                        '            'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        '            If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                        '                Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                        '            End If
                        '            'Y ahora ingreso un record por cada checkmark
                        '            For i As Integer = 0 To clbFundamentoLegalDeClasificacion.Items.Count - 1
                        '                If clbFundamentoLegalDeClasificacion.GetItemChecked(i) Then
                        '                    If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT(IDExpedienteEditado, CInt(CType(clbFundamentoLegalDeClasificacion.Items(i), ComboBoxLine).LineItemData)) <> IDExpedienteEditado Then
                        '                        Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                        '                    End If
                        '                End If
                        '            Next

                        'Valor Documental
                        'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        If ValorDocumental_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                            'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en ValorDocumental_Expedientes_Relaciones")
                        End If
                        'Y ahora ingreso un record por cada checkmark
                        For i As Integer = 0 To lbxValorDocumental.Items.Count - 1
                            'If clbValorDocumental.GetItemChecked(i) Then
                            If lbxValorDocumental.Items(i).Selected Then
                                If ValorDocumental_Expedientes_Relaciones_INSERT(IDExpedienteEditado, lbxValorDocumental.Items(i).Value) <> IDExpedienteEditado Then
                                    'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en ValorDocumental_Expedientes_Relaciones")
                                End If
                            End If
                        Next

                        'Fundamentos Legales de Destino Final
                        'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                            'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                        End If
                        'Y ahora ingreso un record por cada checkmark
                        For i As Integer = 0 To lbxFundamentosLegalesDestinoFinal.Items.Count - 1
                            If lbxFundamentosLegalesDestinoFinal.Items(i).Selected Then
                                If FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT(IDExpedienteEditado, lbxFundamentosLegalesDestinoFinal.Items(i).Value) <> IDExpedienteEditado Then
                                    'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones")
                                End If
                            End If
                        Next

                        'Fundamentos Legales de Clasificación
                        'Primero borro todas las relaciones anteriores (por si las hubiera) 
                        If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL(IDExpedienteEditado) <> IDExpedienteEditado Then
                            'Throw New ApplicationException("Se produjo un error al intentar borrar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                        End If
                        'Y ahora ingreso un record por cada checkmark
                        For i As Integer = 0 To lbFundamentosLegalesClasificacion.Items.Count - 1
                            If lbFundamentosLegalesClasificacion.Items(i).Selected Then
                                If FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT(IDExpedienteEditado, lbFundamentosLegalesClasificacion.Items(i).Value) <> IDExpedienteEditado Then
                                    'Throw New ApplicationException("Se produjo un error al intentar agregar relaciones en FundamentosLegalesDeClasificacion_Expedientes_Relaciones")
                                End If
                            End If
                        Next


                    End If

                    '        EstoyEditandoExpediente = False

                    '        'Cargo los datos del expediente insertado
                    '        FillForm(IDExpedienteEditado)

                    Session("IDExpedienteActivo") = IDExpedienteEditado
                    FillExpediente(CInt(Session("IDExpedienteActivo")))

                Else
                    '        Cursor.Current = Cursors.Default
                    Return
                End If

            ElseIf Session("ExpedienteStatus") = 3 Then

                Movimientos_idExpediente_DELETE_ALL(Session("idExpedienteActivo"))

                If Expedientes_DELETE(Session("idExpedienteActivo")) <> Session("idExpedienteActivo") Then
                    'Throw New ApplicationException("Se produjo un error al intentar borrar Expedientes o sus relaciones")
                Else
                    If Session("NextRightActivo") > 0 Then
                        FillExpediente(Session("NextRightActivo"))
                    Else
                        If Session("NextLeftActivo") > 0 Then
                            FillExpediente(Session("NextLeftActivo"))
                        Else
                            FillExpediente(-1)
                        End If
                    End If
                End If

            End If


            'btnAgregar.Enabled = True
            'btnEditar.Enabled = True
            'btnBorrar.Enabled = True
            ''btnBuscar.Enabled = True

            'EnableDisableControles(False)

            'HayCambiosPendientesEnExpediente = False
            'MyStatus()

            Session("ExpedienteStatus") = 0
            Session("MovimientoStatus") = 0
            MuestraStatus()

            btnSalvar.Text = "Salvar"
            btnSalvar.Enabled = False
            btnCancelar.Enabled = False
            btnAgregar.Enabled = True
            btnEditar.Enabled = True
            btnBorrar.Enabled = True
            btnCaratula.Enabled = True
            btnCaratula2.Enabled = True
            btnLomo.Enabled = True


            EnableDisableControls1(False)
            EnableDisableControls2(False)

            'Response.Redirect("./DisplayExpediente.aspx")


            'End If

            'End If

            'Cursor.Current = Cursors.Default
            'Application.DoEvents()

        Catch ex As Exception
            'Cursor.Current = Cursors.Default
            'Application.DoEvents()
            'MsgBox(ex.Message.ToString)
        End Try

    End Sub

    Function Expedientes_DELETE(ByVal idExpediente As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "Expedientes_DELETE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idExpedienteOUTPUT
            param = cmd.Parameters.Add("idExpedienteOUTPUT", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            Expedientes_DELETE = CInt(cmd.Parameters("idExpedienteOUTPUT").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Expedientes_DELETE = -1
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function


    Public Function Movimientos_idExpediente_DELETE_ALL(ByVal idExpediente As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try
            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Movimientos_idExpediente_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idExpedienteBorrado
            param = cmd.Parameters.Add("idExpedienteBorrado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record editado
            Movimientos_idExpediente_DELETE_ALL = CInt(cmd.Parameters("idExpedienteBorrado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Movimientos_idExpediente_DELETE_ALL = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function


    Public Function Expedientes_UPDATE( _
        ByVal idExpediente As Integer, _
        ByVal idClasificacion As Integer, _
        ByVal Nombre As String, _
        ByVal Asunto As String, _
        ByVal NumeroDeFojas As Integer, _
        ByVal FechaApertura As DateTime, _
        ByVal FechaCierre As DateTime, _
        ByVal FechaCierreChecked As Boolean, _
        ByVal FechaDePaseABajaHistorico As DateTime, _
        ByVal FechaDePaseABajaHistoricoChecked As Boolean, _
        ByVal idUsuario_AutorizaBajaHistorico As Integer, _
        ByVal Caja As String, _
        ByVal Pasillo As String, _
        ByVal Anaquel As String, _
        ByVal Entrepano As String, _
        ByVal RelacionAnterior As String, _
        ByVal CajaAnterior As String, _
        ByVal ItemAnterior As String, _
        ByVal FechaDeCreacion As DateTime, _
        ByVal RFC As String, _
        ByVal Tipo As String, _
        ByVal idUsuarioUltimaEdicion As Integer, _
        ByVal idUnidadAdministrativa As Integer, _
        ByVal idCalidadDocumental As Integer, _
        ByVal CampoAdicional3 As String) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Expedientes_UPDATE"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idClasificacion
            param = cmd.Parameters.Add("idClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idClasificacion

            'Nombre
            param = cmd.Parameters.Add("Nombre", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = Nombre

            'Asunto
            param = cmd.Parameters.Add("Asunto", Data.OleDb.OleDbType.VarChar, 250)
            param.Value = Asunto

            'NumeroDeFojas
            param = cmd.Parameters.Add("NumeroDeFojas", Data.OleDb.OleDbType.Integer)
            param.Value = NumeroDeFojas

            'FechaApertura
            param = cmd.Parameters.Add("FechaApertura", Data.OleDb.OleDbType.Date)
            param.Value = FechaApertura

            'FechaCierre
            param = cmd.Parameters.Add("FechaCierre", Data.OleDb.OleDbType.Date)
            param.Value = FechaCierre

            'FechaCierreChecked
            param = cmd.Parameters.Add("FechaCierreChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaCierreChecked

            'FechaDePaseABajaHistorico
            param = cmd.Parameters.Add("FechaDePaseABajaHistorico", Data.OleDb.OleDbType.Date)
            param.Value = FechaDePaseABajaHistorico

            'FechaDePaseABajaHistoricoChecked
            param = cmd.Parameters.Add("FechaDePaseABajaHistoricoChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaDePaseABajaHistoricoChecked

            'idUsuario_AutorizaBajaHistorico
            param = cmd.Parameters.Add("idUsuario_AutorizaBajaHistorico", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuario_AutorizaBajaHistorico

            'Caja
            param = cmd.Parameters.Add("Caja", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Caja

            'Pasillo
            param = cmd.Parameters.Add("Pasillo", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Pasillo

            'Anaquel
            param = cmd.Parameters.Add("Anaquel", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Anaquel

            'Entrepano
            param = cmd.Parameters.Add("Entrepano", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Entrepano

            'RelacionAnterior
            param = cmd.Parameters.Add("RelacionAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = RelacionAnterior

            'CajaAnterior
            param = cmd.Parameters.Add("CajaAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = CajaAnterior

            'ItemAnterior
            param = cmd.Parameters.Add("ItemAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = ItemAnterior

            'FechaDeCreacion
            param = cmd.Parameters.Add("FechaDeCreacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaDeCreacion

            'RFC
            param = cmd.Parameters.Add("RFC", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = RFC

            'Tipo
            param = cmd.Parameters.Add("Tipo", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = Tipo

            'idUsuarioUltimaEdicion
            param = cmd.Parameters.Add("idUsuarioUltimaEdicion", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuarioUltimaEdicion

            'idUnidadAdministrativa
            param = cmd.Parameters.Add("idUnidadAdministrativa", Data.OleDb.OleDbType.Integer)
            param.Value = idUnidadAdministrativa

            'idCalidadDocumental
            param = cmd.Parameters.Add("idCalidadDocumental", Data.OleDb.OleDbType.Integer)
            param.Value = idCalidadDocumental

            'CampoAdicional3
            param = cmd.Parameters.Add("CampoAdicional3", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = CampoAdicional3

            'idExpedienteEditado
            param = cmd.Parameters.Add("idExpedienteEditado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record editado
            Expedientes_UPDATE = CInt(cmd.Parameters("idExpedienteEditado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Expedientes_UPDATE = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Public Function Expedientes_INSERT( _
    ByVal idClasificacion As Integer, _
    ByVal Nombre As String, _
    ByVal Asunto As String, _
    ByVal NumeroDeFojas As Integer, _
    ByVal FechaApertura As DateTime, _
    ByVal FechaCierre As DateTime, _
    ByVal FechaCierreChecked As Boolean, _
    ByVal FechaDePaseABajaHistorico As DateTime, _
    ByVal FechaDePaseABajaHistoricoChecked As Boolean, _
    ByVal idUsuario_AutorizaBajaHistorico As Integer, _
    ByVal Caja As String, _
    ByVal Pasillo As String, _
    ByVal Anaquel As String, _
    ByVal Entrepano As String, _
    ByVal RelacionAnterior As String, _
    ByVal CajaAnterior As String, _
    ByVal ItemAnterior As String, _
    ByVal FechaDeCreacion As DateTime, _
    ByVal idUsuario_ElaboradoPor As Integer, _
    ByVal RFC As String, _
    ByVal Tipo As String, _
    ByVal idUsuarioUltimaEdicion As Integer, _
    ByVal idUnidadAdministrativa As Integer, _
    ByVal idCalidadDocumental As Integer, _
    ByVal CampoAdicional3 As String _
    ) As Integer

        'OJO: ESTOS PARAMETROS SE COMENTAN POR EL DISEÑO DE LA SEGURIDAD DEL SISTEMA.
        'AL AGREGAR UN RECORD NUEVO, SIEMPRE TOMAN EL VALOR POR DEFAULT.

        'ByVal idClasificacionStatus As Integer, _
        'ByVal ClasificaSoloParte As Boolean, _
        'ByVal FojasParte As String, _
        'ByVal FechaClasificacion As DateTime, _
        'ByVal FechaClasificacionChecked As Boolean, _
        'ByVal FechaPropuestaDesclasificacion As DateTime, _
        'ByVal FechaPropuestaDesclasificacionChecked As Boolean, _
        'ByVal NuevaFechaDesclasificacion As DateTime, _
        'ByVal NuevaFechaDesclasificacionChecked As Boolean, _
        'ByVal NuevaClasificaSoloParte As Boolean, _
        'ByVal NuevaFojasParte As String, _
        'ByVal idUsuario_AutorizaAmpliacionClasificacion As Integer, _
        'ByVal FechaDeDesclasificacion As DateTime, _
        'ByVal FechaDeDesclasificacionChecked As Boolean, _
        'ByVal idUsuario_AutorizaDesclasificacion As Integer, _
        'ByVal idPlazoTramite As Integer, _
        'ByVal idPlazoConcentracion As Integer, _
        'ByVal idDestinoFinal As Integer _

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Expedientes_INSERT_2"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("idClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idClasificacion

            'Nombre
            param = cmd.Parameters.Add("Nombre", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = Nombre

            'Asunto
            param = cmd.Parameters.Add("Asunto", Data.OleDb.OleDbType.VarChar, 250)
            param.Value = Asunto

            'NumeroDeFojas
            param = cmd.Parameters.Add("NumeroDeFojas", Data.OleDb.OleDbType.Integer)
            param.Value = NumeroDeFojas

            'FechaApertura
            param = cmd.Parameters.Add("FechaApertura", Data.OleDb.OleDbType.Date)
            param.Value = FechaApertura

            'FechaCierre
            param = cmd.Parameters.Add("FechaCierre", Data.OleDb.OleDbType.Date)
            param.Value = FechaCierre

            'FechaCierreChecked
            param = cmd.Parameters.Add("FechaCierreChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaCierreChecked

            'FechaDePaseABajaHistorico
            param = cmd.Parameters.Add("FechaDePaseABajaHistorico", Data.OleDb.OleDbType.Date)
            param.Value = FechaDePaseABajaHistorico

            'FechaDePaseABajaHistoricoChecked
            param = cmd.Parameters.Add("FechaDePaseABajaHistoricoChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaDePaseABajaHistoricoChecked

            'idUsuario_AutorizaBajaHistorico
            param = cmd.Parameters.Add("idUsuario_AutorizaBajaHistorico", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuario_AutorizaBajaHistorico

            'Caja
            param = cmd.Parameters.Add("Caja", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Caja

            'Pasillo
            param = cmd.Parameters.Add("Pasillo", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Pasillo

            'Anaquel
            param = cmd.Parameters.Add("Anaquel", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Anaquel

            'Entrepano
            param = cmd.Parameters.Add("Entrepano", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = Entrepano

            'RelacionAnterior
            param = cmd.Parameters.Add("RelacionAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = RelacionAnterior

            'CajaAnterior
            param = cmd.Parameters.Add("CajaAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = CajaAnterior

            'ItemAnterior
            param = cmd.Parameters.Add("ItemAnterior", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = ItemAnterior

            'FechaDeCreacion
            param = cmd.Parameters.Add("FechaDeCreacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaDeCreacion

            'idUsuario_ElaboradoPor
            param = cmd.Parameters.Add("idUsuario_ElaboradoPor", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuario_ElaboradoPor

            'RFC
            param = cmd.Parameters.Add("RFC", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = RFC

            'Tipo
            param = cmd.Parameters.Add("Tipo", Data.OleDb.OleDbType.VarChar, 50)
            param.Value = Tipo

            'idUsuarioUltimaEdicion
            param = cmd.Parameters.Add("idUsuarioUltimaEdicion", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuarioUltimaEdicion

            'idUnidadAdministrativa
            param = cmd.Parameters.Add("idUnidadAdministrativa", Data.OleDb.OleDbType.Integer)
            param.Value = idUnidadAdministrativa

            'idCalidadDocumental
            param = cmd.Parameters.Add("idCalidadDocumental", Data.OleDb.OleDbType.Integer)
            param.Value = idCalidadDocumental

            'CampoAdicional3
            param = cmd.Parameters.Add("CampoAdicional3", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = CampoAdicional3

            'idExpedienteAgregado
            param = cmd.Parameters.Add("idExpedienteAgregado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            Expedientes_INSERT = CInt(cmd.Parameters("idExpedienteAgregado").Value)

            cn.Close()

        Catch ex As Exception

            lblValidaCodigo.Visible = True
            lblValidaExpediente.Visible = True

            'MsgBox(ex.Message.ToString)
            Expedientes_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    'Edita los atributos heredados del Cuadro de Clasificación
    Public Function Expedientes_UPDATE_2( _
        ByVal ConexionAUsar As String, _
        ByVal idExpediente As Integer, _
        ByVal idClasificacionStatus As Integer, _
        ByVal ClasificaSoloParte As Boolean, _
        ByVal FojasParte As String, _
        ByVal FechaClasificacion As DateTime, _
        ByVal FechaClasificacionChecked As Boolean, _
        ByVal FechaPropuestaDesclasificacion As DateTime, _
        ByVal FechaPropuestaDesclasificacionChecked As Boolean, _
        ByVal NuevaFechaDesclasificacion As DateTime, _
        ByVal NuevaFechaDesclasificacionChecked As Boolean, _
        ByVal NuevaClasificaSoloParte As Boolean, _
        ByVal NuevaFojasParte As String, _
        ByVal idUsuario_AutorizaAmpliacionClasificacion As Integer, _
        ByVal FechaDeDesclasificacion As DateTime, _
        ByVal FechaDeDesclasificacionChecked As Boolean, _
        ByVal idUsuario_AutorizaDesclasificacion As Integer, _
        ByVal idPlazoTramite As Integer, _
        ByVal idPlazoConcentracion As Integer, _
        ByVal idDestinoFinal As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = ConexionAUsar
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "Expedientes_UPDATE_2"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idClasificacionStatus
            param = cmd.Parameters.Add("idClasificacionStatus", Data.OleDb.OleDbType.Integer)
            param.Value = idClasificacionStatus

            'ClasificaSoloParte
            param = cmd.Parameters.Add("ClasificaSoloParte", Data.OleDb.OleDbType.Boolean)
            param.Value = ClasificaSoloParte

            'FojasParte
            param = cmd.Parameters.Add("FojasParte", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = FojasParte

            'FechaClasificacion
            param = cmd.Parameters.Add("FechaClasificacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaClasificacion

            'FechaClasificacionChecked
            param = cmd.Parameters.Add("FechaClasificacionChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaClasificacionChecked

            'FechaPropuestaDesclasificacion
            param = cmd.Parameters.Add("FechaPropuestaDesclasificacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaPropuestaDesclasificacion

            'FechaPropuestaDesclasificacionChecked
            param = cmd.Parameters.Add("FechaPropuestaDesclasificacionChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaPropuestaDesclasificacionChecked

            'NuevaFechaDesclasificacion
            param = cmd.Parameters.Add("NuevaFechaDesclasificacion", Data.OleDb.OleDbType.Date)
            param.Value = NuevaFechaDesclasificacion

            'NuevaFechaDesclasificacionChecked
            param = cmd.Parameters.Add("NuevaFechaDesclasificacionChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = NuevaFechaDesclasificacionChecked

            'NuevaClasificaSoloParte
            param = cmd.Parameters.Add("NuevaClasificaSoloParte", Data.OleDb.OleDbType.Boolean)
            param.Value = NuevaClasificaSoloParte

            'NuevaFojasParte
            param = cmd.Parameters.Add("NuevaFojasParte", Data.OleDb.OleDbType.VarChar, 25)
            param.Value = NuevaFojasParte

            'idUsuario_AutorizaAmpliacionClasificacion
            param = cmd.Parameters.Add("idUsuario_AutorizaAmpliacionClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuario_AutorizaAmpliacionClasificacion

            'FechaDeDesclasificacion
            param = cmd.Parameters.Add("FechaDeDesclasificacion", Data.OleDb.OleDbType.Date)
            param.Value = FechaDeDesclasificacion

            'FechaDeDesclasificacionChecked
            param = cmd.Parameters.Add("FechaDeDesclasificacionChecked", Data.OleDb.OleDbType.Boolean)
            param.Value = FechaDeDesclasificacionChecked

            'idUsuario_AutorizaDesclasificacion
            param = cmd.Parameters.Add("idUsuario_AutorizaDesclasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idUsuario_AutorizaDesclasificacion

            'idPlazoTramite
            param = cmd.Parameters.Add("idPlazoTramite", Data.OleDb.OleDbType.Integer)
            param.Value = idPlazoTramite

            'idPlazoConcentracion
            param = cmd.Parameters.Add("idPlazoConcentracion", Data.OleDb.OleDbType.Integer)
            param.Value = idPlazoConcentracion

            'idDestinoFinal
            param = cmd.Parameters.Add("idDestinoFinal", Data.OleDb.OleDbType.Integer)
            param.Value = idDestinoFinal

            'idExpedienteEditado
            param = cmd.Parameters.Add("idExpedienteEditado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record editado
            Expedientes_UPDATE_2 = CInt(cmd.Parameters("idExpedienteEditado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Expedientes_UPDATE_2 = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FechaLatinaAGringa(ByVal FechaLatina As String) As String

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
        'FechaLatinaAGringa = MyMes & "/" & MyDia & "/" & MyAnno

    End Function

    Function FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL(ByVal idExpediente As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idExpedienteBorrado
            param = cmd.Parameters.Add("idExpedienteBorrado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL = CInt(cmd.Parameters("idExpedienteBorrado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeClasificacion_Expedientes_Relaciones_DELETE_ALL = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT(ByVal idExpediente As Integer, ByVal idFundamentosLegalesDeClasificacion As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idFundamentosLegalesDeClasificacion
            param = cmd.Parameters.Add("idFundamentosLegalesDeClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idFundamentosLegalesDeClasificacion

            'IDInsertado
            param = cmd.Parameters.Add("IDInsertado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT = CInt(cmd.Parameters("IDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeClasificacion_Expedientes_Relaciones_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL(ByVal idExpediente As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idExpedienteBorrado
            param = cmd.Parameters.Add("idExpedienteBorrado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL = CInt(cmd.Parameters("idExpedienteBorrado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_DELETE_ALL = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT(ByVal idExpediente As Integer, ByVal idFundamentoLegalDeDestinoFinal As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idFundamentoLegalDeDestinoFinal
            param = cmd.Parameters.Add("idFundamentoLegalDeDestinoFinal", Data.OleDb.OleDbType.Integer)
            param.Value = idFundamentoLegalDeDestinoFinal

            'IDInsertado
            param = cmd.Parameters.Add("IDInsertado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT = CInt(cmd.Parameters("IDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            FundamentosLegalesDeDestinoFinal_Expedientes_Relaciones_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function RevisaForma() As Boolean

        'Validacion del codigo segun el Cuadro de Clasificacion Archivistica
        If Not ValidaCodigo(txtCodigo.Text) Then
            lblValidaCodigo.Visible = True
            Return False
        Else
            lblValidaCodigo.Visible = False
        End If

        'OJO ESTO LO COMENTO PORQUE EL NO. DE EXP. SE GENERA AUTOMATICAMENTE
        'Validación para evitar Expedientes en blanco
        'If Trim(txtExpediente.Text) = "" Then
        '    lblValidaExpediente.Visible = True
        '    Return False
        'Else
        '    lblValidaExpediente.Visible = False
        'End If

        'Validación para evitar Nombres en blanco
        If Trim(txtNombre.Text) = "" Then
            lblValidaNombre.Visible = True
            Return False
        Else
            lblValidaNombre.Visible = False
        End If

        'Validación para evitar Fecha de Apertura en blanco
        If Trim(txtFechaApertura.Text) = "" Then
            lblValidaFechaApertura.Visible = True
            Return False
        Else
            lblValidaFechaApertura.Visible = False
        End If

        'Validacion para evitar que el No de Fojas no sea entero
        If Trim(txtNoDeFojas.Text) <> "" Then
            If Not IsNumeric(txtNoDeFojas.Text) Then
                lblValidacionNoDeFojas.Visible = True
                Return False
            Else
                lblValidacionNoDeFojas.Visible = False
            End If
        End If

        'Validación para evitar Fecha de Apertura en formato gringo
        If Not ValidaFechaLatina(txtFechaApertura.Text) Then
            lblValidaFechaApertura.Visible = True
            Return False
        Else
            lblValidaFechaApertura.Visible = False
        End If

        ''Validación para evitar Fecha de Creacion en blanco
        'If Trim(txtFechaDeCreacion.Text) = "" Then
        '    lblValidaFechaCreacion.Visible = True
        '    Return False
        'Else
        '    lblValidaFechaCreacion.Visible = False
        'End If

        ''Validación para evitar Fecha de Creacion en formato gringo
        'If Not ValidaFechaLatina(txtFechaDeCreacion.Text) Then
        '    lblValidaFechaCreacion.Visible = True
        '    Return False
        'Else
        '    lblValidaFechaCreacion.Visible = False
        'End If

        'Validación para evitar Fecha de Cierre en formato gringo
        If Not ValidaFechaLatina(txtFechaCierre.Text) Then
            lblValidaFechaCierre.Visible = True
            Return False
        Else
            lblValidaFechaCierre.Visible = False
        End If

        'Validación para evitar Fecha de Pase a Baja-Historico en formato gringo
        If Not ValidaFechaLatina(txtFechaPaseBajaHistorico.Text) Then
            lblValidaFechaPaseBajaHistorico.Visible = True
            Return False
        Else
            lblValidaFechaPaseBajaHistorico.Visible = False
        End If

        'Validación para evitar FechaDeClasificacion en formato gringo
        If Not ValidaFechaLatina(txtFechaDeClasificacion.Text) Then
            lblValidaFechaClasificacion.Visible = True
            Return False
        Else
            lblValidaFechaClasificacion.Visible = False
        End If

        'Validación para evitar FechaPropuestaDesclasificacion en formato gringo
        If Not ValidaFechaLatina(txtFechaPropuestaDesclasificacion.Text) Then
            lblValidaFechaPropuestaDesclasificacion.Visible = True
            Return False
        Else
            lblValidaFechaPropuestaDesclasificacion.Visible = False
        End If

        'Validación para evitar NuevaFechaPropuestaDesclasificacion en formato gringo
        If Not ValidaFechaLatina(txtNuevaFechaPropuestaDesclasificacion.Text) Then
            lblValidaFechaNuevaDesclasificacion.Visible = True
            Return False
        Else
            lblValidaFechaNuevaDesclasificacion.Visible = False
        End If

        'Validación para evitar FechaDesclasificacion en formato gringo
        If Not ValidaFechaLatina(txtFechaDesclasificacion.Text) Then
            lblValidaFechaDesclasificacion.Visible = True
            Return False
        Else
            lblValidaFechaDesclasificacion.Visible = False
        End If

        'Si no hay problemas, regreso TRUE
        Return True

    End Function

    Function ValidaCodigo(ByVal cod As String) As Boolean

        'Si el código no está vacío
        If txtCodigo.Text = "" Then
            Return False
        Else
            If Not FillJerarquia(cod) Then
                Return False
            Else
                'Si el nodo de la clasificación archivística tiene  hijos, no puedo adscribirle un expediente
                '(sólo pueden adscribirse expedientes a nodos hojas)
                If Get_NumeroDeHijos(CInt(Session("idClasificacionActivo"))) <> 0 Then
                    Return False
                End If

                'Ya validado el código y si estoy añadiendo un nuevo Expediente, 
                'debo heredar los campos de Atributos del nodo correspondiente en el Cuadro
                If Session("ExpedienteStatus") = 1 Then

                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstStatus, "ClasificacionStatus_SELECTALL", "idClasificacionStatus", "Descripcion", CInt(Session("idInformacionClasificadaActivo")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstTramite, "PlazosDeConservacionTramite_SELECTALL", "idPlazosDeConservacionTramite", "Descripcion", CInt(Session("idPlazoDeConservacionTramiteActivo")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstConcentracion, "PlazosDeConservacionConcentracion_SELECTALL", "idPlazosDeConservacionConcentracion", "Descripcion", CInt(Session("idPlazoDeConservacionConcentracionActivo")))
                    FillDropDownList(Session("UsuarioVirtualConnString"), ddlstDestinoFinal, "DestinoFinal_SELECTALL", "idDestinoFinal", "Descripcion", CInt(Session("idDestinoFinalActivo")))

                    'Si estoy agregando Expediente, debo asegurarme de llenar los checkmarks
                    'de Valor Documental, pero como todavía no tengo
                    'idExpediente no puedo agregar records en la tabla ValorDocumental_Expedientes_Relaciones,
                    'así que debo copiarlos del idClasificación propuesto.

                    FillListBox2(Session("UsuarioVirtualConnString"), lbxValorDocumental, "CargaValorDocumental", Session("idClasificacionActivo"), "idValorDocumental", "Descripcion", "Activo")
                    FillListBox2(Session("UsuarioVirtualConnString"), lbxFundamentosLegalesDestinoFinal, "CargaFundamentosLegalesDeDestinoFinal", Session("idClasificacionActivo"), "idFundamentoLegalDeDestinoFinal", "Descripcion", "Activo")
                    FillListBox2(Session("UsuarioVirtualConnString"), lbFundamentosLegalesClasificacion, "CargaFundamentosLegalesDeClasificacion", Session("idClasificacionActivo"), "idFundamentosLegalesDeClasificacion", "Descripcion", "Activo")
                End If
            End If
            Return True
        End If
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

    Public Function Get_NumeroDeHijos(ByVal idClasificacion As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure
            cmd.CommandText = "NumeroDeHijos"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idClasificacion
            param = cmd.Parameters.Add("idClasificacion", Data.OleDb.OleDbType.Integer)
            param.Value = idClasificacion

            'NumeroDeHijos
            param = cmd.Parameters.Add("NumeroDeHijos", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            Get_NumeroDeHijos = CInt(cmd.Parameters("NumeroDeHijos").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            Get_NumeroDeHijos = -1
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function ValorDocumental_Expedientes_Relaciones_DELETE_ALL(ByVal idExpediente As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "ValorDocumental_Expedientes_Relaciones_DELETE_ALL"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idExpedienteBorrado
            param = cmd.Parameters.Add("idExpedienteBorrado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            ValorDocumental_Expedientes_Relaciones_DELETE_ALL = CInt(cmd.Parameters("idExpedienteBorrado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            ValorDocumental_Expedientes_Relaciones_DELETE_ALL = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Function ValorDocumental_Expedientes_Relaciones_INSERT(ByVal idExpediente As Integer, ByVal idValorDocumental As Integer) As Integer

        Dim cn As New Data.OleDb.OleDbConnection
        Dim cmd As New Data.OleDb.OleDbCommand
        Dim param As Data.OleDb.OleDbParameter

        Try

            'Abro la conexión
            cn.ConnectionString = Session("UsuarioVirtualConnString")
            cn.Open()

            'Asigno el Stored Procedure para leer los nodos raíz
            cmd.CommandText = "ValorDocumental_Expedientes_Relaciones_INSERT"
            cmd.Connection = cn
            cmd.CommandType = Data.CommandType.StoredProcedure

            'idExpediente
            param = cmd.Parameters.Add("idExpediente", Data.OleDb.OleDbType.Integer)
            param.Value = idExpediente

            'idValorDocumental
            param = cmd.Parameters.Add("idValorDocumental", Data.OleDb.OleDbType.Integer)
            param.Value = idValorDocumental

            'IDInsertado
            param = cmd.Parameters.Add("IDInsertado", Data.OleDb.OleDbType.Integer)
            param.Direction = Data.ParameterDirection.Output

            'Ejecuto el sp
            cmd.ExecuteNonQuery()

            'Leo el id del record insertado
            ValorDocumental_Expedientes_Relaciones_INSERT = CInt(cmd.Parameters("IDInsertado").Value)

            cn.Close()

        Catch ex As Exception

            'MsgBox(ex.Message.ToString)
            ValorDocumental_Expedientes_Relaciones_INSERT = 0
            If cn.State <> Data.ConnectionState.Closed Then
                cn.Close()
            End If

        End Try

    End Function

    Private Sub btnCaratula_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCaratula.Click

        'CargaFormatoCaratulaISSSTE

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New CaratulaFOVISSSTECredito 'CaratulaFOVISSSTE

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTE" '"CargaFormatoCaratulaISSSTE"

        param = cmd.Parameters.Add("IDExpediente", OleDbType.VarChar)
        param.Value = Session("IDExpedienteActivo")

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "ISSSTE")
        Reporte.SetParameterValue(1, "700. FOVISSSTE")

        'Reporte.SetParameterValue(0, "ISS 100 ISSSTE")
        'Reporte.SetParameterValue(1, "130. ADMINISTRACIÓN REGIONAL Y ESTATAL")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = Session("SubdirectorioTemporal") & Session("LoginActivo") & guid1.ToString & ".pdf"

        'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
        'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
        'Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        'Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

        'Write the file directly to the HTTP output stream.
        Response.ContentType = "Application/pdf"
        Response.WriteFile(MyFileName)
        Response.End()

    End Sub

    'Private Sub DataGrid1_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles DataGrid1.PageIndexChanged
    '    ' Set CurrentPageIndex to the page the user clicked.
    '    DataGrid1.CurrentPageIndex = e.NewPageIndex

    '    ' Rebind the data. 
    '    FillMovimientos(CInt(Session("IDExpedienteActivo")))
    '    'DataGrid1.DataSource = CreateDataSource()
    '    'DataGrid1.DataBind()

    'End Sub

    'Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAbreEscogeCuadro.Click
    '    'Response.ContentType = "Application/pdf"
    '    'Response.WriteFile("C:\Alfredo\Telmex\prueba.pdf")
    '    'Response.End()
    'End Sub

    Private Sub DataGrid1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid1.ItemCommand

        If e.Item.ItemIndex >= 0 Then
            Session("IDMovimientoActivo") = DataGrid1.DataKeys.Item(e.Item.ItemIndex)
            Session("ExpedienteStatus") = 0
            Session("MovimientoStatus") = 0
            Session("CuadroClasificacionStatus") = 0
            Session("UsuarioRealStatus") = 0
            Response.Redirect("./MovimientosDisplay.aspx")
        End If

    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Session("idMovimientoActivo") = -1
        Response.Redirect("./MovimientosDisplay.aspx")
    End Sub

    Private Sub DataGrid2_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles DataGrid2.ItemCommand

        Response.ContentType = "Application/pdf"
        'Response.WriteFile(Session("SubdirectorioDeImagenes") & e.Item.Cells(2).Text)
        Response.WriteFile(Path.Combine(Session("SubdirectorioDeImagenes").ToString, e.Item.Cells(2).Text))
        Response.End()
    End Sub

    Private Sub btnVerDocumentos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnVerDocumentos.Click
        PLocalizacion.Visible = False
        PClasificacion.Visible = False
        PAtributos.Visible = False
        PPDFs.Visible = True
    End Sub

    Private Sub btnCaratula2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCaratula2.Click
        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New CaratulaCONACYT3 'CaratulaFOVISSSTE2

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTE"

        param = cmd.Parameters.Add("IDExpediente", OleDbType.VarChar)
        param.Value = Session("IDExpedienteActivo")

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        Reporte.SetParameterValue(0, "SENADO")
        Reporte.SetParameterValue(1, "")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = Session("SubdirectorioTemporal").ToString & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

        'Tengo que hacer esta doble escritura para asegurar que no se acumulen los 
        'ficheros con reportes pdf del usuario activo (El File.Exists no funciona)
        'Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
        'Kill(Session("SubdirectorioTemporal") & Session("LoginActivo") & "*.pdf")
        Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)

        'Write the file directly to the HTTP output stream.
        Response.ContentType = "Application/pdf"
        Response.WriteFile(MyFileName)
        Response.End()

    End Sub

    Private Sub btnLomo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLomo.Click

        Dim cn As New OleDbConnection
        Dim cmd As New OleDbCommand
        Dim param As OleDbParameter
        Dim da As New OleDbDataAdapter
        Dim ds As New DataSet

        Dim Reporte As New LomoFOVISSSTE

        cn.ConnectionString = Session("UsuarioVirtualConnString")
        cn.Open()

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = cn
        cmd.Parameters.Clear()
        cmd.CommandText = "CargaFormatoCaratulaFOVISSSTE2"

        param = cmd.Parameters.Add("IDExpediente", OleDbType.VarChar)
        param.Value = Session("IDExpedienteActivo")

        da.SelectCommand = cmd
        da.Fill(ds)
        da.Dispose()

        Reporte.SetDataSource(ds.Tables(0))

        'Reporte.SetParameterValue(0, "ISSSTE")
        'Reporte.SetParameterValue(1, "700. FOVISSSTE")

        Dim guid1 As Guid = Guid.NewGuid
        Dim MyFileName As String = Session("SubdirectorioTemporal").ToString & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

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

    Private Sub btnAbreEscogeCuadro_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAbreEscogeCuadro.Click
        Response.Redirect("./EscogeCuadro.aspx")
    End Sub
End Class
