Imports System.Globalization
Imports System.IO

Imports fsSimaServicios

Public Class VerificarArchivos
    Inherits System.Web.UI.Page

    Dim _servicios As ExpedientesServicios

    Private Sub VerificarArchivos_Init(sender As Object, e As EventArgs) Handles Me.Init
        _servicios = New ExpedientesServicios(Session("AdminConnStringSql").ToString, DirImagenes)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = "USOC" Or Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = "SUPERUSER" Then    'Perfil usuario administrador
            If Not IsPostBack Then
                ObtieneEstadisticaExpedientes()
            End If

            txtVerificados.Text = ""
            txtArchivosDirectorio.Text = ""
            txtArchivosDirectorioVinculados.Text = ""
            txtArchivosDirectorioSinVincular.Text = ""

        Else
            Response.Redirect("Logout.aspx")
        End If
    End Sub

    Protected Sub BtnIniciarVerificacion_Click(sender As Object, e As EventArgs) Handles btnIniciarVerificacion.Click
        _servicios.VerificaArchivos(chkReiniciarContadores.Checked)
        chkReiniciarContadores.Checked = False
        txtVerificados.Text = _servicios.NuevosArchivosLocalizados.ToString
        btnIniciarVerificacion.Enabled = True
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "script", "espera();", True)
        ObtieneEstadisticaExpedientes()

    End Sub

    Protected Sub BtnActualizarDatosDirectorio_Click(sender As Object, e As EventArgs) Handles btnActualizarDatosDirectorioSrv.Click

        If chkGenerarReporte.Checked Then
            Dim archivoExcel As String = "ConciliacionImagenes.xlsx"
            _servicios.VerificaArchivosFS(DirTemporal, archivoExcel, generarArchivoExcel:=True)
            Dim url As String = $"./DescargaArchivo.aspx?FN={HttpUtility.UrlEncode(Path.Combine(DirTemporal, archivoExcel))}&Nombre={archivoExcel}&Eliminar=True"
            ClientScript.RegisterStartupScript(Me.GetType(), "script", "open('" & url & "');", True)
        Else
            _servicios.VerificaArchivosFS()
        End If

        With _servicios
            txtArchivosDirectorio.Text = .TotalArchivosEnDirectorio.ToString("0#,#", CultureInfo.InvariantCulture)
            txtArchivosDirectorioVinculados.Text = .ArchivosDirectorioVinculados.ToString("0#,#", CultureInfo.InvariantCulture)
            txtArchivosDirectorioSinVincular.Text = .ArchivosDirectorioSinVincular.ToString("0#,#", CultureInfo.InvariantCulture)
            txtEspacioDisco.Text = $"{ .EspacionEnDisco.ToString("0#,#", CultureInfo.InvariantCulture)} MB"

        End With

        'Actualiza valores para propiedades dinámicas en aspx.
        txtArchivosDirectorio.DataBind()
        txtArchivosDirectorioVinculados.DataBind()
        txtArchivosDirectorioSinVincular.DataBind()
        txtEspacioDisco.DataBind()

    End Sub

    Private Sub ObtieneEstadisticaExpedientes()
        With _servicios
            .ObtieneEstadisticaArchivos()
            txtTotalExpedientes.Text = .TotalExpedientesBD.ToString("0#,#", CultureInfo.InvariantCulture)
            txtExpedientesConArchivos.Text = .ExpedientesConArchivoBD.ToString("0#,#", CultureInfo.InvariantCulture)
            txtExpedientesSinArchivos.Text = .ExpedientesSinArchivoBD.ToString("0#,#", CultureInfo.InvariantCulture)
            txtArchivosLocalizados.Text = .ArchivosLocalizadosFS.ToString("0#,#", CultureInfo.InvariantCulture)
            txtArchivosNoLocalizados.Text = .ArchivosNoLocalizadosFS.ToString("0#,#", CultureInfo.InvariantCulture)
            txtAplicaDigitalizacion.Text = .ArchivosConDigitalizacion.ToString("0#,#", CultureInfo.InvariantCulture)
            txtNoAplicaDigitalizacion.Text = .ArchivosSinDigitalizacion.ToString("0#,#", CultureInfo.InvariantCulture)
            txtImagenesEsperadas.Text = .ImagenesEsperadas.ToString("0#,#", CultureInfo.InvariantCulture)
            txtTotalHojasEsperadas.Text = .TotalHojasBD.ToString("0#,#", CultureInfo.InvariantCulture)

            grvDetalle.DataSource = .Detalle
        End With
        'Actualiza valores para propiedades dinámicas en aspx.
        txtExpedientesSinArchivos.DataBind()
        lblExpedientesSinArchivos.DataBind()

        grvDetalle.DataBind()

    End Sub

End Class