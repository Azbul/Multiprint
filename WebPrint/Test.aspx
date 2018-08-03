<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        this.TextField1.FieldLabel = this.TextField1.Text;
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Ext.NET Examples</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <ext:FormPanel runat="server" Title="Title" Height="185" Width="350" Padding="5">
            <Items>
                <ext:TextField ID="TextField1" runat="server" FieldLabel="First Name" />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Submit" OnDirectClick="Button1_Click" />
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>

































