using System;
using System.Collections.Generic;
using System.Net;
using System.Web.Http;
using System.Web.Http.Description;

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
        [ResponseType(typeof(List<ExpedienteMetadata>))]
        [Route("ObtenerMetadata")]
        public IHttpActionResult ObtenerMetadata(int maximoRegistros, bool marcarTransferido = false)
        {
            try
            {
                if (maximoRegistros <= 0)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                return Ok(new ExpedientesServicio().ObtenerMetadata(maximoRegistros, marcarTransferido));
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }

        /// <summary>
        /// Obtiene una imagen a partir del identificador de la misma.
        /// </summary>
        /// <param name="idExpediente">Identificador de expediente.</param>
        /// <param name="idImagen">Identificador de imagen.</param>
        /// <returns></returns>
        [HttpGet]
        [ResponseType(typeof(string))]
        [Route("ObtenerImagen")]
        public IHttpActionResult ObtenerImagen(int idExpediente, int idImagen)
        {
            try
            {
                if (idImagen <= 0)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                return Ok(new ExpedientesServicio().ObtenerImagen(idExpediente, idImagen));
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }
    }
}
