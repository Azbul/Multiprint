<%@ Page Language="C#" %>
  
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
 
<script runat="server">
    public class Test
    {
        public string Value { get; set; }
        public string Text { get; set; }
    }
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            Store store = this.MultiSelect1.GetStore();
            store.DataSource = new object[] 
            { 
                new Test()
                {
                    Value = "1",
                    Text = "Item 1"   
                },
                new Test()
                {
                    Value = "2",
                    Text = "Item 2"   
                },
                new Test()
                {
                    Value = "3",
                    Text = "Item 3"   
                }
            };
        }
    }
 
    protected void Submit(object sender, DirectEventArgs e)
    {
        Test selectedItem = JSON.Deserialize<Test>(e.ExtraParams["data"]);

        X.Msg.Alert("Submit", selectedItem.Text).Show();
    }
</script>
 
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Ext.NET v2 Example</title>

    <script>
        var getSelectedData = function () {
            var s = App.MultiSelect1.getSelected();
            
            if (s.length > 0) {
                s = s[0].data;
            } 

            return Ext.encode(s);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <ext:MultiSelect
            ID="MultiSelect1"
            runat="server"
            ValueField="Value"
            DisplayField="Text"
            SingleSelect="true">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Value" />
                                <ext:ModelField Name="Text" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
        </ext:MultiSelect>
 
        <ext:Button runat="server" Text="Submit">
            <DirectEvents>
                <Click OnEvent="Submit" Before="return App.MultiSelect1.getSelected().length > 0;">
                    <ExtraParams>
                        <ext:Parameter
                            Name="data"
                            Value="getSelectedData()"
                            Mode="Raw" />
                    </ExtraParams>
                </Click>
            </DirectEvents>
        </ext:Button>
    </form>
</body>
</html>




































































































