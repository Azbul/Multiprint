<%@ Page Language="C#" %>

<script runat="server">

    WebPrint.ServiceReferenc2.Service1Client cl;

    protected void Page_Load(object sender, EventArgs e)
    {
        cl = new WebPrint.ServiceReferenc2.Service1Client(); //т.к. клиентов несколько, client.InitializePrintersToDb() вызывать в отдельной логике
        FillPrinterUI();
        
    }


    void FillPrinterUI()
    {
        cl.InitializePrintersToDb();
        var prs = cl.GetPrintersFromDb();
        var objs = new List<object>() ;

        for (int i = 0; i < prs.Count(); i++)
        {
            objs.Add(new  { pid = prs[i].Id, prname = prs[i].Prn_name, pcname = prs[i].Pc_name, status = prs[i].Status });            //get data from db to client (request IsPostBack)
        }

        this.Store1.DataSource = objs;
        this.Store1.DataBind();
    }

    void SetStatusText()
    {
        this.StatusField.Text = ComboBox1.SelectedItem.Value;  //ВСЕ ДОБАВИТЬ В <form>, ИНЧАЧЕ НЕ РАБОТАЕТ
    }

    protected void Btnp_Click(object sender, DirectEventArgs e)
    {
        SetStatusText();
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
    <ext:ResourceManager runat="server" />
    
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
                                ValueField="status"
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
                                    <Select OnEvent="Btnp_Click" />
                                </DirectEvents>
                             </ext:ComboBox>

                            <ext:TextField
                            ID="StatusField"
                            runat="server"
                            Name="company"
                            ReadOnly="true"
                            FieldLabel="Состояние"
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
                <ext:FileUploadField ID="BasicField" runat="server" Width="50" FieldLabel="Выбрать файл" EmptyText="Файл не выбран" Accept="application/pdf" Icon="Attach" />

            </Items>
            <Buttons>
                <ext:Button 
                    ID="Button1"
                    runat="server" 
                    Text="Печать"
                    Icon="Printer" 
                    OnDirectClick="Btnp_Click"
                    />
            </Buttons>
                            
        </ext:Panel>
        </Items>
    </ext:Viewport>
 </form>
</body>
</html>