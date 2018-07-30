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
            <asp:Label ID="Label2" runat="server" Text="Выбрать принтер"></asp:Label> &nbsp;&nbsp;&nbsp;
            <br />
            <br/>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
            
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text="Состояние:"></asp:Label>
            &nbsp;<asp:Label ID="Label3" runat="server" Text="Не подключен"></asp:Label> 
            <br />
            <br />
            <hr />
            &nbsp;&nbsp;
            <asp:Label ID="Label4" runat="server" Text="Диапазон:"></asp:Label>
            <br />
            
            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                <asp:ListItem Selected="True" Text ="Все" Value="1" />
                <asp:ListItem Text ="Страницы:" Value="2" />
            </asp:RadioButtonList>
            
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <br/>
            <input id="ipFilename" type="file" accept="application/pdf" name="ipFilename" runat="server"/>
            <br>
                <asp:Button ID="Button1" runat="server" Text="ПЕЧАТЬ" OnClick="Button1_Click1" />
            </br>
            <hr />
              <asp:GridView ID="GridView1" runat="server" Height="138px" Width="1039px">
                  <EmptyDataTemplate>Записей нет!</EmptyDataTemplate>
        </asp:GridView>
        
         </div>
      
       <!-- <asp:SqlDataSource ID="SqlDataSource3" runat="server" ProviderName="Npgsql" 
	ConnectionString="<%$ ConnectionStrings:UserDB %>"
            SelectCommand="SELECT Filename, FileStatus, PrinterId, PrintPages, PcName FROM Pqueues"/>
      -->
        

        
        
    </form>
</body>
</html>
