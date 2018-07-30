using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WcfPrintService
{
    public class Pqueue
    {
        public int Id { get; set; }

        public int PageFrom { get; set; }

        public int PageTo { get; set; }

        public string PrintPages { get; set; } //пользовательские границы печати

        public int PrinterId { get; set; }  

        public string Filename { get; set; }

        public int? FileStatus { get; set; }

        public int? PapersPrinting { get; set; }

        public int? PrintedConfirm { get; set; }

        public string PcName { get; set; }

        public string PqueueDateTime { get; set; }
    }
}