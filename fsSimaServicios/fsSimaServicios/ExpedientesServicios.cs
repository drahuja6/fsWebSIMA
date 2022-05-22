using System;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Collections.Generic;

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
        public int TotalHojasBD { get; private set; }
        public int TotalArchivosEnDirectorio { get; private set; }
        public int ArchivosDirectorioVinculados { get; private set; }
        public int ArchivosDirectorioSinVincular { get; private set; }
        public int EspacionEnDisco { get; private set; }

        public DataTable Detalle { get; private set; }

        public ExpedientesServicios(string cadenaConexion, string directorio)
        {
            CadenaConexion = cadenaConexion;
            Directorio = directorio;
        }

        public void VerificaArchivos(bool reiniciarContadores = false)
        {
            NuevosArchivosLocalizados = VerificaArchivos(CadenaConexion, Directorio, reiniciarContadores);
        }

        public void VerificaArchivosFS()
        {
            VerificaArchivosFS(CadenaConexion, Directorio, "", "", false);
        }

        public void VerificaArchivosFS(string directorioTemporal, string nombreArchivoExcel, bool generarArchivoExcel)
        {
            VerificaArchivosFS(CadenaConexion, Directorio, directorioTemporal, nombreArchivoExcel, generarArchivoExcel);
        }

        private int VerificaArchivos(string cadenaConexionDb, string directorio, bool reiniciarContadores)
        {
            try
            {
                var sqlCliente = new ClienteSQL(cadenaConexionDb);
                var listaIdsVerificados = new StringBuilder();
                var listaIdsNoLocalizados = new StringBuilder();
                var cuentaLocalizados = 0;

                if (reiniciarContadores)
                    sqlCliente.EjecutaProcedimientoSql(null, "ExpedientesPDF_ReiniciaBanderaVerificacion");

                var ds = sqlCliente.ObtenerRegistrosSql(null, "ExpedientesPDF_Archivos_SELECT_ALL");

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
                    var pars = new SqlParameter[2];
                    pars[0] = new SqlParameter("@IdList", SqlDbType.Text);
                    pars[1] = new SqlParameter("@Verificado", SqlDbType.Bit);
                    // Actualizo marca de los localizados.
                    pars[0].Value = listaIdsVerificados.ToString();
                    pars[1].Value = true;
                    sqlCliente.EjecutaProcedimientoSql(pars, "ExpedientesPDF_Archivos_Verifica");
                    // Actualizo marca de los no localizados.
                    var pars1 = new SqlParameter[2];
                    pars1[0] = new SqlParameter("@IdList", listaIdsNoLocalizados.ToString());
                    pars1[1] = new SqlParameter("@Verificado", false);
                    sqlCliente.EjecutaProcedimientoSql(pars1, "ExpedientesPDF_Archivos_Verifica");
                }
                return cuentaLocalizados;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        private void VerificaArchivosFS(string cadenaConexionDb, string directorio, string directorioTemporal, string nombreArchivoExcel, bool generarArchivoExcel)
        {
            try
            {
                string[] archivosFS;
                string[] archivosBD;

                var ds = new ClienteSQL(cadenaConexionDb).ObtenerRegistrosSql(null, "ExpedientesPDF_Archivos_SELECT_ALL");

                if (ds != null && ds.Tables.Count == 1)
                {
                    archivosBD = new string[ds.Tables[0].Rows.Count];
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        archivosBD[i] = Path.Combine(directorio, ds.Tables[0].Rows[i]["NombrePDF"].ToString()).Replace("\\", "/").ToUpperInvariant();
                    }

                    archivosFS = Directory.GetFiles(directorio, "*.PDF", SearchOption.AllDirectories);

                    TotalArchivosEnDirectorio = archivosFS.Length;

                    for (int i = 0; i < archivosFS.Length; i++)
                    {
                        archivosFS[i] = archivosFS[i].Replace("\\", "/").ToUpperInvariant();
                    }
                    var noHalladosFS = archivosFS.Except(archivosBD).ToList();
                    var noHalladosBD = archivosBD.Except(archivosFS).ToList();

                    // Propiedades para mostrar en UI
                    TotalArchivosEnDirectorio = archivosFS.Length;
                    ArchivosDirectorioVinculados = archivosFS.Intersect(archivosBD).Count();
                    ArchivosDirectorioSinVincular = noHalladosFS.Count;
                    EspacionEnDisco = (int)Math.Round(Directory.GetFiles(directorio, "*.PDF", SearchOption.AllDirectories).Sum(t => (new FileInfo(t).Length)) / Math.Pow(1024.0, 2), 0);

                    if (generarArchivoExcel)
                    {
                        // Preparo exportación a Excel con los resultados del proceso.
                        DataTable[] dt = new DataTable[2];
                        dt[0] = new DataTable();
                        dt[0].Columns.Add("NombreArchivo", typeof(string));
                        dt[1] = new DataTable();
                        dt[1].Columns.Add("NombreArchivo", typeof(string));

                        foreach (var archivo in noHalladosFS)
                        {
                            dt[0].Rows.Add(archivo);
                        }

                        foreach (var archivo in noHalladosBD)
                        {
                            dt[1].Rows.Add(archivo);
                        }
                        var archivoExcel = Accesorios.GeneraReporteExcel(dt, Path.Combine(directorioTemporal, string.IsNullOrEmpty(nombreArchivoExcel) ? "ConciliacionDirectorio" : nombreArchivoExcel), new string[] { "FS_SinCorrespondencia_BD", "BD_SinCorrespondencia_FS" }, new string[] { "Archivos de imagen en el directorio sin datos en la base de datos.", "Datos de archivo en la BD no localizados en el directorio." });
                    }
                }
            }
            catch (Exception e)
            {
            }
        }

        public void ObtieneEstadisticaArchivos()
        {
            ObtieneEstadisticaArchivos(CadenaConexion);
        }

        private void ObtieneEstadisticaArchivos(string cadenaConexion)
        {
            var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(null, "EstadisticaExpedientes");

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
                TotalHojasBD = (int)ds.Tables[0].Rows[0]["TotalHojasBD"];

                Detalle = ds.Tables[1];
            }
        }
    }
}


