using System;
using System.IO;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Security;

namespace fsSimaServicios
{
    public class VariosPdf
    {
        public static bool CambiaTitulo(string nombrePdf)
        {
            FileInfo fi = new FileInfo(nombrePdf);
            PdfDocument document = PdfReader.Open(nombrePdf, PdfDocumentOpenMode.Modify);
            //PdfDocument document = PdfReader.Open(nombrePdf, "fsmSIMA#pdfT001s", PdfDocumentOpenMode.Modify);

            document.SecuritySettings.DocumentSecurityLevel = PdfDocumentSecurityLevel.Encrypted128Bit;
            document.SecuritySettings.OwnerPassword = "fsmSIMA#pdfT001s";
            document.SecuritySettings.PermitModifyDocument = false;
            document.SecuritySettings.PermitExtractContent = false;
            document.SecuritySettings.PermitAnnotations = false;
            document.SecuritySettings.PermitAssembleDocument = false;
            document.SecuritySettings.PermitFormsFill = false;
            document.SecuritySettings.PermitFullQualityPrint = false;
            document.SecuritySettings.PermitPrint = false;

            document.Info.Title = $"FSM - {fi.Name}";
            document.Info.Author = "Full Service de México, S.A. de C.V.";
            document.Info.Creator = "SIMA";
            document.Save(nombrePdf);

            return true;
        }
    }
}
