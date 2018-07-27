using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace WcfPrintService
{
    public class UserContext : DbContext
    {
        public UserContext() 
            : base("UserDB")
        { }
        

        public DbSet<Printer> Printers { get; set; }

        public DbSet<Pqueue> Pqueues { get; set; }
    }
}