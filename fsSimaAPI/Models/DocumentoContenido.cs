namespace fsSimaAPI
{
    /// <summary>
    /// Devuelve el contenido de una imagen como String64.
    /// </summary>
    public class DocumentoContenido
    {
        /// <summary>
        /// Identificador de la imagen.
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// Contenido en String64.
        /// </summary>
        public string Contenido64 { get; set; }
        /// <summary>
        /// MD5 calculado desde el archivo original.
        /// </summary>
        public string MD5 { get; set; }
    }
}