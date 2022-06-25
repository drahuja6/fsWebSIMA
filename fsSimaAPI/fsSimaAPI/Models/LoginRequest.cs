namespace fsSimaAPI
{
    /// <summary>
    /// Objeto para autentitifiación de usuario.
    /// </summary>
    public class LoginRequest
    {
        /// <summary>
        /// Identificador de usuario.
        /// </summary>
        public string User { get; set; }
        /// <summary>
        /// Contraseña de usuario.
        /// </summary>
        public string Password { get; set; }
    }
}