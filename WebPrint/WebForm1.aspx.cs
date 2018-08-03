using System;
using System.Collections.Generic;
using System.Linq;
using Ext.Net;  //------ добавь это для ext


namespace WebPrint
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        ServiceReferenc2.Service1Client cl;
        

        public WebForm1()
        {
            cl = new ServiceReferenc2.Service1Client();
            //GlobalVariables.Loaded = false;   
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                FillPrinterUI(); //try add in comboboxselected
                FillPqueueUI();  //только в методе print_click?
                X.Msg.Alert("Title", "message").Show();
            }
        }

        void FillPqueueUI()
        {
            WebPrint.GlobalVariables.Pqueues = cl.GetPqueuesFromDb();
            int globalVarPqueueCount = WebPrint.GlobalVariables.Pqueues.Count();
            var pqObjs = new List<object>();

            for (int i = 0; i < globalVarPqueueCount; i++)
            {
                pqObjs.Add(new
                {
                    docname = WebPrint.GlobalVariables.Pqueues[i].Filename,

                    filestatus = WebPrint.GlobalVariables.Pqueues[i].FileStatus,

                    prname = WebPrint.GlobalVariables.Pqueues[i].PrinterId,

                    pagetoprint = WebPrint.GlobalVariables.Pqueues[i].PapersPrinting,

                    pcname = WebPrint.GlobalVariables.Pqueues[i].PcName,

                    datetime = WebPrint.GlobalVariables.Pqueues[i].PqueueDateTime
                });
            }

            this.Store2.DataSource = pqObjs;
            this.Store2.DataBind();
        }

        void FillPrinterUI()
        {
            cl.InitializePrintersToDb();
            WebPrint.GlobalVariables.Printers = cl.GetPrintersFromDb();
            var globalVarPrintCount = WebPrint.GlobalVariables.Printers.Count();
            var PrObjs = new List<object>();

            for (int i = 0; i < globalVarPrintCount; i++)
            {
                PrObjs.Add(new
                {
                    pid = WebPrint.GlobalVariables.Printers[i].Id,

                    prname = WebPrint.GlobalVariables.Printers[i].Prn_name,

                    pcname = WebPrint.GlobalVariables.Printers[i].Pc_name,

                    status = WebPrint.GlobalVariables.Printers[i].Status
                });            //get data from db to client (request IsPostBack)
            }

            this.Store1.DataSource = PrObjs;
            this.Store1.DataBind();
        }

        void SetStatusText()
        {
            this.StatusField.Text = ComboBox1.SelectedItem.Value;  //ВСЕ ДОБАВИТЬ В <form>, ИНЧАЧЕ НЕ РАБОТАЕТ
        }

        protected void OnComboBoxSelected(object sender, DirectEventArgs e)
        {
            SetStatusText();
        }

        protected void Print_Click(object sender, DirectEventArgs e)
        {
            cl.SetQueueDataToDb(new WebPrint.ServiceReferenc2.Pqueue
            {     //поля должны заполнятся данными из интерфейса!
                PageFrom = 1, //docFirstPage

                PageTo = 7,  //lastP

                PrintPages = "7",  //userPages

                PrinterId = (WebPrint.GlobalVariables.Printers.First(p => p.Prn_name == this.ComboBox1.SelectedItem.Text)).Id,

                Filename = this.UploadField.PostedFile.FileName,

                FileStatus = 1, //???   ----------------------

                PapersPrinting = 0,  //realtime update ?      |

                PrintedConfirm = 0, // -----------------------

                PcName = (WebPrint.GlobalVariables.Printers.First(p => p.Prn_name == this.ComboBox1.SelectedItem.Text)).Pc_name, //сделать поле в окне принт и брать оттуда

                PqueueDateTime = DateTime.Now.ToString()
            });

            //System.Threading.Thread.Sleep(10);

            FillPqueueUI();  //возможно не работал из-за того, что вызывался в page load без ajax
        }
        

        
        //REFRESH DATA
       /* protected void Button1_Click2(object sender, DirectEventArgs e) //update 
        {
            DropDownList1.Items.Clear();
            FillPrinterUI();

            FillPqueueUI();
        }*/


        //EXT.NET
        
    }
}