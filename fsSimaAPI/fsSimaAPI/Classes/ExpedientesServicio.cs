using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.IO;
using System.Security.Cryptography;

using fsSimaServicios;

namespace fsSimaAPI
{
    internal class ExpedientesServicio
    {

        #region Métodos públicos

        public List<ExpedienteMetadata> ObtenerMetadata(int maximoRegistros, bool marcarTransferido)
        {
            try
            {
                var sqlCliente = new ClienteSQL(ConfigurationManager.AppSettings["CadenaConexion"]);

                var sqlParams = new SqlParameter[2];
                sqlParams[0] = new SqlParameter("@MaximoRegistros", maximoRegistros);
                sqlParams[1] = new SqlParameter("@ActualizaMarcaTransferencia", marcarTransferido);

                var ds = sqlCliente.ObtenerRegistrosSql(sqlParams, "Expedientes_TransferenciaWS");

                return ConstruyeLista(ds);
            }
            catch (Exception)
            {
                return default;
            }
        }

        public DocumentoContenido ObtenerImagen(int idExpediente, int idImagen)
        {
            try
            {
                var sqlCliente = new ClienteSQL(ConfigurationManager.AppSettings["CadenaConexion"]);
                var sqlParams = new SqlParameter[3];

                sqlParams[0] = new SqlParameter("@IdExpediente", idExpediente);
                sqlParams[1] = new SqlParameter("@IdImagen", idImagen);
                sqlParams[2] = new SqlParameter("@NombreArchivo", SqlDbType.NVarChar, 1024)
                {
                    Direction = ParameterDirection.Output
                };

                sqlCliente.EjecutaProcedimientoSql(sqlParams, "Imagen_TransferenciaWS");

                if (sqlParams[2].Value != null)
                {
                    var contenido = new DocumentoContenido
                    {
                        Id = idImagen
                    };
                    var file = Path.Combine(ConfigurationManager.AppSettings["DirectorioImagenes"], sqlParams[2].Value.ToString().Trim());
                    contenido.Contenido64 = Convert.ToBase64String(File.ReadAllBytes(file)); 
                    using (var md5 = MD5.Create())
                    {
                        using (var fs = File.OpenRead(file))
                        {
                            contenido.MD5 = BitConverter.ToString(md5.ComputeHash(fs)).Replace("-", "").ToLowerInvariant();
                        }
                    }
                    return contenido;
                }
                else
                    return default;
            }
            catch (Exception)
            {
                return default;
            }
        }

        #endregion Métodos públicos

        #region Métodos privados

        private List<ExpedienteMetadata> ConstruyeLista(DataSet ds)
        {
            try
            {
                var expedientes = ds.Tables[0];
                var documentos = ds.Tables[1];

                var listaExpedientes = expedientes.AsEnumerable().Select(dr => new ExpedienteMetadata
                {
                    Id = int.Parse(dr["Id"].ToString()),
                    CodigoClasificacion = dr["CodigoClasificacion"].ToString(),
                    NumeroExpediente = dr["NumeroExpediente"].ToString(),
                    UnidadAdministrativa = dr["UnidadAdministrativa"].ToString(),
                    NumeroCaja = dr["NumeroCaja"].ToString(),
                    Titulo = dr["Titulo"].ToString(),
                    Asunto = dr["Asunto"].ToString(),
                    Apertura = DateTime.Parse(dr["Apertura"].ToString()),
                    Cierre = DateTime.Parse(dr["Cierre"].ToString()),
                    NumeroHojas = int.Parse(dr["NumeroHojas"].ToString())
                }).ToList();

                foreach (var expediente in listaExpedientes)
                {
                    expediente.Documentos = documentos.AsEnumerable()
                        .Where(x => Convert.ToInt32(x["IdExpediente"]) == expediente.Id)
                        .Select(doc => new DocumentoMetadata
                        {
                            Id = int.Parse(doc["Id"].ToString()),
                            NombreArchivo = doc["NombreArchivo"].ToString(),
                            IdExpediente = int.Parse(doc["IdExpediente"].ToString()),
                            Verificado = bool.Parse(doc["Verificado"].ToString())
                        }).ToList(); 
                }

                return listaExpedientes;
            }
            catch (Exception)
            {
                return default;
            }
        }


        #endregion Métodos privados
    }
}