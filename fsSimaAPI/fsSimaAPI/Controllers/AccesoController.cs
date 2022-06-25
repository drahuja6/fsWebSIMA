using System;
using System.Net;
using System.Web.Http;

namespace fsSimaAPI.Controllers
{
    /// <summary>
    /// Controlador de API para autentificación y acceso.
    /// </summary>
    [Authorize]
    [RoutePrefix("Api/Acceso")]
    public class AccesoController : ApiController
    {
        /// <summary>
        /// Autentifica y obtiene token para aplicación.
        /// </summary>
        /// <param name="login">Objeto <strong>Login</strong> que contiene información para autentificación.</param>
        /// <returns>Resultado de la autentificación en <strong>LogonResponse</strong>.</returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("Autentificacion")]
        public IHttpActionResult Autentificacion(LoginRequest login)
        {
            try
            {
                if (login == null)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                return Ok(new AccesoServicio().AutentificarUsuario(login, System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] ?? System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]));
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }
    }
}
