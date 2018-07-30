using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebPrint
{
    public static class GlobalVariables
    {
        public static bool Loaded { get ; set; }

        public static string NameOfFile { get ; set; }

        public static ServiceReferenc2.Printer[] Printers { get; set; }

        public static ServiceReferenc2.Pqueue[] Pqueues { get; set; }
    }
}