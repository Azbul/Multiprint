using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Spire.Pdf;
using System.Drawing.Printing;
using System.Windows.Forms;
using System.Management;

namespace WcfPrintService
{
    public class SpirePrAPI
    {
        public static void PrintAll(string fileOrPath, string prName)
        {
            PdfDocument doc = new PdfDocument();
            
            doc.LoadFromFile(@"C:\Users\Adam\WCFServerFiles\" + fileOrPath);
            doc.PrinterName = prName;
            doc.PrintDocument.Print();
        }

        public static void PrintSelectionPages(string  fileOrPath, string prName, string pages)
        {
            PdfDocument doc = new PdfDocument();

            PrintDialog dialogPrint = new PrintDialog();
            dialogPrint.AllowPrintToFile = true;
            dialogPrint.AllowSomePages = true;
            dialogPrint.PrinterSettings.MinimumPage = 1;
            dialogPrint.PrinterSettings.MaximumPage = doc.Pages.Count;
            dialogPrint.PrinterSettings.FromPage = Convert.ToInt32(pages[0]);    
            dialogPrint.PrinterSettings.ToPage = doc.Pages.Count;
            
            
            if (dialogPrint.ShowDialog() == DialogResult.OK)

            {
                doc.PrintFromPage = dialogPrint.PrinterSettings.FromPage;

                doc.PrintToPage = dialogPrint.PrinterSettings.ToPage;

                doc.PrinterName = dialogPrint.PrinterSettings.PrinterName;
                
                PrintDocument printDoc = doc.PrintDocument;

        printDoc.Print();
            }
        }
        

        public static List<Printer> GetAllPrinters()
        {
            List<Printer> printers = new List<Printer>();

            System.Management.ObjectQuery oquery = new System.Management.ObjectQuery("SELECT * FROM Win32_Printer");
            System.Management.ManagementObjectSearcher mosearcher = new System.Management.ManagementObjectSearcher(oquery);
            System.Management.ManagementObjectCollection moc = mosearcher.Get();

            if (moc != null && moc.Count > 0)
            {
                //For each printer found, we put it either in the local or network combobox, accordingly.
                foreach (ManagementObject mo in moc)
                {
                    /*bool isLocal = true;
                    string[] ipAddress = mo["PortName"].ToString().Split('.');

                    //network printer
                    if (mo["PortName"] != null && ipAddress.Length == 4)
                        isLocal = false;*/

                    //get availability status
                    printers.Add(new Printer
                    {
                        Prn_name = mo["Name"].ToString(),
                        Pc_name = mo["SystemName"].ToString(),
                        Status = mo.Properties["PrinterStatus"].Value.ToString(),
                        Islocal = Convert.ToBoolean(mo.Properties["Local"].Value)
                    });

                    #region SetDefaultPrinterToUI
                    //If the printer is found to be the default one, we select it.
                    /* if ((bool)mo["Default"])
                     {
                         if (network)
                         {
                             cboNetworkPrinters.SelectedItem = mo["Name"].ToString();
                             defaultNetwork = true;
                         }
                         else
                         {
                             cboLocalPrinters.SelectedItem = mo["Name"].ToString();
                             defaultNetwork = false;
                         }

                         lblNameValue.Text = mo["Name"].ToString();
                         lblPortValue.Text = mo["PortName"].ToString();
                         lblDriverValue.Text = mo["DriverName"].ToString();
                         lblDeviceIDValue.Text = mo["DeviceID"].ToString();
                         lblSharedValue.Text = mo["Shared"].ToString();
                     }             */
                    #endregion
                }

            }

            return printers;
        }
    }
}