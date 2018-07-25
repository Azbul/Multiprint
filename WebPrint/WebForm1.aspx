<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebPrint.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label2" runat="server" Text="Выбрать принтер"></asp:Label> <br/>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                <asp:ListItem Text="Принтер1" Value="1"></asp:ListItem> 
                <asp:ListItem Text="Принтер2" Value="2"></asp:ListItem> 
                <asp:ListItem Text="Принтер3" Value="3"></asp:ListItem> 
            </asp:RadioButtonList>
            <asp:Button ID="Button1" runat="server" Text="Обновить" OnClick="Button1_Click" /> <br/> <br/>
            <asp:Label ID="Label1" runat="server" Text="Изменить статус принтера"></asp:Label><br/>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br/>
        </div>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
