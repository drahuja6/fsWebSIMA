using System;
using System.Configuration;
using System.Data.SqlClient;

using GITDataTools;

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
                var k = Convert.ToChar(25).ToString();
                k += Convert.ToChar(26).ToString();

                var sqlParams = new SqlParameter[4];

                sqlParams[0] = new SqlParameter("@LoginUsuarioReal", loginData.User);
                sqlParams[1] = new SqlParameter("@PasswordUsuarioReal", new ScrambleNET().Scramble(loginData.Password, k));
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
                    loginResponse.AuthenticationToken = TokenGenerator.GenerateTokenJwt(loginData.User);
                    if (!string.IsNullOrEmpty(loginResponse.AuthenticationToken))
                        loginResponse.AuthenticationOk = true;
                }

                RegistraBitacora(loginData, ip, loginResponse.AuthenticationOk);

                return loginResponse;
            }
            catch (Exception)
            {
                return default; ;
            }
        }

        #endregion Métodos públicos

        #region Métodos privados

        private bool RegistraBitacora(LoginRequest loginData, string ip, bool loginOK, int appId = 000)
        {
            try
            {
                var sqlCliente = new ClienteSQL(ConfigurationManager.AppSettings["CadenaConexion"]);

                SqlParameter[] parametros = new SqlParameter[4];
                parametros[0] = new SqlParameter("@Identificador", loginData.User);
                parametros[1] = new SqlParameter("@IpAddress", ip);
                parametros[2] = new SqlParameter("@LoginStatus", loginOK);
                parametros[3] = new SqlParameter("@AppId", appId);

                return sqlCliente.EjecutaProcedimientoSql(parametros, "BitacoraAcceso_Insert");
            }
            catch (Exception)
            {
                return false;
            }
        }

        #endregion Métodos privados
    }
}