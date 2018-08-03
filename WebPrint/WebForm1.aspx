<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebPrint.WebForm1" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

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
                                                <h3>{prname} </h3>
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
                            Name="sfield"
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

