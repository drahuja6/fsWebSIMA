using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace fsSimaAPI
{
    /// <summary>
    /// Contiene información general del expediente.
    /// </summary>
    public class ExpedienteMetadata
    {
        /// <summary>
        /// Identificador interno.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Código de clasificación archivísitica asignado.
        /// </summary>
        public string CodigoClasificacion { get; set; }
        /// <summary>
        /// Número consecutivo de expediente en función del código de clasificacion y la fecha de apertura.
        /// </summary>
        public string NumeroExpediente { get; set; }
        /// <summary>
        /// Unidad admiministrativa
        /// </summary>
        public string UnidadAdministrativa { get; set; }
        /// <summary>
        /// Identificador para la Unidad administrativa en sistemas externos.
        /// </summary>
        public int IdExterno { get; set; }
        /// <summary>
        /// Número de caja de almacenamiento
        /// </summary>
        public string NumeroCaja { get; set; }
        /// <summary>
        /// Título. 
        /// </summary>
        public string Titulo { get; set; }
        /// <summary>
        /// Asunto.
        /// </summary>
        public string Asunto { get; set; }
        /// <summary>
        /// Fecha de apertura.
        /// </summary>
        public DateTime Apertura { get; set; }
        /// <summary>
        /// Fecha de cierre del expediente en trámite.
        /// </summary>
        public DateTime Cierre { get; set; }
        /// <summary>
        /// Número de hojas totales.
        /// </summary>
        public int NumeroHojas { get; set; }
        /// <summary>
        /// Listado de documentos vinculados al expediente.
        /// </summary>
        public List<DocumentoMetadata> Documentos { get; set; }
    }
}