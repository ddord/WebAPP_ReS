<%@ Page Title="" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardWrite.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardWrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <div class="panel-body" id="inbox">
        <ul>
            <li>
                <asp:Label ID="lblBoardWrite1" runat="server" Text="게시판"></asp:Label>
                <div>
                    <asp:DropDownList ID="ddlBoardCategory" runat="server"></asp:DropDownList>
                </div>
            </li>
            <li>
                <asp:Label ID="lblBoardWrite2" runat="server" Text="제목"></asp:Label>
                <div>
                    <asp:TextBox ID="txbBoardTitle" runat="server"></asp:TextBox>
                </div>
            </li>
            <li>
                <asp:Label ID="lblBoardWrite3" runat="server" Text="내용"></asp:Label>
                <div>
                    <asp:TextBox ID="txbBoardContent" runat="server"></asp:TextBox>
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
