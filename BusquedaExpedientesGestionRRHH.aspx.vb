Imports System.Collections.Generic
Imports System.Data.OleDb
Imports System.Text
Imports System.IO
Imports System.Globalization

Imports fsSimaServicios

Public Class BusquedaExpedientesGestionRRHH
    Inherits Page

#Region "Variables y clases privadas globales a la clase"
    Private _cadenaConexion As String
    Private _listaIdExpedientes As List(Of Integer)
    Private _ordenExpedientes As String
    Private _idUnidadAdministrativaRRHH As String = "221"

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

#End Region

#Region "Métodos privados manejadores de eventos de la forma"
    Private Sub Page_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Introducir aquí el código de usuario para inicializar la página

        _cadenaConexion = Session("UsuarioVirtualConnString").ToString
        _listaIdExpedientes = CType(Session("ListaIdExpedientes"), List(Of Integer))
        _ordenExpedientes = Session("OrdenDeGridDeExpedientes")

        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0

        If Not Page.IsPostBack Then
            _cadenaConexion = Session("UsuarioVirtualConnString").ToString

            Dim listaOrdenamiento As New Dictionary(Of String, String) From
                {
                    {" caja, control1 ", "Caja"},
                    {" nombre ", "Expediente"},
                    {" observaciones, nombre ", "Contratación"},
                    {" campoAdicional2, nombre", "Estado"},
                    {" campoAdicional1, nombre ", "Número"},
                    {" fechaApertura, nombre ", "Apertura"},
                    {" control2 ", "Consecutivo área"},
                    {" control1 ", "Consecutivo general"}
                }

            ordenamientoDropDownList.DataSource = listaOrdenamiento
            ordenamientoDropDownList.DataValueField = "Key"
            ordenamientoDropDownList.DataTextField = "Value"
            ordenamientoDropDownList.DataBind()

            _ordenExpedientes = ordenamientoDropDownList.SelectedValue

            txtLimite.Text = Session("LimiteDeRecordsEnBusqueda").ToString()

            If Trim(txtLimite.Text) = "" Or Not IsNumeric(txtLimite.Text) Then
                txtLimite.Text = RegistrosMaximos.ToString
                Session("LimiteDeRecordsEnBusqueda") = CInt(txtLimite.Text)
            End If

            ddlEstado.Items.Add("Todos")
            ddlEstado.Items.Add("Activo")
            ddlEstado.Items.Add("Inactivo")
            ddlEstado.SelectedValue = "Todos"

            ddlTipoContratacion.Items.Add("Todos")
            ddlTipoContratacion.Items.Add("Salarios")
            ddlTipoContratacion.Items.Add("Honorarios")
            ddlTipoContratacion.SelectedValue = "Todos"

        End If

    End Sub

    Private Sub BuscarButton_Click(sender As Object, e As EventArgs) Handles buscarButton.Click

        If Page.IsValid Then

            'Session("LimiteDeRecordsEnBusqueda") = CInt(txtLimite.Text)
            txtReal.Text = CuentaRegistros().ToString

            DataGrid1.Visible = False
            NoHayDatos.Visible = False

            btnImprimeGuiaDeExpedientes.Enabled = False
            btnImprimeListadoDeExpedientes.Enabled = False
            btnCaratulasExpediente.Enabled = False
            btnEtiquetas.Enabled = False
            btnLomos.Enabled = False

            If CInt(txtReal.Text) > CInt(txtLimite.Text) Then
                lblLimiteExcedido.Visible = True
            Else
                lblLimiteExcedido.Visible = False
                LlenaGrid()
            End If
        End If
    End Sub

    Private Sub DataGrid1_SortCommand(source As Object, e As DataGridSortCommandEventArgs) Handles DataGrid1.SortCommand

        Select Case e.SortExpression
            Case "Contratación"
                _ordenExpedientes = " observaciones, nombre "
            Case "Expediente"
                _ordenExpedientes = " nombre "
            Case "Estado" 'Reemplazar por Observaciones
                _ordenExpedientes = " campoAdicional2, nombre "
            Case "Titulo"  'Reemplazar por Titulo
                _ordenExpedientes = " campoAdicional1, nombre "
            Case "Caja"
                _ordenExpedientes = " caja, nombre "
            Case "FechaApertura"
                _ordenExpedientes = " fechaApertura, nombre "
            Case "Consecutivo área"
                _ordenExpedientes = " control2 "
            Case "Consecutivo general"
                _ordenExpedientes = " control1 "
            Case Else
                _ordenExpedientes = " caja, control1 "
        End Select

        Session("OrdenDeGridDeExpedientes") = _ordenExpedientes

        ordenamientoDropDownList.SelectedValue = _ordenExpedientes
        ordenamientoDropDownList.DataBind()

        LlenaGrid()

    End Sub

    Private Sub DataGrid1_ItemCommand(source As Object, e As DataGridCommandEventArgs) Handles DataGrid1.ItemCommand
        If e.Item.ItemIndex >= 0 Then
            Select Case e.CommandName
                Case "Expediente"
                    Session("IDExpedienteActivo") = DataGrid1.DataKeys.Item(e.Item.ItemIndex)
                    Session("ExpedienteStatus") = 0
                    Session("MovimientoStatus") = 0
                    Session("CuadroClasificacionStatus") = 0
                    Session("UsuarioRealStatus") = 0
                    Response.Redirect("./ExpedienteDocumentosGestion.aspx")
                Case "Documentos"
                    Dim dgItem As DataGridItem = e.Item
                    Dim imgButton As ImageButton = TryCast(dgItem.FindControl("ibtMuestraDocs"), ImageButton)
                    If e.CommandArgument = "Show" Then
                        dgItem.FindControl("pnlDocumentos").Visible = True
                        imgButton.CommandArgument = "Hide"
                        imgButton.ImageUrl = "~/images/minus.png"
                        Dim orderId As Integer = DataGrid1.DataKeys.Item(e.Item.ItemIndex)
                        Dim gvDocumentos As GridView = TryCast(dgItem.FindControl("gvDocumentos"), GridView)
                        BindDocumentos(orderId, gvDocumentos)
                    Else
                        dgItem.FindControl("pnlDocumentos").Visible = False
                        imgButton.CommandArgument = "Show"
                        imgButton.ImageUrl = "~/images/docs.png"
                    End If
                Case Else
            End Select
        End If

    End Sub

    Protected Sub DataGrid1_PageIndexChanged(source As Object, e As DataGridPageChangedEventArgs) Handles DataGrid1.PageIndexChanged
        DataGrid1.CurrentPageIndex = e.NewPageIndex
        LlenaGrid()
    End Sub

    Private Sub BindDocumentos(idExpediente As Integer, gvDocumentos As GridView)
        gvDocumentos.ToolTip = "Click para descargar documento"

        Dim params(0) As OleDbParameter
        Dim dsPDF As DataSet
        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        params(0) = New OleDbParameter("@idExpediente", idExpediente)

        dsPDF = sqlCliente.ObtenerRegistros(params, "ExpedientesPDF_SELECT_ALL")

        If dsPDF IsNot Nothing AndAlso dsPDF.Tables.Count > 0 Then
            dsPDF.Tables(0).TableName = "PDFs"
            gvDocumentos.Visible = True

            gvDocumentos.DataSource = dsPDF
            gvDocumentos.DataMember = "PDFs"
            gvDocumentos.DataKeyNames = {"NombrePDF"}
            gvDocumentos.DataBind()
        End If

    End Sub

    Protected Sub GvDocumentos_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim gv As GridView = CType(sender, GridView)
        Dim archivo As String = gv.DataKeys(e.CommandArgument.ToString()).Value.ToString

        If Not ImagenNuevaVentana Then
            'Llamada a dll de accesorios.
            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(Path.Combine(DirImagenes, archivo))}")
        Else
            'Llamada a página extra para mostrar imagen. Necesario activar Pop-Ups en cliente.
            Dim url As String = $"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(Path.Combine(DirImagenes, archivo))}"
            ClientScript.RegisterStartupScript(Me.GetType(), "script", "open('" & url & "');", True)
        End If

    End Sub

    Protected Sub DataGrid1_ItemDataBound(sender As Object, e As DataGridItemEventArgs) Handles DataGrid1.ItemDataBound
        If e.Item.ItemIndex > -1 Then
            If DirectCast(e.Item.FindControl("lblDigitalizacion"), Label).Text = "No" Then
                e.Item.BackColor = Color.AliceBlue
            ElseIf CType(DirectCast(e.Item.FindControl("txtArchivosNoLocalizados"), Label).Text, Integer) > 0 Then
                e.Item.BackColor = Color.IndianRed
            End If
        End If
    End Sub

    Private Sub BtnImprimeGuiaDeExpedientes_Click(sender As Object, ByVal e As EventArgs) Handles btnImprimeGuiaDeExpedientes.Click

        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim Reporte As New GuiaDeExpedientes

        Dim expedientes As New StringBuilder()

        For Each item As Integer In _listaIdExpedientes
            expedientes.Append(item)
            expedientes.Append(",")
        Next

        params(0) = New OleDbParameter("@IDList", expedientes.ToString)
        params(1) = New OleDbParameter("@Orden", _ordenExpedientes)

        ds = New ClienteSQL(_cadenaConexion).ObtenerRegistros(params, "GuiaDeExpedientesExistentes")

        If ds.Tables.Count > 0 Then

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, "Listado guía de expedientes existentes por Unidad Administrativa")
            Reporte.SetParameterValue(1, "")
            Reporte.SetParameterValue(2, LogoCliente)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Reporte.Dispose()

            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=GuiaExpedientes.pdf&Eliminar=True")

        End If

    End Sub

    Private Sub BtnImprimeListadoDeExpedientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnImprimeListadoDeExpedientes.Click

        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim Reporte As New ListaDeExpedientes

        Dim expedientes As New StringBuilder()

        For Each item As Integer In _listaIdExpedientes
            expedientes.Append(item)
            expedientes.Append(",")
        Next

        params(0) = New OleDbParameter("@IDList", expedientes.ToString)
        params(1) = New OleDbParameter("@Orden", _ordenExpedientes)

        ds = New ClienteSQL(_cadenaConexion).ObtenerRegistros(params, "ListadoDeExpedientes")

        If ds.Tables.Count > 0 Then
            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, "Listado de expedientes por Unidad Administrativa conforme a criterio de búsqueda")
            Reporte.SetParameterValue(1, LogoCliente)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Reporte.Dispose()

            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=ListaExpedientes.pdf&Eliminar=True")

        End If
    End Sub

    Private Sub BtnCaratulasNoCredito_Click(sender As Object, e As EventArgs) Handles btnCaratulasExpediente.Click
        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim Reporte As New Caratula02

        Dim expedientes As New StringBuilder()

        For Each item As Integer In _listaIdExpedientes
            expedientes.Append(item)
            expedientes.Append(",")
        Next

        params(0) = New OleDbParameter("@IDList", expedientes.ToString)
        params(1) = New OleDbParameter("@Orden", _ordenExpedientes)

        ds = New ClienteSQL(_cadenaConexion).ObtenerRegistros(params, "CargaFormatoCaratula")

        If ds.Tables.Count > 0 Then

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, "SENADO DE LA REPúBLICA")
            Reporte.SetParameterValue("Logo", LogoCliente)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Reporte.Dispose()

            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=Caratulas.pdf&Eliminar=True")

        End If

    End Sub

    Private Sub BtnEtiquetas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEtiquetas.Click
        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim Reporte As New Etiquetas

        Dim expedientes As New StringBuilder()

        For Each item As Integer In _listaIdExpedientes
            expedientes.Append(item)
            expedientes.Append(",")
        Next

        params(0) = New OleDbParameter("@IDList", expedientes.ToString)
        params(1) = New OleDbParameter("@Orden", _ordenExpedientes)

        ds = New ClienteSQL(_cadenaConexion).ObtenerRegistros(params, "ListadoDeExpedientes")

        If ds.Tables.Count > 0 Then
            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue(0, LogoCliente)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Reporte.Dispose()

            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=Etiquetas.pdf&Eliminar=True")

        End If
    End Sub

    Private Sub BtnLomos_Click(sender As Object, e As EventArgs) Handles btnLomos.Click
        Dim params(1) As OleDbParameter
        Dim ds As DataSet

        Dim Reporte As New Lomo

        Dim expedientes As New StringBuilder()

        For Each item As Integer In _listaIdExpedientes
            expedientes.Append(item)
            expedientes.Append(",")
        Next

        params(0) = New OleDbParameter("@IDList", expedientes.ToString)
        params(1) = New OleDbParameter("@Orden", _ordenExpedientes)

        ds = New ClienteSQL(_cadenaConexion).ObtenerRegistros(params, "CargaFormatoCaratula")

        If ds.Tables.Count > 0 Then

            Reporte.SetDataSource(ds.Tables(0))

            Reporte.SetParameterValue("Logo", LogoCliente)

            Dim guid1 As Guid = Guid.NewGuid
            Dim MyFileName As String = DirTemporal & Session("LoginActivo").ToString & guid1.ToString & ".pdf"

            Reporte.ExportToDisk(CrystalDecisions.[Shared].ExportFormatType.PortableDocFormat, MyFileName)
            Reporte.Dispose()

            Response.Redirect($"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(MyFileName)}&Nombre=Lomos.pdf&Eliminar=True")


        End If

    End Sub

    Protected Sub OrdenamientoDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ordenamientoDropDownList.SelectedIndexChanged
        btnImprimeGuiaDeExpedientes.Enabled = False
        btnImprimeListadoDeExpedientes.Enabled = False
        btnCaratulasExpediente.Enabled = False
        btnEtiquetas.Enabled = False
        btnLomos.Enabled = False
    End Sub

#End Region

#Region "Métodos y funciones privados"

    Private Function CuentaRegistros() As Integer
        Dim dsExpedientes As DataSet
        Dim condicion As String
        Dim sQLString As String
        Dim contador As Integer

        condicion = PreparaBusqueda()

        sQLString =
            "Select COUNT(*) FROM Expedientes e INNER JOIN UnidadesAdministrativas u On e.IdUnidadAdministrativa = u.IdUnidadAdministrativa " &
            CStr(IIf(condicion <> "", " WHERE " & condicion, ""))

        'Si llego aquí y no hay siquiera un WHERE, lo pongo ahora y con una condición imposible, para que no devuelva nada
        sQLString &= CStr(IIf(InStr(UCase(sQLString), "WHERE") > 0, "", " WHERE idExpediente < -1000"))

        dsExpedientes = New ClienteSQL(_cadenaConexion).ObtenerRegistros(PreparaParametros(sQLString).ToArray, "Expedientes_BUSCA_WEB")

        If dsExpedientes.Tables.Count > 0 Then
            contador = CInt(dsExpedientes.Tables(0).Rows(0)(0))
        End If

        Return contador

    End Function

    Sub LlenaGrid()

        Dim dsExpedientes As DataSet
        Dim condicion As String
        Dim sQLString As String

        condicion = PreparaBusqueda()

        sQLString =
                "Select dbo.fnNombreDeJerarquia(e.idClasificacion) As Codigo, " &
                "e.idExpediente, " &
                "e.Nombre As Expediente, " &
                "e.CampoAdicional2 AS Estado, " &
                "e.CampoAdicional1 AS Numero, " &
                "e.Asunto AS Nombre, " &
                "e.RelacionAnterior AS RelacionAnterior, " &
                "e.Caja, " &
                "e.CajaAnterior, " &
                "e.Observaciones AS Contratacion, " &
                "CONVERT(NVARCHAR(10), e.FechaApertura, 103) AS Apertura, " &
                "Cierre = CASE WHEN (FechaCierreChecked = 1) THEN CONVERT(NVARCHAR(10), e.FechaCierre, 103) ELSE '' END, " &
                "ua.NombreCorto, " &
                "e.DocumentosDigitalizados AS Digitalizacion " &
                "FROM Expedientes e " &
                "INNER JOIN UnidadesAdministrativas ua ON e.idUnidadAdministrativa = ua.idUnidadAdministrativa " &
                CStr(IIf(condicion <> "", " WHERE " & condicion, ""))

        'Si llego aquí y no hay siquiera un WHERE, lo pongo ahora y con una condición imposible, para que no devuelva nada
        sQLString &= CStr(IIf(InStr(UCase(sQLString), "WHERE") > 0, "", " WHERE idExpediente < -1000"))

        _ordenExpedientes = ordenamientoDropDownList.SelectedValue
        sQLString &= " ORDER BY " & _ordenExpedientes.ToString

        dsExpedientes = New ClienteSQL(_cadenaConexion).ObtenerRegistros(PreparaParametros(sQLString).ToArray, "Expedientes_Busqueda_RRHH")

        If dsExpedientes IsNot Nothing AndAlso dsExpedientes.Tables.Count > 0 Then
            dsExpedientes.Tables(0).TableName = "Expedientes"

            If dsExpedientes.Tables("Expedientes").Rows.Count = 0 Then
                DataGrid1.Visible = False
                NoHayDatos.Visible = True

                btnImprimeGuiaDeExpedientes.Enabled = False
                btnImprimeListadoDeExpedientes.Enabled = False
                btnCaratulasExpediente.Enabled = False
                btnEtiquetas.Enabled = False
                btnLomos.Enabled = False

            Else
                Dim dr As DataRow
                'Preparo variable global para recibir Ids de expedientes localizados

                If _listaIdExpedientes Is Nothing Then
                    _listaIdExpedientes = New List(Of Integer)
                ElseIf _listaIdExpedientes.Count > 0 Then
                    _listaIdExpedientes.Clear()
                End If

                For Each dr In dsExpedientes.Tables("Expedientes").Rows
                    _listaIdExpedientes.Add(dr("IdExpediente"))
                Next

                Session("ListaIdExpedientes") = _listaIdExpedientes
                Session("OrdenDeGridDeExpedientes") = _ordenExpedientes

                DataGrid1.Visible = True
                NoHayDatos.Visible = False

                'Señalo cuál va a ser el DataSet de este grid
                DataGrid1.DataSource = dsExpedientes

                DataGrid1.DataMember = "Expedientes"
                DataGrid1.DataKeyField = "idExpediente"
                DataGrid1.DataBind()

                btnImprimeGuiaDeExpedientes.Enabled = True
                btnImprimeListadoDeExpedientes.Enabled = True
                btnCaratulasExpediente.Enabled = True
                btnEtiquetas.Enabled = True
                btnLomos.Enabled = True

            End If
        Else
            DataGrid1.Visible = False
            NoHayDatos.Visible = True
        End If

    End Sub

    Private Function PreparaBusqueda() As String
        Dim operador As String
        Dim lista As String
        Dim condicion As String = ""

        operador = CStr(IIf(Not cbBusqExacta.Checked, " LIKE ", " = "))

        'Unidades Administrativas
        lista = _idUnidadAdministrativaRRHH

        If lista <> "" Then
            condicion = AgregaCondicion(condicion, " e.idUnidadAdministrativa IN (" & lista & ") ")
        End If

        'Número de expediente (Consecutivo interno FSM)
        If Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) <> "" Then
            'Rango de expedientes
            condicion = AgregaCondicion(condicion, " e.Control1 >= @Expediente AND e.Control1 <= @ExpedienteFinal ")
        ElseIf Trim(txtExpInic.Text) <> "" And Trim(txtExpFinal.Text) = "" Then
            'Condición normal para LIKE ó =, usando txtExpediente
            condicion = AgregaCondicion(condicion, " e.Control1 >= @Expediente ")
        ElseIf Trim(txtExpInic.Text) = "" And Trim(txtExpFinal.Text) <> "" Then
            'Condición normal para LIKE ó =, usando txtExpedienteFinal
            condicion = AgregaCondicion(condicion, " e.Control1 <= @ExpedienteFinal ")
        Else
            'No hay rango de expedientes
        End If

        'Caracteres excluídos
        condicion = AgregaCondicion(condicion, CondicionDeCaracteresExcluidos(txtCaractExclu.Text))

        'Observaciones
        condicion = AgregaCondicion(condicion, CStr(IIf(ddlEstado.SelectedValue <> "Todos", " e.CampoAdicional2 " & " = " & " @Observaciones ", "")))

        'Título
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtNumero.Text) <> "", " e.CampoAdicional1 " & operador & " @Titulo ", "")))

        'Asunto
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtNombre.Text) <> "", " e.Asunto " & operador & " @Asunto ", "")))

        'CajaC
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtCaja.Text) <> "", " e.Caja " & operador & " @Caja ", "")))

        'CajaTr
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtRelAnt.Text) <> "", " e.RelacionAnterior " & operador & " @RelacionAnterior ", "")))

        'AnaqTr
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtAnaqTr.Text) <> "", " e.CajaAnterior " & operador & " @CajaAnterior ", "")))

        'UbicTr
        condicion = AgregaCondicion(condicion, CStr(IIf(Trim(txtUbicTr.Text) <> "", " e.ItemAnterior " & operador & " @ItemAnterior ", "")))

        'ObsTr
        condicion = AgregaCondicion(condicion, CStr(IIf(ddlTipoContratacion.SelectedValue <> "Todos", " e.Observaciones " & " = " & " @CampoAdicional3 ", "")))

        If Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) <> "" Then
            'Rango normal entre dos fechas
            condicion = AgregaCondicion(condicion, " FechaApertura BETWEEN @FechaInicial AND @FechaFinal ")
        ElseIf Trim(txtFApertInic.Text) <> "" And Trim(txtFApertFinal.Text) = "" Then
            'A partir de una fecha hacia adelante
            condicion = AgregaCondicion(condicion, " FechaApertura >= @FechaInicial ")
        ElseIf Trim(txtFApertInic.Text) = "" And Trim(txtFApertFinal.Text) <> "" Then
            'A partir de una fecha hacia atrás
            condicion = AgregaCondicion(condicion, " FechaApertura <= @FechaFinal ")
        Else
            'No hay rango de fechas
        End If

        Return condicion

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

    Private Function AgregaCondicion(condicion As String, condicionAuxilar As String) As String
        If condicionAuxilar <> "" Then
            If condicion <> "" Then
                condicion &= " AND "
            End If
            condicion &= condicionAuxilar
        End If
        Return condicion
    End Function

    Private Function PreparaParametros(sqlString As String) As List(Of OleDbParameter)
        Dim paramsList As New List(Of OleDbParameter)
        Dim busquedaExacta As Boolean = cbBusqExacta.Checked

        paramsList.Add(New OleDbParameter("SQLString", sqlString))

        'Codigo
        'paramsList.Add(AgregaParametro(txtCodigo.Text, "Codigo", busquedaExacta))
        paramsList.Add(AgregaParametro("", "Codigo", busquedaExacta))

        'Estado del expediente
        paramsList.Add(AgregaParametro(If(ddlEstado.SelectedValue <> "Todos", ddlEstado.SelectedValue, ""), "Observaciones", True))

        'Número expediente
        paramsList.Add(AgregaParametro(txtNumero.Text, "Titulo", busquedaExacta))

        'Nombre del empleado
        paramsList.Add(AgregaParametro(txtNombre.Text, "Asunto", busquedaExacta))

        'CajaC
        paramsList.Add(AgregaParametro(txtCaja.Text, "Caja", busquedaExacta))

        'CajaTr
        paramsList.Add(AgregaParametro(txtRelAnt.Text, "RelacionAnterior", busquedaExacta))

        'AnaqTr
        paramsList.Add(AgregaParametro(txtAnaqTr.Text, "CajaAnterior", busquedaExacta))

        'UbicTr
        paramsList.Add(AgregaParametro(txtUbicTr.Text, "ItemAnterior", busquedaExacta))

        'ObsTr
        paramsList.Add(AgregaParametro(If(ddlTipoContratacion.SelectedValue <> "Todos", ddlTipoContratacion.SelectedValue, ""), "CampoAdicional3", True))

        'Le tengo que pasar los dos parámetros de fecha, aunque no los use. Si no los uso, no aparecen en la cadena SQL generada.
        'Fecha de Apertura inicial
        If Len(Trim(txtFApertInic.Text)) = 0 Then
            paramsList.Add(New OleDbParameter("FechaInicial", DateTime.ParseExact("1/1/2000", "d/M/yyyy", Nothing)))
        Else
            paramsList.Add(New OleDbParameter("FechaInicial", DateTime.ParseExact(Trim(txtFApertInic.Text), "d/M/yyyy", Nothing)))
        End If

        'Fecha de Apertura final
        If Len(Trim(txtFApertFinal.Text)) = 0 Then
            paramsList.Add(New OleDbParameter("FechaFinal", DateTime.ParseExact("1/1/2000", "d/M/yyyy", Nothing)))
        Else
            paramsList.Add(New OleDbParameter("FechaFinal", DateTime.ParseExact(Trim(txtFApertFinal.Text), "d/M/yyyy", Nothing)))
        End If

        'Expediente
        If Len(Trim(txtExpInic.Text)) = 0 Then
            paramsList.Add(New OleDbParameter("Expediente", 0))
        Else
            paramsList.Add(New OleDbParameter("Expediente", Integer.Parse(txtExpInic.Text)))
        End If

        'ExpedienteFinal
        If Len(Trim(txtExpFinal.Text)) = 0 Then
            paramsList.Add(New OleDbParameter("ExpedienteFinal", 0))
        Else
            paramsList.Add(New OleDbParameter("ExpedienteFinal", Integer.Parse(txtExpFinal.Text)))
        End If

        Return paramsList
    End Function

    Private Function AgregaParametro(valor As String, paramNombre As String, busquedaExacta As Boolean) As OleDbParameter

        Dim param As New OleDbParameter(paramNombre, valor)

        If Not busquedaExacta Then
            param.Value = IIf(Trim(valor) <> "", "%" & Trim(valor) & "%", "%")
        End If

        Return param

    End Function

    Sub ActualizaStatusDeExpedientes()

        Dim params(0) As OleDbParameter
        Dim sqlCliente As New ClienteSQL(_cadenaConexion)

        params(0) = New OleDbParameter("@FechaDeCorrida", Now)

        sqlCliente.EjecutaProcedimiento(params, "ActualizaEstatusExpedientesVencidos")

    End Sub

#End Region


End Class