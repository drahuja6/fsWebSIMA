using System;
using System.Data;
using System.Data.SqlClient;

namespace fsSimaServicios
{
    public class ExpedientesBatchServicios
    {
        public string CadenaConexion { get; set; }

        public ExpedientesBatchServicios(string cadenaConexion)
        {
            CadenaConexion = cadenaConexion;
        }

        public int Batches_Insert(string descripcion, int idOperador, DateTime fechaCreacion, int tipoDeBatch, int idUnidAdm, DateTime fechaCorte)
        {
            var parametros = new SqlParameter[7];

            parametros[0] = new SqlParameter("@Descripcion", descripcion);
            parametros[1] = new SqlParameter("@IdOperador", idOperador);
            parametros[2] = new SqlParameter("@FechaCreacion", fechaCreacion);
            parametros[3] = new SqlParameter("@IdTipoDeBatch", tipoDeBatch);
            parametros[4] = new SqlParameter("@IdUnidAdm", idUnidAdm);
            parametros[5] = new SqlParameter("@FechaCorte", fechaCorte);
            parametros[6] = new SqlParameter("@IdRecordOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_INSERT");

            return (int)parametros[6].Value;

        }

        public int Batches_Relaciones_Insert(int idBatch, int idExpediente, string cajaProv)
        {
            var parametros = new SqlParameter[4];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@IdExpediente", idExpediente);
            parametros[2] = new SqlParameter("@CajaProv", cajaProv);
            parametros[3] = new SqlParameter("@IdRecordOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_Relaciones_INSERT");

            return (int)parametros[3].Value;
        }

        public int Batches_Relaciones_Insert(int idBatch, DataTable batchRelaciones)
        {
            var parametros = new SqlParameter[3];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@BatchesRelaciones", batchRelaciones);
            parametros[2] = new SqlParameter("@IdRecordOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_Relaciones_InsertV1");

            return (int)parametros[2].Value;
        }

        public int Batches_Delete(int idBatch)
        {
            var parametros = new SqlParameter[2];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@IdRecordProcesadoOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_Delete");

            return (int)parametros[1].Value;
        }

        public int Batches_Relaciones_Delete(int idBatch, int idExpediente, int statusDeRegreso)
        {
            var parametros = new SqlParameter[4];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@IdExpediente", idExpediente);
            parametros[2] = new SqlParameter("@StatusDeRegreso", statusDeRegreso);
            parametros[3] = new SqlParameter("@IdBatchEliminado", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_Relaciones_Delete");

            return (int)parametros[3].Value;
        }

        public int Batches_Relaciones_Update(int idBatch, DataTable batchRelaciones)
        {
            var parametros = new SqlParameter[3];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@BatchesRelaciones", batchRelaciones);
            parametros[2] = new SqlParameter("@IdRecordOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_Relaciones_CajaProv2_UpdateV1");

            return (int)parametros[2].Value;
        }

        public int ExpedientesActualiza_StatusConcentracion(int idBatch)
        {
            var parametros = new SqlParameter[2];

            parametros[0] = new SqlParameter("@IdBatch", idBatch);
            parametros[1] = new SqlParameter("@IdRecordProcesadoOK", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };

            new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Expedientes_Update_StatusConcentracion");

            return (int)parametros[1].Value;
        }

        public bool Batch_VerificaEstatusExpediente(int idBatch, int statusAComprobar)
        {
            try
            {
                var parametros = new SqlParameter[3];
                parametros[0] = new SqlParameter("@IdBatch", idBatch);
                parametros[1] = new SqlParameter("@StatusAComprobar", statusAComprobar);
                parametros[2] = new SqlParameter("@Respuesta", SqlDbType.Int);
                parametros[2].Direction = ParameterDirection.Output;

                new ClienteSQL(CadenaConexion).EjecutaProcedimiento(parametros, "Batches_VerificarEstatusExpedientes");

                return (int)parametros[2].Value != 0;

            }
            catch (Exception)
            {
                return false;
            }

        }
    }
}
