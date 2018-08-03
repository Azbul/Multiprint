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
                X.Msg.Alert("Инфо", "Load completed").Show();
            }
        }

        void FillPqueueUI()
        {
            GlobalVariables.Pqueues = cl.GetPqueuesFromDb();
            int globalVarPqueueCount = GlobalVariables.Pqueues.Count();
            var pqObjs = new List<object>();

            for (int i = 0; i < globalVarPqueueCount; i++)
            {
                pqObjs.Add(new
                {
                    docname = GlobalVariables.Pqueues[i].Filename,

                    filestatus = GlobalVariables.Pqueues[i].FileStatus,

                    prname = GlobalVariables.Pqueues[i].PrinterId,

                    pagetoprint = GlobalVariables.Pqueues[i].PapersPrinting,

                    pcname = GlobalVariables.Pqueues[i].PcName,

                    datetime = GlobalVariables.Pqueues[i].PqueueDateTime
                });
            }

            this.Store2.DataSource = pqObjs;
            this.Store2.DataBind();
        }

        void FillPrinterUI()
        {
            cl.InitializePrintersToDb();
            GlobalVariables.Printers = cl.GetPrintersFromDb();
            var globalVarPrintCount = GlobalVariables.Printers.Count();
            var PrObjs = new List<object>();

            for (int i = 0; i < globalVarPrintCount; i++)
            {
                PrObjs.Add(new
                {
                    pid = GlobalVariables.Printers[i].Id,

                    prname = GlobalVariables.Printers[i].Prn_name,

                    pcname = GlobalVariables.Printers[i].Pc_name,

                    status = GlobalVariables.Printers[i].Status
                });            //get data from db to client (request IsPostBack)
            }

            this.Store1.DataSource = PrObjs;
            this.Store1.DataBind();
        }

        void SetStatusText()
        {
            this.StatusField.Text = (GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(ComboBox1.SelectedItem.Value))).Status.ToString();  //ВСЕ ДОБАВИТЬ В <form>, ИНЧАЧЕ НЕ РАБОТАЕТ
        }

        protected void OnComboBoxSelected(object sender, DirectEventArgs e)
        {
            SetStatusText();
            this.PcNameField.Text = (GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(this.ComboBox1.SelectedItem.Value))).Pc_name;
        }

        protected void Print_Click(object sender, DirectEventArgs e)
        {
            cl.SetQueueDataToDb(new ServiceReferenc2.Pqueue
            {     //поля должны заполнятся данными из интерфейса!
                PageFrom = 1, //docFirstPage

                PageTo = 7,  //lastP

                PrintPages = "7",  //userPages

                PrinterId = Convert.ToInt32(this.ComboBox1.SelectedItem.Value),

                Filename = this.UploadField.PostedFile.FileName,

                FileStatus = 1, //???   ----------------------

                PapersPrinting = 0,  //realtime update ?      |

                PrintedConfirm = 0, // -----------------------

                PcName = this.PcNameField.Text, //сделать поле в окне принт и брать оттуда

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