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
            client.InitializeComponentsToDb();
            Label1.Text = client.Test();
            FillUI();
        }

        private void FillUI()
        {
            var printerts = client.GetPrintersFromDb();
            foreach (var pr in printerts)
            {
                DropDownList1.Items.Add(new ListItem(pr.Prn_name, pr.Id.ToString()));
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Label1.Text = RadioButtonList1.Items[0].Text;
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}