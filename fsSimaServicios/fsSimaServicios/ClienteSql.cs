using System;
using System.Data;
using System.Data.SqlClient;

namespace fsSimaServicios
{
    public class ClienteSQL
    {
        #region Propiedades públicas.

        public string CadenaConexionDB { get; set; }

        #endregion Propiedades públicas.

        #region Constructor.

        public ClienteSQL(string cadenaConexionDb)
        {
            CadenaConexionDB = cadenaConexionDb;
        }

        #endregion Constructor.

        #region Métodos públicos.

        public DataSet ObtenerRegistros(SqlParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new SqlConnection(CadenaConexionDB))
                {
                    var dataSet = new DataSet();
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);

                        using (var sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                        {
                            sqlDataAdapter.Fill(dataSet);
                        }
                    }
                    return dataSet;
                }
            }
            catch (Exception e)
            {
                return new DataSet();
            }
        }

        public T ObtenerEscalar<T>(SqlParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new SqlConnection(CadenaConexionDB))
                {
                    object scalar;
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);
                        scalar = sqlCommand.ExecuteScalar();
                    }
                    return scalar != null ? (T)scalar : default;
                }
            }
            catch (Exception)
            {
                return default;
            }
        }

        public bool EjecutaProcedimiento(SqlParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new SqlConnection(CadenaConexionDB))
                {
                    bool result;
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);
                        result = sqlCommand.ExecuteNonQuery() == 0;
                    }
                    return result;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public DataSet ObtieneRegistrosDesdeCadenaSql(string cadenaSql)
        {
            try
            {

                using (var sqlConn = new SqlConnection(CadenaConexionDB))
                {
                    var dataSet = new DataSet();
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.Text;
                        sqlCommand.CommandText = cadenaSql;

                        using (var sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                        {
                            sqlDataAdapter.Fill(dataSet);
                        }
                    }
                    return dataSet;
                }

            }
            catch (Exception)
            {
                return new DataSet();
            }
        }

        #endregion Métodos públicos.
    }
}

