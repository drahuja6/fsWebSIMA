using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Reflection;

using System.IO;

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

    }
}

