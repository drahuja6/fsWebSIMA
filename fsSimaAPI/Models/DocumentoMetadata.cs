namespace fsSimaAPI
{
    /// <summary>
    /// Identificación del documento.
    /// </summary>
    public class DocumentoMetadata
    {
        /// <summary>
        /// Identificador interno del documento.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Nombre del archivo.
        /// </summary>
        public string NombreArchivo { get; set; }
        /// <summary>
        /// Identificador interno del expediente al que está vinculado el documento.
        /// </summary>
        public int IdExpediente { get; set; }
        /// <summary>
        /// Existencia verificada en el file system.
        /// </summary>
        public bool Verificado { get; set; }
    }
}