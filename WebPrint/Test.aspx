<%@ Page Language="C#" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        X.Msg.Notify(new NotificationConfig { 
            Icon  = Icon.Accept,
            Title = "Working",
            Html  = this.TextArea1.Text
        }).Show();
    }
</script>

<!DOCTYPE html>
    
<html>
<head runat="server">
    <title>Ext.NET Example</title>
</head>
<body>
    <ext:ResourceManager runat="server" Theme="Triton" />
    
    <form runat="server">

        <ext:Panel 
            ID="Window1"
            runat="server" 
            Title="Welcome to Ext.NET"
            Height="215"
            Width="350"
            Frame="true"
            Align="Center"
            Cls="box"
            BodyPadding="5"
            DefaultButton="0"
            Layout="AnchorLayout"
            DefaultAnchor="100%">
            <Items>
                <ext:TextArea 
                    ID="TextArea1" 
                    runat="server" 
                    EmptyText=">> Enter a Test Message Here <<"
                    FieldLabel="Message" 
                    Height="85" 
                    />
            </Items>
            <Buttons>
                <ext:Button 
                    ID="Button1"
                    runat="server" 
                    Text="Submit"
                    Icon="PrinterEmpty" 
                    OnDirectClick="Button1_Click" 
                    />
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>