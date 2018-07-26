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
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            <asp:Button ID="Button1" runat="server" Text="Обновить" OnClick="Button1_Click" style="margin-bottom: 0px" /> 
            <br />
            <br/>
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
