using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;

namespace fsSimaServicios
{
    public class ClienteSQL
    {
        #region Propiedades públicas.

        public string CadenaConexionDB { get; set; }

        #endregion Propiedades públicas.

        #region Constructor.

        public ClienteSQL()
        {
        }

        public ClienteSQL(string cadenaConexionDb)
        {
            CadenaConexionDB = cadenaConexionDb;
        }

        #endregion Constructor.

        #region Métodos públicos.

        public DataSet ObtenerRegistrosSql(SqlParameter[] parametros, string storedProcedure)
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
#if DEBUG
            catch (Exception e)
#else
            catch(Exception)
#endif
            {
                return new DataSet();
            }
        }

        public DataSet ObtenerRegistros(OleDbParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new OleDbConnection(CadenaConexionDB))
                {
                    var dataSet = new DataSet();
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);

                        using (var sqlDataAdapter = new OleDbDataAdapter(sqlCommand))
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

        public T ObtenerEscalar<T>(OleDbParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new OleDbConnection(CadenaConexionDB))
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
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);
                        sqlCommand.ExecuteNonQuery();
                    }
                    return true;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public bool EjecutaProcedimiento(OleDbParameter[] parametros, string storedProcedure)
        {
            try
            {
                using (var sqlConn = new OleDbConnection(CadenaConexionDB))
                {
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.CommandText = storedProcedure;
                        if (parametros != null)
                            sqlCommand.Parameters.AddRange(parametros);
                        sqlCommand.ExecuteNonQuery();
                    }
                    return true;
                }
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public DataSet ObtieneRegistrosDesdeCadenaSql(string cadenaSql)
        {
            try
            {
                using (var sqlConn = new OleDbConnection(CadenaConexionDB))
                {
                    var dataSet = new DataSet();
                    sqlConn.Open();
                    using (var sqlCommand = sqlConn.CreateCommand())
                    {
                        sqlCommand.CommandType = CommandType.Text;
                        sqlCommand.CommandText = cadenaSql;

                        using (var sqlDataAdapter = new OleDbDataAdapter(sqlCommand))
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

        public SqlParameter[] CreaParametros(Dictionary<string, object> parametrosValores)
        {
            try
            {
                var parametros = new SqlParameter[parametrosValores.Count];
                var i = 0;
                foreach (var item in parametrosValores)
                {
                    parametros[i++] = new SqlParameter(item.Key, item.Value);
                }

                return parametros;
            }
            catch (Exception)
            {
                return default;
            }
        }

        public SqlParameter[] CreaParametros(string parametro, object valor)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter(parametro, valor);

                return parametros;
            }
            catch (Exception)
            {
                return default;
            }
        }

#endregion Métodos públicos.
    }
}

