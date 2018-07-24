using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfPrintService
{
    // ПРИМЕЧАНИЕ. Команду "Переименовать" в меню "Рефакторинг" можно использовать для одновременного изменения имени класса "Service1" в коде, SVC-файле и файле конфигурации.
    // ПРИМЕЧАНИЕ. Чтобы запустить клиент проверки WCF для тестирования службы, выберите элементы Service1.svc или Service1.svc.cs в обозревателе решений и начните отладку.
    public class Service1 : IService1
    {
        

        public string GetStatus(string value)
        {
            return string.Format("Check status: {0}", value);
        }

        public string ConnectionTest()
        {
            string outp = "";
            using (UserContext db = new UserContext())
            {
                Printer printer1 = new Printer { Prn_name = "Sansung", Pc_name = "PC-01", Status = 1 };
                db.Printers.Add(printer1);
                db.SaveChanges();
                var printers = db.Printers;
                foreach (Printer p in printers)
                {
                    outp += p.Prn_name;
                }
            }
                return outp;
        }
    }
}
