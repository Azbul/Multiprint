using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Spire.Pdf;
using System.Drawing.Printing;
using System.Windows.Forms;


namespace WebPrint
{
    public class SpirePrAPI
    {
        public static void Print()
        {
            PdfDocument doc = new PdfDocument();

            doc.LoadFromFile(@"C:\Users\Adam\Documents\toDo.pdf");  //с полным путем работает
            
            //Use the default printer to print all the pages

            doc.PrintDocument.Print();

           /* PrintDialog dialogPrint = new PrintDialog();

            dialogPrint.AllowPrintToFile = true;

            dialogPrint.AllowSomePages = true;

            dialogPrint.PrinterSettings.MinimumPage = 1;

            dialogPrint.PrinterSettings.MaximumPage = doc.Pages.Count;

            dialogPrint.PrinterSettings.FromPage = 1;

            dialogPrint.PrinterSettings.ToPage = doc.Pages.Count;




            if (dialogPrint.ShowDialog() == DialogResult.OK)

            {

                doc.PrintFromPage = dialogPrint.PrinterSettings.FromPage;

                doc.PrintToPage = dialogPrint.PrinterSettings.ToPage;

                doc.PrinterName = dialogPrint.PrinterSettings.PrinterName;
                
                PrintDocument printDoc = doc.PrintDocument;
                
                printDoc.Print();
            }*/
        }
    }
}