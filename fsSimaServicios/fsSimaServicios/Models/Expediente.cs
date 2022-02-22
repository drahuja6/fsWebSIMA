using System;

namespace fsSimaServicios
{
    class Expediente
    {
        public int IdClasificacion { get; set; }
        public string Codigo { get; set; }
        public string Numero { get; set; }
        public string Titulo { get; set; }
        public string Asunto { get; set; }
        public string Observaciones { get; set; }
        public string Caja { get; set; }
        public string CajaAnterior { get; set; }
        public DateTime Apertura { get; set; }
        public DateTime Cierre { get; set; }
        public bool Cerrado { get; set; }
        public int IdUnidadAdministrativa { get; set; }
        public string UnidadAdministrativa { get; set; }
    }
}
