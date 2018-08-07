using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace WcfPrintService
{
    public class ContexInitializer : DropCreateDatabaseAlways<UserContext>
    {
        protected override void Seed(UserContext context)
        {
            List<Printer> allPrinters = new List<Printer>()
            {
                //TEST PRINTERS
                new Printer
                {
                    Prn_name = "Prn1",
                    Pc_name = "PC",
                    Islocal = true,
                    Status = "ok"
                },

                new Printer
                {
                    Prn_name = "Prn2",
                    Pc_name = "PC",
                    Islocal = true,
                    Status = "ok"
                },

                new Printer
                {
                    Prn_name = "Prn3",
                    Pc_name = "PC",
                    Islocal = false,
                    Status = "no connection"
                },
            };


            /* db.Printers.Add(allPrinters[1]);
            var countPr = context.Printers.Count();
            if (countPr != 0)
                context.Printers.RemoveRange(context.Printers);
                context.Database.ExecuteSqlCommand("DBCC CHECKIDENT('TableName', RESEED, 0)") /- "сброс" иднтификатора на 0*/

            allPrinters.ForEach(p => context.Printers.Add(p));
            context.SaveChanges();
        }
    }
}