using System;
using System.Text;
using System.IO;
using System.Data;
using System.Data.OleDb;

namespace fsSimaServicios
{
    public class ExpedientesServicios
    {
        public string CadenaConexion { get; set; }
        public string Directorio { get; set; }

        public int NuevosArchivosLocalizados { get; private set; }

        public int TotalExpedientesBD { get; private set; }
        public int ExpedientesConArchivoBD { get; private set; }
        public int ExpedientesSinArchivoBD { get; private set; }
        public int ArchivosLocalizadosFS { get; private set; }
        public int ArchivosNoLocalizadosFS { get; private set; }
        public int ArchivosSinDigitalizacion { get; private set; }
        public int ArchivosConDigitalizacion { get; private set; }
        public int ImagenesEsperadas { get; private set; }

        public DataTable Detalle { get; private set; }

        public ExpedientesServicios(string cadenaConexion, string directorio)
        {
            CadenaConexion = cadenaConexion;
            Directorio = directorio;
        }

        public void VerificaArchivos()
        {
            NuevosArchivosLocalizados= VerificaArchivos(CadenaConexion, Directorio);
        }

        private int VerificaArchivos(string cadenaConexionDb, string directorio)
        {
            try
            {
                var sqlCliente = new ClienteSQL(cadenaConexionDb);
                var listaIdsVerificados = new StringBuilder();
                var listaIdsNoLocalizados = new StringBuilder();
                var cuentaLocalizados = 0;

                var ds = sqlCliente.ObtenerRegistros(null, "ExpedientesPDF_Archivos_SELECT_ALL");

                if (ds != null && ds.Tables.Count == 1)
                {
                    var dt = ds.Tables[0];

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (File.Exists(Path.Combine(directorio, dr["NombrePDF"].ToString())))
                        {
                            if (!(bool)dr["Verificado"])
                            {
                                listaIdsVerificados.Append(dr["idExpedientePDFRelaciones"]);
                                listaIdsVerificados.Append(',');
                                cuentaLocalizados++;
                            }
                        }
                        else
                        {
                            listaIdsNoLocalizados.Append(dr["idExpedientePDFRelaciones"]);
                            listaIdsNoLocalizados.Append(',');
                        }
                    }
                    var pars = new OleDbParameter[2];
                    pars[0] = new OleDbParameter("@IdList", OleDbType.LongVarWChar);
                    pars[1] = new OleDbParameter("@Verificado", OleDbType.Boolean);
                    // Actualizo marca de los localizados.
                    pars[0].Value = listaIdsVerificados.ToString();
                    pars[1].Value = true;
                    sqlCliente.EjecutaProcedimiento(pars, "ExpedientesPDF_Archivos_Verifica");
                    // Actualizo marca de los no localizados.
                    pars[0].Value = listaIdsNoLocalizados.ToString();
                    pars[1].Value = false;
                    sqlCliente.EjecutaProcedimiento(pars, "ExpedientesPDF_Archivos_Verifica");
                }
                return cuentaLocalizados;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public void ObtieneEstadisticaArchivos()
        {
            ObtieneEstadisticaArchivos(CadenaConexion);
        }

        private void ObtieneEstadisticaArchivos(string cadenaConexion)
        {
            var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(null, "EstadisticaExpedientes");

            if (ds != null && ds.Tables.Count > 0)
            {
                TotalExpedientesBD = (int)ds.Tables[0].Rows[0]["TotalExpedientesBD"];
                ExpedientesConArchivoBD = (int)ds.Tables[0].Rows[0]["ExpedientesConArchivoBD"];
                ExpedientesSinArchivoBD = (int)ds.Tables[0].Rows[0]["ExpedientesSinArchivoBD"];
                ArchivosLocalizadosFS = (int)ds.Tables[0].Rows[0]["ArchivosLocalizadosFS"];
                ArchivosNoLocalizadosFS = (int)ds.Tables[0].Rows[0]["ArchivosNoLocalizadosFS"];
                ArchivosSinDigitalizacion = (int)ds.Tables[0].Rows[0]["SinDigitalizacion"];
                ArchivosConDigitalizacion = (int)ds.Tables[0].Rows[0]["ConDigitalizacion"];
                ImagenesEsperadas = (int)ds.Tables[0].Rows[0]["TotalImagenes"];

                Detalle = ds.Tables[1];
            }
        }
    }
}
