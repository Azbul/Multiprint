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
    public class Service1 : IService1
    {
        public Service1()
        {
            db = new UserContext();
        }

        UserContext db;
        // context.Configuration.AutoDetectChangesEnabled = false;
        // context.ChangeTracker.DetectChanges();
        

        public void InitializePrintersToDb()
        {
           /* Database.SetInitializer(new ContexInitializer());
            db.Database.Initialize(true); */
            
            #region PrintersAPI
            List<Printer> allPrinters = new List<Printer>()
            {
                //TEST PRINTERS
                new Printer
                {
                    Prn_name = "Prn1",
                    Pc_name = "PC1",
                    Status = 0
                },

                new Printer
                {
                    Prn_name = "Prn2",
                    Pc_name = "PC1",
                    Status = 0
                },

                new Printer
                {
                    Prn_name = "Prn3",
                    Pc_name = "PC1",
                    Status = 1
                }
            };
            #endregion
            
            var countPr = db.Printers.Count();
            if (countPr != 0)
                db.Printers.RemoveRange(db.Printers);

            allPrinters.ForEach(p => db.Printers.Add(p));
            db.SaveChanges();
            db.Database.ExecuteSqlCommand(@"ALTER SEQUENCE dbo.""Printers_Id_seq"" RESTART");
            db.Database.ExecuteSqlCommand(@"UPDATE dbo.""Printers"" SET ""Id"" = DEFAULT");
        }

        public void SetQueueDataToDb(Pqueue pqueue)
        {
            // db.Pqueues.RemoveRange(db.Pqueues); //clear it

            db.Pqueues.Add(pqueue);
            db.SaveChanges();

            /*db.Database.ExecuteSqlCommand(@"ALTER SEQUENCE dbo.""Pqueues_Id_seq"" RESTART");
            db.Database.ExecuteSqlCommand(@"UPDATE dbo.""Pqueues"" SET ""Id"" = DEFAULT");*/
        }


        public List<Printer> GetPrintersFromDb()
        {
            List<Printer> prs = db.Printers.ToList();
            return prs;
        }

        public List<Pqueue> GetPqueuesFromDb()
        {
            List<Pqueue> pqs = db.Pqueues.ToList();
            return pqs;
        }

        

    }
}
