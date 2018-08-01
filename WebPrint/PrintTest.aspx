<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        WebPrint.ServiceReferenc2.Service1Client cl = new WebPrint.ServiceReferenc2.Service1Client();
        var objs = new List<object>() ;
        for (int i = 0; i < 2; i++)
        {
            objs.Add(new object[] { "Id",cl.GetPrintersFromDb()[0].Status, "Status", "printing..." });            //get data from db to client (request IsPostBack)
            
                /* 
                 * {new object[] { "Id", "Printer1", "Status", "ready"},
                 new object[] { "Id", "Printer2", "Status", "no connection"},
                new object[] { WebPrint.GlobalVariables.Printers[i].Id, WebPrint.GlobalVariables.Printers[i].Prn_name, "Status", "printing..."}
                };*/
        }
        this.Store1.DataSource = objs;
     //   this.Store1.DataBind();
    }
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

    <ext:ResourceManager runat="server" />
    

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
                                runat="server"
                                Width="500"
                                Editable="false"
                                DisplayField="state"
                                ValueField="abbr"
                                QueryMode="Local"
                                ForceSelection="true"
                                TriggerAction="All"
                                Icon="PrinterEmpty"
                                EmptyText="Выберите принтер...">

                                <Store>
                                    <ext:Store ID="Store1" runat="server">
                                        <Model>
                                            <ext:Model runat="server">
                                                <Fields>
                                                    <ext:ModelField Name="abbr" />
                                                    <ext:ModelField Name="state" />
                                                    <ext:ModelField Name="nick" />
                                                    <ext:ModelField Name="price" />
                                                </Fields>
                                            </ext:Model>
                                        </Model>
                                    </ext:Store>
                                </Store>
                                <ListConfig>
                                    <ItemTpl runat="server">
                                        <Html>
                                            <div class="list-item">
                                                    <h3>{state}</h3>
                                                    {nick:ellipsis(30)}: {price:ellipsis(50)}
                                            </div>
                                        </Html>
                                    </ItemTpl>
                                </ListConfig>
                            </ext:ComboBox>
                                 
                                <ext:TextField
                            ID="CompanyField"
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
                  
                    />
            </Buttons>
                            
        </ext:Panel>
        </Items>
    </ext:Viewport>
</body>
</html>