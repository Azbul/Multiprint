<%@ Page Language="C#" %>
<%@ Import Namespace ="System.IO"  %>
<%@ Import Namespace ="Spire.Pdf"  %>


<script runat="server">


    WebPrint.ServiceReferenc2.Service1Client cl;
    PdfDocument doc;

    protected void Page_Load(object sender, EventArgs e)
    {
        cl = new WebPrint.ServiceReferenc2.Service1Client(); //т.к. клиентов несколько, client.InitializePrintersToDb() вызывать в отдельной логике

        if (!X.IsAjaxRequest)
        {
            FillPrinterUI(); //try add in comboboxselected
            FillPqueueUI();  //только в методе print_click?
            X.Msg.Info("Инфо", "Первая загрузка").Show();
        }

    }

    void FillPqueueUI()
    {
        WebPrint.GlobalVariables.Pqueues = cl.GetPqueuesFromDb(); ///get all
        int globalVarPqueueCount = WebPrint.GlobalVariables.Pqueues.Count();
        var pqObjs = new List<object>();

        for (int i = 0; i<globalVarPqueueCount; i++)
        {
            pqObjs.Add(new {
                docname = WebPrint.GlobalVariables.Pqueues[i].Filename,

                filestatus = WebPrint.GlobalVariables.Pqueues[i].FileStatus,

                prname = WebPrint.GlobalVariables.Printers.First(p => p.Id == WebPrint.GlobalVariables.Pqueues[i].PrinterId).Prn_name   ,

                pagetoprint = WebPrint.GlobalVariables.Pqueues[i].PrintPages,

                pcname = WebPrint.GlobalVariables.Pqueues[i].PcName,

                datetime = WebPrint.GlobalVariables.Pqueues[i].PqueueDateTime});
        }

        this.Store2.DataSource = pqObjs;
        this.Store2.DataBind();
    }

    void FillPrinterUI()
    {
        cl.InitializePrintersToDb();
        WebPrint.GlobalVariables.Printers = cl.GetPrintersFromDb();
        var globalVarPrintCount = WebPrint.GlobalVariables.Printers.Count();

        var PrObjs = new List<object>() ;

        for (int i = 0; i < globalVarPrintCount; i++)
        {                       ////здесь проверка на локал и распределение
            PrObjs.Add(new  {
                pid = WebPrint.GlobalVariables.Printers[i].Id,

                prname = WebPrint.GlobalVariables.Printers[i].Prn_name,

                pcname = WebPrint.GlobalVariables.Printers[i].Pc_name,

                status = WebPrint.GlobalVariables.Printers[i].Status });            //get data from db to client (request IsPostBack)
        }

        this.Store1.DataSource = PrObjs;
        this.Store1.DataBind();
    }

    protected void SetPrintersLocalData()
    {
        this.StatusField.Text = (WebPrint.GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(ComboBox1.SelectedItem.Value))).Status.ToString();  //ВСЕ ДОБАВИТЬ В <form>, ИНЧАЧЕ НЕ РАБОТАЕТ
        this.PcNameField.Text = (WebPrint.GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(ComboBox1.SelectedItem.Value))).Pc_name;
    }

    protected void OnComboBoxSelected(object sender, DirectEventArgs e)
    {
        SetPrintersLocalData();
    }

    #region SendFileWtihServiceURL
    /*
    public static void HttpUploadFile(string url, string file, string paramName, string contentType, NameValueCollection nvc) {
        System.Diagnostics.Debug.Write(string.Format("Uploading {0} to {1}", file, url));
        string boundary = "---------------------------" + DateTime.Now.Ticks.ToString("x");
        byte[] boundarybytes = System.Text.Encoding.ASCII.GetBytes("\r\n--" + boundary + "\r\n");

        System.Net.HttpWebRequest wr = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
        wr.ContentType = "multipart/form-data; boundary=" + boundary;
        wr.Method = "POST";
        wr.KeepAlive = true;
        wr.Credentials = System.Net.CredentialCache.DefaultCredentials;

        System.IO.Stream rs = wr.GetRequestStream();

        string formdataTemplate = "Content-Disposition: form-data; name=\"{0}\"\r\n\r\n{1}";
        foreach (string key in nvc.Keys)
        {
            rs.Write(boundarybytes, 0, boundarybytes.Length);
            string formitem = string.Format(formdataTemplate, key, nvc[key]);
            byte[] formitembytes = System.Text.Encoding.UTF8.GetBytes(formitem);
            rs.Write(formitembytes, 0, formitembytes.Length);
        }
        rs.Write(boundarybytes, 0, boundarybytes.Length);

        string headerTemplate = "Content-Disposition: form-data; name=\"{0}\"; filename=\"{1}\"\r\nContent-Type: {2}\r\n\r\n";
        string header = string.Format(headerTemplate, paramName, file, contentType);
        byte[] headerbytes = System.Text.Encoding.UTF8.GetBytes(header);
        rs.Write(headerbytes, 0, headerbytes.Length);

        System.IO.FileStream fileStream = new System.IO.FileStream(file, System.IO.FileMode.Open, System.IO.FileAccess.Read);
        byte[] buffer = new byte[4096];
        int bytesRead = 0;
        while ((bytesRead = fileStream.Read(buffer, 0, buffer.Length)) != 0) {
            rs.Write(buffer, 0, bytesRead);
        }
        fileStream.Close();

        byte[] trailer = System.Text.Encoding.ASCII.GetBytes("\r\n--" + boundary + "--\r\n");
        rs.Write(trailer, 0, trailer.Length);
        rs.Close();

        System.Net.WebResponse wresp = null;
        try {
            wresp = wr.GetResponse();
            System.IO.Stream stream2 = wresp.GetResponseStream();
            System.IO.StreamReader reader2 = new System.IO.StreamReader(stream2);
            System.Diagnostics.Debug.Write(string.Format("File uploaded, server response is: {0}", reader2.ReadToEnd()));
        } catch(Exception ex) {
            System.Diagnostics.Debug.Write(ex.Message);
            if(wresp != null) {
                wresp.Close();
                wresp = null;
            }
        } finally {
            wr = null;
        }
    }
    ЗАПУСК 

         NameValueCollection nvc = new NameValueCollection();
        nvc.Add("id", "TTR");
        nvc.Add("btn-submit-photo", "Upload");
        HttpUploadFile("http://localhost:53432/upload", @"C:\Users\Adam\Desktop\example.pdf", "file", "application/pdf", nvc);
         */
    #endregion
    string path;
    void UploadFile()
    {    //to client directory
        HttpPostedFile file = this.UploadField.PostedFile;
        string fileName = file.FileName;
        path = Server.MapPath(null) + "\\upload\\" + fileName;
        file.SaveAs(path);

        //to server directory
        var result = false;
        using (var inputStream = File.OpenRead(path))
        {
            result = cl.Upload(fileName, inputStream);
            // this.logField.Text = result ? "Файл передан" : "Ошибки";
        }
    }

    protected void SetQueueDataToDb()
    {
        //doc.LoadFromFile(path);

        cl.SetQueueDataToDb(new WebPrint.ServiceReferenc2.Pqueue
        {     //поля должны заполнятся данными из интерфейса!
            PageFrom = 1, //docFirstPage

            PageTo = doc.Pages.Count,  //lastP

            PrintPages = this.All.Checked ? doc.Pages.Count.ToString() : this.pagesField.Text,  //userPages or all

            PrinterId = Convert.ToInt32(this.ComboBox1.SelectedItem.Value),

            Filename = this.UploadField.PostedFile.FileName,

            FileStatus = 1, //???   ----------------------

            PapersPrinting = 0,  //realtime update ?      | все это сделать через update таблицы в сервисе

            PrintedConfirm = 0, // -----------------------

            PcName = this.PcNameField.Text,

            PqueueDateTime = DateTime.Now.ToString()
        });
    }

    bool AllCorrect()
    { //сначала проверка файла, принтера
        doc = new PdfDocument();
        UploadFile();         //--------------------------------------------------------------
        doc.LoadFromFile(path);
        int filePagesCount = doc.Pages.Count;
        string pages = this.pagesField.Text;

        if (this.Any.Checked)
        {
            try
            {
                if (pages.Contains("-"))
                {
                    string[] strmass = pages.Split('-');

                    int from = Convert.ToInt32(strmass[0]);
                    int to = Convert.ToInt32(strmass[1]);
                    if (from > filePagesCount || to > filePagesCount)
                        return false;
                }
                else if (Convert.ToInt32(pages) > filePagesCount)
                    return false;

            }
            catch
            {
                return false;
            }
        }
        return true;
    }

    protected void Print_Click(object sender, DirectEventArgs e)
    {
        if (AllCorrect())
        {
            SetQueueDataToDb();   //------------------------------------------------------
            FillPqueueUI();  //возможно не работал из-за того, что вызывался в page load без ajax
            this.logField.Text = "correct";

             if (this.All.Checked)
                 cl.Print(UploadField.PostedFile.FileName, ComboBox1.SelectedItem.Text, null);

             if (this.Any.Checked)
                 cl.Print(UploadField.PostedFile.FileName, ComboBox1.SelectedItem.Text, pagesField.Text); // сделать одностраничную печать

        }
        else
            this.logField.Text = "incorrect field";

        File.Delete(path); //-----------------------------------------------------------
    }

    protected void Refresh_Click(object sender, DirectEventArgs e)
    {
        FillPrinterUI();
    }

    #region Useful
    /*
                           <SelectedItems>
                               <ext:ListItem Value="2" (or Index="n") Mode="Raw" />
                           </SelectedItems>

                           <Listeners>
                               <Select Handler="#{StatusField}.setValue(#{ComboBox1}.store.getAt(1).get('price')));" />
                           </Listeners>
    */
    #endregion

</script>


<!DOCTYPE html>

<html>
<head runat="server">
    <title>Contact Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .list-item {
            font:normal 11px tahoma, arial, helvetica, sans-serif;
            padding:3px 10px 3px 10px;
            border:1px solid #fff;
            border-bottom:1px solid #eeeeee;
            white-space:normal;
            color:#555;
        }

        .list-item h3 {
            display:block;
            font:inherit;
            font-weight:bold;
            margin:0px;
            color:#222;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server"> 
    <ext:ResourceManager runat="server" Theme="Triton"/>
    
            
    <ext:Store ID="Store1" runat="server">
        <Model>
            <ext:Model ID="model1" runat="server" IDProperty="pid">
                <Fields>
                    <ext:ModelField Name="pid" Type="Int"/>
                    <ext:ModelField Name="prname" Type="String"/>
                    <ext:ModelField Name="pcname" Type="String"/>
                    <ext:ModelField Name="status" Type="String"/>
                </Fields>
            </ext:Model>
        </Model>
    </ext:Store>
             
    <ext:Viewport runat="server">
        <Items>
           <ext:Panel 
            ID="Window1"
            runat="server" 
            Title="Печать"
            Height="400"
            Width="600"
            Frame="true"
            Align="Start"
            Draggable="true"
            Cls="box"
            BodyPadding="5"
            DefaultButton="0"
            Layout="AnchorLayout"
            Icon="Printer"
            DefaultAnchor="100%">
            <Items>
                 <ext:Container runat="server" Layout="HBoxLayout" MarginSpec="0 0 10">
                    <Items>
                        <ext:FieldSet
                            runat="server"
                            Flex="1"
                            Title="Выбрать принтер"
                            Layout="AnchorLayout"
                            Height="200"
                            DefaultAnchor="100%">

                            <Items>
                                <ext:ComboBox
                                ID="ComboBox1"
                                runat="server"
                                Width="500"
                                Editable="false"
                                DisplayField="prname"
                                ValueField="pid"
                                QueryMode="Local"
                                ForceSelection="true"
                                TriggerAction="All"
                                Icon="PrinterEmpty"
                                StoreID="Store1"
                                EmptyText="Выберите принтер...">

                                <ListConfig>
                                    <ItemTpl runat="server">
                                        <Html>
                                            <div class="list-item">
                                                <h3>{prname}</h3>
                                                Состояние: {status:ellipsis(50)}
                                            </div>
                                        </Html>
                                    </ItemTpl>
                                </ListConfig>
                                <DirectEvents>
                                    <Select OnEvent="OnComboBoxSelected" />
                                </DirectEvents>
                             </ext:ComboBox>

                            <ext:TextField
                            ID="StatusField"
                            runat="server"
                            Name="st"
                            ReadOnly="true"
                            FieldLabel="Состояние"
                            Width="260"
                            EmptyText="Неизвестно"
                            />

                            <ext:TextField
                            ID="PcNameField"
                            runat="server"
                            Name="pcname"
                            ReadOnly="true"
                            FieldLabel="Компьютер"
                            Width="260"
                            EmptyText="Неизвестно"
                            />
                            </Items>
                        </ext:FieldSet>

                        <ext:Component runat="server" Width="10" />

                        <ext:FieldSet
                            runat="server"
                            Flex="1"
                            Title="Диапазон страниц"
                            Height="200"
                            Layout="AnchorLayout"
                            DefaultAnchor="100%">

                            <Items>
                                <ext:Radio runat="server" ID="All" BoxLabel="Все" Name="pages" Checked="true">
                                <Listeners>
                                     <Change Handler="#{pagesField}.enable();" />
                                    </Listeners>
                                </ext:Radio>
                                <ext:Radio runat="server" ID="Any" BoxLabel="Страницы:" Name="pages">
                                    <Listeners>
                                     <Change Handler="#{pagesField}.disable();" />
                                    </Listeners>
                                </ext:Radio>
                                <ext:TextField 
                                    ID="pagesField"
                                    runat="server" 
                                    Disabled="true" 
                                    MaskRe="/[0-9,-]/"
                                    EmptyText="1-5"/>
                            </Items>
                        </ext:FieldSet>
                    </Items>
                </ext:Container>
                <ext:TextField
                            ID="logField"
                            runat="server"
                            Name="log"
                            ReadOnly="true"
                            FieldLabel="Log"
                            Width="260"
                            EmptyText="log field" />  
                <ext:FileUploadField ID="UploadField" runat="server" FieldLabel="Выбрать файл" EmptyText="Файл не выбран" Accept="application/pdf" Icon="Attach"  />
            </Items>
            <Buttons>
                <ext:Button 
                    ID="Button2"
                    runat="server" 
                    Text="Обновить"
                    Icon="ArrowRefresh" 
                    OnDirectClick="Refresh_Click"/>
                <ext:Button 
                    ID="Button1"
                    runat="server" 
                    Text="Печать"
                    Icon="Printer" 
                    OnDirectClick="Print_Click"/>
            </Buttons>
                            
        </ext:Panel>
        </Items>
    </ext:Viewport>
       
    <ext:Window
    runat="server"
    Title="Документы на очередь"
    Width="800"
    Height="400"
    MinWidth="300"
    MinHeight="200"
    X="610"
    Y="0"
    Closable="false"
    Layout="FitLayout"
    >
        <Items>
        <ext:GridPanel
        ID="GridPanel1"
        runat="server"
        ForceFit="true"
        Width="800" 
        Height="400">
        <Store>
            <ext:Store ID="Store2" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="docname" Type="Auto"/>
                            <ext:ModelField Name="filestatus" Type="Float" />
                            <ext:ModelField Name="prname" Type="String" />
                            <ext:ModelField Name="pagetoprint" Type="String" />
                            <ext:ModelField Name="pcname" Type="Auto" />
                            <ext:ModelField Name="datetime" Type="String"/>
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel runat="server">
            <Columns>
                <ext:Column
                    ID="DocColumn"
                    runat="server"
                    Text="Документ"
                    Width="110"
                    DataIndex="docname"
                   
                    />

                <ext:Column
                    ID="StatusColumn"
                    runat="server"
                    Text="Статус файла"
                    Width="110"
                    DataIndex="filestatus"
                        />

                <ext:Column                                                          
                    ID="PrnameColumn"                                                
                    runat="server"                                                   
                    Text="Принтер"                                                   
                    Width="75"                                                       
                    DataIndex="prname"                                               
                    />

                <ext:Column
                    ID="PageToPrintColumn"
                    runat="server"
                    Text="Страницы на печать"
                    Width="70"
                    DataIndex="pagetoprint"
                    
                    />

                <ext:Column
                    ID="PcnameColumn"
                    runat="server"
                    Text="Компьютер"
                    Width="80"
                    DataIndex="pcname"
                    />

                <ext:Column
                    ID="DateTimeColumn"
                    runat="server"
                    Text="Поставлено в очередь"
                    Width="130"
                    DataIndex="datetime"
                    />
            </Columns>

        </ColumnModel>
        <View>
            <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
        </View>
        </ext:GridPanel>
    </Items>
 </ext:Window>
        
 </form>
</body>
</html>