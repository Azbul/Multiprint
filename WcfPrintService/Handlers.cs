using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.Linq;
using System.Web;

namespace WcfPrintService
{
    public class Handlers
    {
        public Handlers(string name)
        {
            printerName = name;
            db = new UserContext();
        }

        UserContext db;
        string printerName;

        public  void printDocument_BeginPrint(object sender, PrintEventArgs e)
        {
            var printer = db.Printers.FirstOrDefault(p => p.Prn_name == printerName);
            if (printer != null)
            {
                printer.Status = "Идет печать...";
                db.SaveChanges();
            }
        }

        public  void printDocument_EndPrint(object sender, PrintEventArgs e)
        {
            var printer = db.Printers.SingleOrDefault(p => p.Prn_name == printerName);
            if (printer != null)
            {
                printer.Status = "Готов";
                db.SaveChanges();
            }
        }
    }
}