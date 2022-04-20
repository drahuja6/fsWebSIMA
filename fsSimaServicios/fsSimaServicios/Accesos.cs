using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace fsSimaServicios
{
    public static class Accesos
    {
        public static int AutorizaAcceso(Page pagina, int nivel)
        {
            if (pagina.User.Identity.IsAuthenticated)
            {

            }
            return 0;
        }
    }
}
