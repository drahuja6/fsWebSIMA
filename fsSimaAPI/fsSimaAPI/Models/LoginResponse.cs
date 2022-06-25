namespace fsSimaAPI
{
    /// <summary>
    /// Objeto que contiene el resultado de la autentificación.
    /// </summary>
    public class LoginResponse
    {
        /// <summary>
        /// Bandera activa si la autentificación fue exitosa.
        /// </summary>
        public bool AuthenticationOk { get; set; }
        /// <summary>
        /// Cadena que contiene el token de autentificación.
        /// </summary>
        public string AuthenticationToken { get; set; }
    }
}