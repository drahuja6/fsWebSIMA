Public Class Logout
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Session("AdminConnString") = ""
        Session("OrdenDeGridDeExpedientes") = ""
        Session("SubdirectorioDeImagenes") = ""
        Session("SubdirectorioTemporal") = ""
        Session("LimiteDeRecordsEnBusqueda") = 0
        Session("UsuarioVirtualConnString") = ""
        Session("IDExpedienteActivo") = -1
        Session("IDMovimientoActivo") = -1
        Session("idCuadroClasificacionActivo") = -1
        Session("TextoCuadroClasificacionEscogido") = ""
        Session("idUsuarioRealEnEdicionActivo") = -1
        Session("idPlazoDeConservacionTramiteActivo") = -1
        Session("idPlazoDeConservacionConcentracionActivo") = -1
        Session("idDestinoFinalActivo") = -1
        Session("idInformacionClasificadaActivo") = -1
        Session("idClasificacionActivo") = -1
        Session("CodigoCompletoCuadroClasificacion") = -1
        Session("NextLeftActivo") = 0
        Session("NextRightActivo") = 0
        Session("ExpedienteStatus") = 0
        Session("MovimientoStatus") = 0
        Session("CuadroClasificacionStatus") = 0
        Session("UsuarioRealStatus") = 0
        Session("LoginActivo") = ""
        Session("IDUsuarioReal") = ""
        Session("NombreUsuarioReal") = ""

        Response.Redirect("./FrameSet1.htm")
    End Sub

End Class