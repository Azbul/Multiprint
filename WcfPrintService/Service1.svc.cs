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
            db.Database.Initialize(true); */
            
            #region TempPrintersAPI
            /*
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
            */
            #endregion

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
            //db.Pqueues.RemoveRange(db.Pqueues); //clear it
            
            db.Pqueues.Add(pqueue);
            db.SaveChanges();

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

        public void Print(string fileOrPath, string printerName, string pages)
        {
            if(String.IsNullOrEmpty(pages))
                SpirePrAPI.PrintAll(fileOrPath, printerName);
            else
                SpirePrAPI.PrintSelectionPages(fileOrPath, printerName, pages);
        }

        

    }
}
