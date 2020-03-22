<%@ Page Title="" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardWrite.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardWrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <div class="panel-body" id="inbox">
        <ul class="ul_width740">
            <li>
                <asp:Label ID="lblBoardWrite1" runat="server" Text="게시판" CssClass="width-8 label_title"></asp:Label>
                <div class="width-84">
                    <asp:DropDownList ID="ddlBoardCategory" runat="server"></asp:DropDownList>
                </div>
            </li>
            <li>
                <asp:Label ID="lblBoardWrite2" runat="server" Text="제목" CssClass="width-8 label_title"></asp:Label>
                <div class="width-84">
                    <asp:TextBox ID="txbBoardTitle" runat="server" Width="450px"></asp:TextBox>
                </div>
            </li>
            <li>
                <asp:Label ID="lblBoardWrite3" runat="server" Text="내용" CssClass="width-8 label_title"></asp:Label>
                <div class="width-84"> 
                    <asp:TextBox ID="txbBoardContent" runat="server" Width="740px" Height="500px" TextMode="MultiLine"></asp:TextBox>
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
