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

        ServiceReferenc2.Service1Client client;

        protected void Page_Load(object sender, EventArgs e)
        {
            client = new ServiceReferenc2.Service1Client();
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Label1.Text = RadioButtonList1.Items[0].Text;
            Label1.Text = Convert.ToString(client.PrintersDataToDb());
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}