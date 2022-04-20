Imports fsSimaServicios

Public Class VerificarArchivos
    Inherits System.Web.UI.Page

    Dim _servicios As ExpedientesServicios

    Private Sub VerificarArchivos_Init(sender As Object, e As EventArgs) Handles Me.Init
        _servicios = New ExpedientesServicios(Session("AdminConnString").ToString, DirImagenes)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = "USOC" Or Session("LoginUsuarioVirtual").ToString.ToUpperInvariant = "SUPERUSER" Then    'Perfil usuario administrador
            If Not IsPostBack Then
                ObtieneEstadisticaExpedientes()
            End If

            txtVerificados.Text = "0"

        Else
            Response.Redirect("Logout.aspx")
        End If
    End Sub

    Protected Sub BtnIniciarVerificacion_Click(sender As Object, e As EventArgs) Handles btnIniciarVerificacion.Click

        _servicios.VerificaArchivos()
        txtVerificados.Text = _servicios.NuevosArchivosLocalizados.ToString
        btnIniciarVerificacion.Enabled = True

        ObtieneEstadisticaExpedientes()

    End Sub

    Private Sub ObtieneEstadisticaExpedientes()
        With _servicios
            .ObtieneEstadisticaArchivos()
            txtTotalExpedientes.Text = .TotalExpedientesBD
            txtExpedientesConArchivos.Text = .ExpedientesConArchivoBD.ToString
            txtExpedientesSinArchivos.Text = .ExpedientesSinArchivoBD.ToString
            txtArchivosLocalizados.Text = .ArchivosLocalizadosFS.ToString
            txtArchivosNoLocalizados.Text = .ArchivosNoLocalizadosFS.ToString
            txtAplicaDigitalizacion.Text = .ArchivosConDigitalizacion.ToString
            txtNoAplicaDigitalizacion.Text = .ArchivosSinDigitalizacion.ToString
            txtImagenesEsperadas.Text = .ImagenesEsperadas.ToString

            grvDetalle.DataSource = .Detalle
            grvDetalle.DataBind()

        End With
    End Sub

End Class