using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Reflection;
using System.IO;

using ClosedXML.Excel;

namespace fsSimaServicios
{
    public class Accesorios
    {
        public static void CargaListBox(
            ListBox listBox, 
            string cadenaConexion, 
            string storedProcedure, 
            int idParametro, 
            string dataText, 
            string dataValue)
        {
            try
            {
                var parametros = new OleDbParameter[1];
                parametros[0] = new OleDbParameter("@IdParameter", idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parametros, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();
            }

            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaListBoxSql(
            ListBox listBox,
            string cadenaConexion,
            string storedProcedure,
            string nombreParametro,
            int idParametro,
            string dataText,
            string dataValue)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter(nombreParametro, idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parametros, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();
            }

            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaListBox(
            ListBox listBox,
            string cadenaConexion,
            string storedProcedure,
            int idParametro,
            string dataText,
            string dataValue,
            string dataSelected)
        {
            try
            {
                var parametros = new OleDbParameter[1];
                parametros[0] = new OleDbParameter("@IdParameter", idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parametros, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();

                listBox.SelectedValue = dataSelected;
            }
            catch (Exception e)
            { 
                ;
            }
        }

        public static void CargaListBoxSql(
            ListBox listBox,
            string cadenaConexion,
            string storedProcedure,
            string nombreParametro,
            int idParametro,
            string dataText,
            string dataValue,
            string dataSelected)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter(nombreParametro, idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parametros, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();

                listBox.SelectedValue = dataSelected;
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaListBox(
            ListBox listBox,
            string cadenaConexion,
            string storedProcedure,
            OleDbParameter[] parameters,
            string dataText,
            string dataValue)
        {
            try
            {
                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parameters, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaListBoxSql(
            ListBox listBox,
            string cadenaConexion,
            string storedProcedure,
            SqlParameter[] parameters,
            string dataText,
            string dataValue)
        {
            try
            {
                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parameters, storedProcedure);

                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaDropDownList(
            DropDownList dropDownList,
            string cadenaConexion,
            string storedProcedure,
            int idParametro,
            string dataText,
            string dataValue)
        {
            try
            {
                var parametros = new OleDbParameter[1];
                parametros[0] = new OleDbParameter("@IdParameter", idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parametros, storedProcedure);

                dropDownList.DataSource = ds.Tables[0];
                dropDownList.DataTextField = dataText;
                dropDownList.DataValueField = dataValue;

                dropDownList.DataBind();
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaDropDownListSql(
            DropDownList dropDownList,
            string cadenaConexion,
            string storedProcedure,
            string nombreParametro,
            int idParametro,
            string dataText,
            string dataValue)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter(nombreParametro, idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parametros, storedProcedure);

                dropDownList.DataSource = ds.Tables[0];
                dropDownList.DataTextField = dataText;
                dropDownList.DataValueField = dataValue;

                dropDownList.DataBind();
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaDropDownList(
            DropDownList dropDownList, 
            string cadenaConexion, 
            string storedProcedure, 
            int idParametro, 
            string dataText, 
            string dataValue,
            int dataSelected)
        {
            try
            {
                var parametros = new OleDbParameter[1];
                parametros[0] = new OleDbParameter("@IdParameter", idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parametros, storedProcedure);

                dropDownList.DataSource = ds.Tables[0];
                dropDownList.DataTextField = dataText;
                dropDownList.DataValueField = dataValue;

                dropDownList.DataBind();

                dropDownList.SelectedValue = dataSelected.ToString();
            }
            catch (Exception e)
            { 
                ;
            }
        }

        public static void CargaDropDownListSql(
            DropDownList dropDownList,
            string cadenaConexion,
            string storedProcedure,
            string nombreParametro,
            int idParametro,
            string dataText,
            string dataValue,
            int dataSelected)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter(nombreParametro, idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parametros, storedProcedure);

                dropDownList.DataSource = ds.Tables[0];
                dropDownList.DataTextField = dataText;
                dropDownList.DataValueField = dataValue;

                dropDownList.DataBind();

                dropDownList.SelectedValue = dataSelected.ToString();
            }
            catch (Exception e)
            {
                ;
            }
        }

        public static void CargaDropDownListSql(
            DropDownList dropDownList,
            string cadenaConexion,
            string storedProcedure,
            SqlParameter[] parametros,
            string dataText,
            string dataValue,
            int dataSelected)
        {
            try
            {
                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistrosSql(parametros, storedProcedure);

                dropDownList.DataSource = ds.Tables[0];
                dropDownList.DataTextField = dataText;
                dropDownList.DataValueField = dataValue;

                dropDownList.DataBind();

                dropDownList.SelectedValue = dataSelected.ToString();
            }
            catch (Exception e)
            {
                ;
            }
        }

        //Descarga archivo en general.
        public static void DescargaArchivo(HttpResponse response, string archivo, long longitudMaximaArchivo, string nombreArchivoDescarga = "", bool borraArchivoDescargado = false )
        {
            var infoArchivo = new FileInfo(archivo);
            if (infoArchivo.Exists)
            {
                switch (infoArchivo.Extension)
                {
                    case ".pdf":
                        response.ContentType = "application/pdf";
                        break;
                    case ".xls":
                    case ".xlsx":
                        response.ContentType = "application/vnd.ms-excel";
                        break;
                    default:
                        response.ContentType = "application/pdf";
                        break;
                }
                if (infoArchivo.Length > longitudMaximaArchivo)
                    response.AddHeader("content-Disposition", "attachment; filename=" + (!string.IsNullOrEmpty(nombreArchivoDescarga) ? nombreArchivoDescarga : infoArchivo.Name));
                else
                    response.AddHeader("content-Disposition", "inline; filename=" + (!string.IsNullOrEmpty(nombreArchivoDescarga) ? nombreArchivoDescarga : infoArchivo.Name));

                
                response.WriteFile(archivo);
                response.Flush();

                if (borraArchivoDescargado)
                {
                    File.Delete(archivo);
                }

                //response.End();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            else
                throw new HttpException(404, "Archivo no localizado");
        }

        public static DataTable CreaDataTable<T>(IEnumerable<T> list)
        {
            Type type = typeof(T);
            var properties = type.GetProperties();

            DataTable dataTable = new DataTable
            {
                TableName = typeof(T).FullName
            };
            foreach (PropertyInfo info in properties)
            {
                dataTable.Columns.Add(new DataColumn(info.Name, Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
            }

            foreach (T entity in list)
            {
                object[] values = new object[properties.Length];
                for (int i = 0; i < properties.Length; i++)
                {
                    values[i] = properties[i].GetValue(entity);
                }

                dataTable.Rows.Add(values);
            }

            return dataTable;
        }

        public static string GeneraReporteExcel(DataTable dt, string archivoXlsx, string hoja, string titulo)
        {
            return GeneraReporteExcel(new DataTable[] { dt }, archivoXlsx, new string[] { hoja }, new string[] { titulo });
        }

        public static string GeneraReporteExcel(DataTable[] dt, string archivoXlsx, string[] hoja, string[] titulo)
        {
            try
            {
                IXLWorksheet ws;
                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Author = "Full Service de México, S.A. de C.V.";

                    for (int i = 0; i < dt.Length; i++)
                    {
                        if (dt[i].Rows.Count > 0)
                        {
                            ws = wb.Worksheets.Add(dt[i], hoja[i]);
                            //ws.Column(1).Delete();
                            ws.Row(1).InsertRowsAbove(4);
                            ws.Cell(1, 1).Value = $"SIMA (Sistema para el manejo de archivos).";
                            ws.Cell(2, 1).Value = titulo[i];
                            ws.Cell(3, 1).Value = $"Fecha de ejecución: {DateTime.Now:yyyy-MM-ddTHH:mm:ss}";
                            ws.Columns().AdjustToContents(4);
                        }
                    }
                    wb.SaveAs(archivoXlsx);
                }
                return archivoXlsx;
            }
            catch (Exception e)
            {
                EscribeBitacora($"Error. {e.Message}\r\n{e.InnerException}", "fsSimaServicios.Accesorios.GeneraReporteExcel", "c:/prov");
                return "";
            }
        }

        public static void EscribeBitacora(string mensaje, string nombreAplicacion, string directorio)
        {
            try
            {
                var di = new DirectoryInfo($"{directorio}/{DateTime.Today.Year:D4}{DateTime.Today.Month:D2}");
                if (!di.Exists)
                    di.Create();

                using (FileStream objFilestream = new FileStream($"{di.FullName}/{nombreAplicacion}-{DateTime.Today.Year:D4}{DateTime.Today.Month:D2}{DateTime.Today.Day:D2}.txt", FileMode.Append, FileAccess.Write))
                {
                    using (StreamWriter objStreamWriter = new StreamWriter(objFilestream))
                    {
                        objStreamWriter.WriteLine($"{DateTime.Now:u}\r\n{mensaje}");
                        objStreamWriter.Close();
                        objFilestream.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                if (ex != null)
                    EscribeBitacora(ex.InnerException.Message, nombreAplicacion, directorio);
            }
        }
    }
}

