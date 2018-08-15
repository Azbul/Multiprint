using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing.Printing;
using System.Printing;

namespace WebPrint
{
    public class TestPriAPI
    {
        public string GetStatus()
        {
            var server = new LocalPrintServer();

            PrintQueue queue = server.DefaultPrintQueue;

            //various properties of printQueue
            var mas = new[] {
             queue.IsOffline,
             queue.IsShared,
             queue.IsPrinting,
             queue.HasPaperProblem,
             queue.IsBusy, 
             queue.IsNotAvailable
            };

            string result = "";

            foreach (var res in mas)
                result += res.ToString() + " ";
            return result;
        }
    }
}