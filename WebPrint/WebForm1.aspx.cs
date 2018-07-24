using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPrint
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        ServiceReference.Service1Client client;

        protected void Page_Load(object sender, EventArgs e)
        {
            client = new ServiceReference.Service1Client();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = client.ConnectionTest();
           
           
        }
    }
}