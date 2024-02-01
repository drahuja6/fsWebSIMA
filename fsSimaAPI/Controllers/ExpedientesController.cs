using fsSimaServicios;
using Swashbuckle.Swagger;
using System;
using System.Collections.Generic;
using System.IdentityModel.Protocols.WSTrust;
using System.IO;
using System.Net;
using System.Net.Http;
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
        [ResponseType(typeof(DocumentoContenido))]
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

        /// <summary>
        /// Obtiene una imagen a partir del identificador de la misma.
        /// </summary>
        /// <param name="idExpediente">Identificador de expediente.</param>
        /// <param name="idImagen">Identificador de imagen.</param>
        /// <returns></returns>
        [HttpGet]
        [Route("ObtenerArchivoImagen")]
        public HttpResponseMessage ObtenerArchivoImagen(int idExpediente, int idImagen)
        {
            try
            {
                if (idImagen <= 0)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                var file = new ExpedientesServicio().ObtenerNombreArchivoImagen(idExpediente, idImagen);

                var infoArchivo = new FileInfo(file);
                var response = Request.CreateResponse(HttpStatusCode.OK);

                if (infoArchivo.Exists)
                {
                    response.Content = new ByteArrayContent(File.ReadAllBytes(file));

                    var contentType = "application/pdf";
                    switch (infoArchivo.Extension)
                    {
                        case ".pdf":
                            contentType = "application/pdf";
                            break;
                        case ".xls":
                        case ".xlsx":
                            contentType = "application/vnd.ms-excel";
                            break;
                        default:
                            contentType = "application/pdf";
                            break;
                    }

                    response.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue(contentType);
                    //response.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue($"attachment; filename={infoArchivo.Name}");                   

                    return response;
                }
                else
                {
                    throw new HttpResponseException(HttpStatusCode.NotFound);
                }
            }
            catch (Exception)
            {
                return new HttpResponseMessage(HttpStatusCode.InternalServerError);
            }
        }

        /// <summary>
        /// Establece estatus de transferencia del expediente.
        /// </summary>
        /// <param name="idExpediente"></param>
        /// <param name="transferido"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("transferido")]
        public IHttpActionResult EstatusTransferido(int idExpediente, bool transferido = true)
        {
            try
            {
                if (idExpediente <= 0)
                    throw new HttpResponseException(HttpStatusCode.BadRequest);

                return Ok(new ExpedientesServicio().EstatusTransferido(idExpediente, transferido));
            }
            catch (Exception)
            {
                return InternalServerError();
            }

        }
    }
}
