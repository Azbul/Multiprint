<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebPrint.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
     <ext:ResourceManager runat="server" Theme="Gray" />
    <form id="form1" runat="server">
        <ext:Panel 
            ID="Window1"
            runat="server" 
            Title="Welcome to Ext.NET"
            Height="215"
            Width="350"
            Frame="true"
            Collapsible="true"
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
        </ext:Panel>
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
            <br />
                <asp:Button ID="Button1" runat="server" Text="ПЕЧАТЬ" OnClick="Button1_Click1" />
            
            <hr />
              <asp:GridView ID="GridView1" runat="server" Height="138px" Width="1039px">
                  <EmptyDataTemplate>Записей нет!</EmptyDataTemplate>
        </asp:GridView>
        
         </div>
       <!-- <asp:SqlDataSource ID="SqlDataSource3" runat="server" ProviderName="Npgsql" 
	ConnectionString="<%$ ConnectionStrings:UserDB %>"
            SelectCommand="SELECT Filename, FileStatus, PrinterId, PrintPages, PcName FROM Pqueues"/>
      -->
            <p>
                <asp:Button ID="Button2" runat="server" Text="ОБНОВИТЬ" OnClick="Button1_Click2" Height="54px" Width="102px" />
            </p>
    </form>
</body>
</html>
