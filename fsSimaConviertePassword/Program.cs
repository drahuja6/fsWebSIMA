using System;
using System.Data;
using System.Data.SqlClient;

using GITDataTools;

using fsSimaServicios;

namespace fsSimaConviertePassword
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {                
                var k = Convert.ToChar(25).ToString();
                k += Convert.ToChar(26).ToString();
                var sqlCliente = new ClienteSQL(Properties.Settings.Default.CadenaConexion);
                var scramble = new ScrambleNET();
                var cryp = new Encripcion(Properties.Settings.Default.CodigoAcceso);

                var usuarios = sqlCliente.ObtenerRegistrosSql(null, "UsuariosVirtuales_SELECTALL").Tables[0];
                
                foreach(DataRow dr in usuarios.Rows)
                {
                    var sqlParams = new SqlParameter[2];
                    sqlParams[0] = new SqlParameter("@IdUsuario", dr["idUsuarioVirtual"].ToString());
                    sqlParams[1] = new SqlParameter("@Password", cryp.Encripta(scramble.Scramble(dr["Password"].ToString(), k)));

                    sqlCliente.EjecutaProcedimientoSql(sqlParams, "conviertePassword");
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}
