using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Drawing;
using System.Drawing.Printing;
using System.Data.Entity;

namespace WcfPrintService
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени класса "Service1" в коде, SVC-файле и файле конфигурации.
    // ПРИМЕЧАНИЕ. Чтобы запустить клиент проверки WCF для тестирования службы, выберите элементы Service1.svc или Service1.svc.cs в обозревателе решений и начните отладку.
    public class Service1 : IService1
    {
        
        

        List<Printer> allPrinters = new List<Printer>()
        {
            //TEST PRINTERS
            new Printer
            {
                Prn_name = "Pr1",
                Pc_name = "PC",
                Status = 1
            },

            new Printer
            {
                Prn_name = "Pr2",
                Pc_name = "PC",
                Status = 2
            },

            new Printer
            {
                Prn_name = "Pr1",
                Pc_name = "PC",
                Status = 3
            }
        };

        // context.Configuration.AutoDetectChangesEnabled = false;
        // context.ChangeTracker.DetectChanges();
        public int PrintersDataToDb()
        {
            UserContext db = new UserContext();
           // db.Printers.Add(allPrinters[1]);
            var countPr = db.Printers.Count();
            if (countPr != 0)
                db.Database.ExecuteSqlCommand("TRUNCATE TABLE Printers"); //не может определить

            allPrinters.ForEach(p => db.Printers.Add(p));
            db.SaveChanges();
            return 1;
        }

    }
}
