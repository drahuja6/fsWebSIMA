using System;
using System.Configuration;
using System.Data.SqlClient;

using fsSimaServicios;

namespace fsSimaAPI
{
    internal class AccesoServicio
    {
        #region Campos privados globales a la clase

        #endregion Campos privados globales a la clase

        #region Constructores

        #endregion Constructores

        #region Métodos públicos
        public LoginResponse AutentificarUsuario(LoginRequest loginData, string ip)
        {
            try
            {
                var sqlCliente = new ClienteSQL(ConfigurationManager.AppSettings["CadenaConexion"]);
                var codigoAcceso = ConfigurationManager.AppSettings["CodigoAcceso"];

                var sqlParams = new SqlParameter[4];

                sqlParams[0] = new SqlParameter("@LoginUsuarioReal", loginData.User);
                sqlParams[1] = new SqlParameter("@PasswordUsuarioReal", new Encripcion(codigoAcceso).Encripta(loginData.Password));
                sqlParams[2] = new SqlParameter("@LoginUsuarioVirtual", System.Data.SqlDbType.NVarChar, 50)
                {
                    Direction = System.Data.ParameterDirection.Output
                };
                sqlParams[3] = new SqlParameter("@PasswordUsuarioVirtual", System.Data.SqlDbType.NVarChar, 50)
                {
                    Direction = System.Data.ParameterDirection.Output
                };

                sqlCliente.EjecutaProcedimientoSql(sqlParams, "Get_UsuarioVirtual_From_UsuarioReal");

                var loginResponse = new LoginResponse
                {
                    AuthenticationOk = false
                };

                if (sqlParams[2].Value != null && sqlParams[3].Value != null)
                {
                    if (sqlParams[2].Value.ToString() != "?")
                    {
                        loginResponse.AuthenticationToken = TokenGenerator.GenerateTokenJwt(loginData.User);
                        if (!string.IsNullOrEmpty(loginResponse.AuthenticationToken))
                            loginResponse.AuthenticationOk = true;
                    }
                }
   
                Accesorios.EscribeBitacoraBD(ConfigurationManager.AppSettings["CadenaConexion"], loginData.User, ip, loginResponse.AuthenticationOk, 1000); //ApId=1000 para API.

                return loginResponse;
            }
            catch (Exception)
            {
                return default; ;
            }
        }

        #endregion Métodos públicos

        #region Métodos privados

        #endregion Métodos privados
    }
}