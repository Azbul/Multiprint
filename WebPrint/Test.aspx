<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script runat="server">

    
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Button1_Click(object sender, DirectEventArgs e)
    {
    
    }

    protected void Button2_Click(object sender, DirectEventArgs e)
    {
    }

    protected void Button3_Click(object sender, DirectEventArgs e)
    {
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Ext.NET Examples</title>
</head>
<body>
    <form runat="server" enctype="multipart/form-data">
        <ext:ResourceManager runat="server" />
        
        <ext:FormPanel runat="server" Title="Title" Height="185" Width="350" Padding="5">
            <Items>
                 <ext:TextField ID="TextField1" runat="server" FieldLabel="From To"/>
                 <ext:FileUploadField ID="UploadField" runat="server" Width="300" FieldLabel="Выбрать файл" EmptyText="Файл не выбран" Accept="application/pdf" Icon="Attach" />

            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Load" OnDirectClick="Button1_Click" />
                 <ext:Button runat="server" Text="Print" OnDirectClick="Button2_Click" />
                 <ext:Button runat="server" Text="Adv Print" OnDirectClick="Button3_Click" />
            </Buttons>

        </ext:FormPanel>
    </form>
</body>
</html>

































