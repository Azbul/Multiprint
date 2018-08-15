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
using System.IO;

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
        
        public ReturnValue Upload(FiledMetadata metadata)
        {
            var buffer = new byte[1024];
            var bytesRead = metadata.Stream.Read(buffer, 0, buffer.Length);
            try
            {
                using (var outputStream = //сделать удаление файлов после печати 
                    new FileStream(@"C:\Users\Adam\WCFServerFiles\" + metadata.FileName, FileMode.Create, FileAccess.Write))
                    while(bytesRead > 0)
                    {
                        outputStream.Write(buffer, 0, bytesRead);
                        bytesRead = metadata.Stream.Read(buffer, 0, buffer.Length);
                    }
                return new ReturnValue { UploadSucceed = true };
            }
            catch
            {
                return new ReturnValue { UploadSucceed = false };
            }
        }

        public void InitializePrintersToDb()
        {
           /*Database.SetInitializer(new ContexInitializer());
            db.Database.Initialize(true); */   // для быстрого сброса бд
            
            //clear table
            var countPr = db.Printers.Count();
            if (countPr != 0)
                db.Printers.RemoveRange(db.Printers);

           // allPrinters.ForEach(p => db.Printers.Add(p));
            SpirePrAPI.GetAllPrinters().ForEach(p => db.Printers.Add(p));
            db.SaveChanges();

            //reset id
            db.Database.ExecuteSqlCommand(@"ALTER SEQUENCE dbo.""Printers_Id_seq"" RESTART");
            db.Database.ExecuteSqlCommand(@"UPDATE dbo.""Printers"" SET ""Id"" = DEFAULT");
        }

        public void SetQueueDataToDb(Pqueue pqueue)
        {
            db.Pqueues.Add(pqueue);
            System.Diagnostics.Debug.Write("Id сущности: " + db.Pqueues.OrderByDescending(p => p.Id).FirstOrDefault().Id.ToString());
            db.SaveChanges();

            //сброс
            //db.Database.ExecuteSqlCommand(@"ALTER SEQUENCE dbo.""Pqueues_Id_seq"" RESTART");
            //db.Database.ExecuteSqlCommand(@"UPDATE dbo.""Pqueues"" SET ""Id"" = DEFAULT");
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

        public void Print(string fileOrPath, int printerId, string pages)
        {
            string prName = db.Printers.FirstOrDefault(p => p.Id == printerId).Prn_name;
            //if all pages
            if(String.IsNullOrEmpty(pages))
                SpirePrAPI.PrintAll(fileOrPath, prName);
            else  //if selectRange pages
                SpirePrAPI.PrintSelectionPages(fileOrPath, prName, pages);
        }

        

    }
}
