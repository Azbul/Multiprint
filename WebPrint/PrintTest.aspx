<%@ Page Language="C#" %>

<script runat="server">


    WebPrint.ServiceReferenc2.Service1Client cl;

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
        WebPrint.GlobalVariables.Pqueues = cl.GetPqueuesFromDb();
        int globalVarPqueueCount = WebPrint.GlobalVariables.Pqueues.Count();
        var pqObjs = new List<object>();

        for (int i = 0; i<globalVarPqueueCount; i++)
        {
            pqObjs.Add(new {
                docname = WebPrint.GlobalVariables.Pqueues[i].Filename,

                filestatus = WebPrint.GlobalVariables.Pqueues[i].FileStatus,

                prname = WebPrint.GlobalVariables.Pqueues[i].PrinterId,

                pagetoprint = WebPrint.GlobalVariables.Pqueues[i].PapersPrinting,

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
        {
            PrObjs.Add(new  {
                pid = WebPrint.GlobalVariables.Printers[i].Id,

                prname = WebPrint.GlobalVariables.Printers[i].Prn_name,

                pcname = WebPrint.GlobalVariables.Printers[i].Pc_name,

                status = WebPrint.GlobalVariables.Printers[i].Status });            //get data from db to client (request IsPostBack)
        }

        this.Store1.DataSource = PrObjs;
        this.Store1.DataBind();
    }

    void SetStatusText()
    {
            this.StatusField.Text = (WebPrint.GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(ComboBox1.SelectedItem.Value))).Status.ToString();  //ВСЕ ДОБАВИТЬ В <form>, ИНЧАЧЕ НЕ РАБОТАЕТ
    }

    protected void OnComboBoxSelected(object sender, DirectEventArgs e)
    {
        SetStatusText();
        this.PcNameField.Text = (WebPrint.GlobalVariables.Printers.First(p => p.Id == Convert.ToInt32(this.ComboBox1.SelectedItem.Value))).Pc_name;

    }

    protected void Print_Click(object sender, DirectEventArgs e)
    {
        cl.SetQueueDataToDb(new WebPrint.ServiceReferenc2.Pqueue
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



    /*
                           <SelectedItems>
                               <ext:ListItem Value="2" (or Index="n") Mode="Raw" />
                           </SelectedItems>

                           <Listeners>
                               <Select Handler="#{StatusField}.setValue(#{ComboBox1}.store.getAt(1).get('price')));" />
                           </Listeners>
    */
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
            Height="500"
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
                                <ext:Radio runat="server" BoxLabel="Все" InputValue="All" Name="fav-color" Checked="true" />
                                <ext:Radio runat="server" BoxLabel="Страницы:" InputValue="Any" Name="fav-color" />
                                <ext:TextField ID="TextField2" runat="server" MaskRe="/[0-9,-]/"/>
                            </Items>
                        </ext:FieldSet>
                    </Items>
                </ext:Container>
                <ext:FileUploadField ID="UploadField" runat="server" Width="50" FieldLabel="Выбрать файл" EmptyText="Файл не выбран" Accept="application/pdf" Icon="Attach" />

            </Items>
            <Buttons>
                <ext:Button 
                    ID="Button1"
                    runat="server" 
                    Text="Печать"
                    Icon="Printer" 
                    OnDirectClick="Print_Click"
                    />
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
                            <ext:ModelField Name="prname" Type="Int" />
                            <ext:ModelField Name="pagetoprint" Type="Int" />
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