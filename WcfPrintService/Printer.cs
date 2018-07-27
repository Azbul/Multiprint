using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace WcfPrintService
{
    
    public class Printer
    {
        public int Id { get; set; }

        public string Prn_name { get; set; }

        public int Status { get; set; }

        public string Pc_name { get; set; }
    }
}
