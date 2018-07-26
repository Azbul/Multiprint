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
        public Service1()
        {
            db = new UserContext();
        }
        // context.Configuration.AutoDetectChangesEnabled = false;
        // context.ChangeTracker.DetectChanges();
        UserContext db;
        public void InitializeComponentsToDb()
        {
            Database.SetInitializer(new ContexInitializer());
            db.Database.Initialize(true);
        }

        public List<Printer> GetPrintersFromDb()
        {
            List<Printer> prs = db.Printers.ToList();
            return prs;
        }

    }
}
