<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Combobox Example</title>
    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            var data = new[] {                
                new { State = "Alabama", StateProvinceID = 1 },
                new { State = "California", StateProvinceID = 2 },
                new { State = "Ohio", StateProvinceID = 3 },
            };


            storeStates.DataSource = data;
            storeStates.DataBind();
        }


        protected void cbState_OnSelect(object sender, DirectEventArgs e)
        {
            X.Msg.Alert("Message From Code-Behind", cbState.SelectedItem.Text + " selected!").Show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">        
        <ext:ResourceManager ID="ResourceManager1" runat="server" />


        <ext:Store ID="storeStates" runat="server">
            <Model>                
                <ext:Model ID="model1" runat="server" IDProperty="StateProvinceID">
                    <Fields>
                        <ext:ModelField Name="State" Type="String" />
                        <ext:ModelField Name="StateProvinceID" Type="Int" />                        
                    </Fields>
                </ext:Model>
            </Model>
        </ext:Store>


        <ext:FormPanel runat="server" ID="FormPanel1" Width="300" Height="60" PageX="50" PageY="50" BodyPadding="15">
            <Items>
                <ext:ComboBox runat="server" ID="cbState" FieldLabel="State" DisplayField="State" 
                              ValueField="StateProvinceID" StoreID="storeStates" Anchor="100%" QueryMode="Local">
                    <DirectEvents>
                        <Select OnEvent="cbState_OnSelect" />
                    </DirectEvents>
                </ext:ComboBox>
            </Items>
        </ext:FormPanel>        
    </form>
</body>
</html>
























































