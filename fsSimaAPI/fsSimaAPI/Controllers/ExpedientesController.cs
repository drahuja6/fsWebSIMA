using System;
using System.Net;
using System.Web.Http;

namespace fsSimaAPI.Controllers
{
    /// <summary>
    /// Controlador de API para decargar información de expedientes.
    /// </summary>
    [Authorize]
    [RoutePrefix("Api/Expedientes")]
    public class ExpedientesController : ApiController
    {
        /// <summary>
        /// Obtiene Metadata de los expedientes no transmitidos.
        /// </summary>
        /// <returns>Listado con metadata de expedientes.</returns>
        [HttpGet]
        [Route("ObtenerMetadata")]
        public IHttpActionResult ObtenerMetadata()
        {
            try
            {
                return Ok(new ExpedientesServicio().ObtenerMetadata());
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }

        /// <summary>
        /// Obtiene una imagen a partir del identificador de la misma.
        /// </summary>
        /// <param name="idImagen">Identificador de imagen</param>
        /// <returns></returns>
        [HttpGet]
        [Route("ObtenerImagen")]
        public IHttpActionResult ObtenerImagen(int idImagen)
        {
            try
            {
                if (idImagen <= 0)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                return Ok(new ExpedientesServicio().ObtenerImagen(idImagen));
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }
    }
}
