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


        public WebForm1()
        {
            client = new ServiceReferenc2.Service1Client();
            //GlobalVariables.Loaded = false;   
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!GlobalVariables.Loaded)
                FillPrinterUI();
            GlobalVariables.Loaded = true;
            FillPqueueUI();
        }

        private void FillPrinterUI()
        {
            client.InitializePrintersToDb(); // Возможно следует применять Task myTask = new Task(client.InitializePrintersToDb()); myTask.Wait(); 
            //DropDownList1.Items.Clear();
            GlobalVariables.Printers = client.GetPrintersFromDb(); //сделай глобальным, чтобы получить доступ ко всем данным и работать с dropdownlist 
            foreach (var pr in GlobalVariables.Printers)
            {
                DropDownList1.Items.Add(new ListItem(pr.Prn_name, pr.Id.ToString()));
                
            }
        }

        private void FillPqueueUI()
        {
            GridView1.AutoGenerateColumns = true;
            GlobalVariables.Pqueues = client.GetPqueuesFromDb();
            
           var pqlist = from p in GlobalVariables.Pqueues where p.PrintedConfirm == 0 select new /// вывод только нераспечатанных || всех, сортируя распечатанные в нижние строки
           {
               DocName = p.Filename,
               FileStatus = p.FileStatus,
               PrintName = p.PrinterId, PageToPrint = p.PrintPages,
               PC_Name = p.PcName,
               DateAndTime = p.PqueueDateTime
           };
           
            GridView1.DataSource = pqlist.ToList();
            GridView1.DataBind();
        }


        //Label1.Text = RadioButtonList1.Items[0].Text;

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label3.Text = DropDownList1.SelectedValue; //сбрасывается выбранный файл- поправить в extJs
            
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            client.SetQueueDataToDb(new ServiceReferenc2.Pqueue
            {     //поля должны заполнятся данными из интерфейса!
                PageFrom = 1, //docFirstyPage

                PageTo = 13,  //lastP

                PrintPages = "13",  //userPages

                PrinterId = Convert.ToInt32(DropDownList1.SelectedValue),

                Filename = ipFilename.PostedFile.FileName,

                FileStatus = 1, //???   ----------------------
                //                                            |
                PapersPrinting = 5,  //realtime update ?      |
                //                                            |
                PrintedConfirm = 1, // -----------------------

                PcName = GlobalVariables.Printers[Convert.ToInt32(DropDownList1.SelectedValue) - 1].Pc_name,

                PqueueDateTime = DateTime.Now.ToString()
            });
            FillPqueueUI();
            // или сразу для QueueUI берем эти (выше) данные. Возможно при каждой обновлении страницы следует выгружать в QueueUI данные 
        }

        protected void Button1_Click2(object sender, EventArgs e)
        {
            DropDownList1.Items.Clear();
            FillPrinterUI();

            FillPqueueUI();
        }
    }
}