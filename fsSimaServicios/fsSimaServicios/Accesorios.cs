using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.OleDb;

using System.IO;

namespace fsSimaServicios
{
    public class Accesorios
    {
        public static void CargaListBox(ListBox listBox, string cadenaConexion, string storedProcedure, int idParametro, string dataText, string dataValue)
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

        public static void CargaDropDownList(DropDownList dropDownList, string cadenaConexion, string storedProcedure, int idParametro, string dataText, string dataValue)
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
            catch (Exception)
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

                response.End();
            }
            else
                throw new HttpException(404, "Archivo no localizado");
        }
    }
}

