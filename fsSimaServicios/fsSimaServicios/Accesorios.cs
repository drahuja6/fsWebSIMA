using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

namespace fsSimaServicios
{
    public class Accesorios
    {
        public static void CargaListBox(ListBox listBox, string cadenaConexion, string storedProcedure, int idParametro, string dataText, string dataValue)
        {
            try
            {
                var parametros = new SqlParameter[1];
                parametros[0] = new SqlParameter("@IdParameter", idParametro);

                //Ejecuto el sp y obtengo el DataSet
                var ds = new ClienteSQL(cadenaConexion).ObtenerRegistros(parametros, storedProcedure);

                //Lleno los campos que ligan el DataReader con el ListBox
                listBox.DataSource = ds.Tables[0];
                listBox.DataTextField = dataText;
                listBox.DataValueField = dataValue;

                listBox.DataBind();
            }
            catch (Exception)
            {
                ;
            }
        }

        //Descarga PDF generado por el reporteador Crystal Reports.
        public static void DescargaReporte(Page pagina, string archivoTemp, string archivoPdf)
        {
            pagina.Response.ContentType = "application/pdf";
            pagina.Response.AddHeader("content-Disposition", $"inline; filename={archivoPdf}");
            pagina.Response.WriteFile(archivoTemp);
            pagina.Response.Flush();

            if (File.Exists(archivoTemp))
                File.Delete(archivoTemp);

            pagina.Response.End();

        }
    }
}
