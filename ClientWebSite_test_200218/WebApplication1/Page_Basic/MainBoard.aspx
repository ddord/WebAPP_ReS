<%@ Page Title="메인 게시판" Language="C#" MasterPageFile="~/MasterPage/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoard.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentSub" runat="server">   
    <div class="panel-body">
        <div class="h6">
            <div style="float:left;">
                <asp:Button ID="btnBoardWrite" runat="server" Text="글쓰기" CssClass="btn btn-default b" Visible="false" OnClick="btnBoardWrite_Click"/>
            </div>
            <div style="float:right;">
                <asp:DropDownList ID="ddlListCount" runat="server" CssClass="mydropdownlist_gray" Height="30px" Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlListCount_SelectedIndexChanged">
                    <asp:ListItem Value="count5">5</asp:ListItem>
                    <asp:ListItem Value="count10">10</asp:ListItem>
                    <asp:ListItem Value="count15">15</asp:ListItem>
                    <asp:ListItem Value="count30">30</asp:ListItem>
                    <asp:ListItem Value="count60">60</asp:ListItem>
                </asp:DropDownList>
            </div>            
        </div>
        <asp:Repeater ID="RepeaterMainBoardList" runat="server">
            <HeaderTemplate>
                <table class="width-100 ">
                <tr class="board_height40 board_main">
                    <th scope="col" class="col-md-1">분류
                    </th>
                    <th scope="col" class="col-md-5">제    목
                    </th>
                    <th scope="col" class="col-md-2">작성자
                    </th>
                    <th scope="col" class="col-md-2">날짜
                    </th>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr class="board_height30">
                    <td class="col-md-2"><%#Eval("category")%></td>
                    <td class="col-md-5">
                        <asp:LinkButton ID="lnkbDetails" runat="server" Text='<%# Eval("mainBoardTitle")%>' CommandArgument='<%# Eval("category") + "/" + Eval("mainBoardNo")%>' OnClick="lnkbDetails_Click"></asp:LinkButton></td>
                    <td class="col-md-2"><%#Eval("id_Name")%></td>
                    <td class="col-md-1">                    
                        <%# DateTime.Now.ToString("yyyy.MM.dd.") == String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) ? String.Format("{0:HH:mm}", Eval("writeDate")) : String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <div id="pagingDiv">
            <asp:Repeater ID="rptPager" runat="server">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "active" : "page_disabled" %>'
                        OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
               </ItemTemplate>
            </asp:Repeater>
        </div>       
    </div>
</asp:Content>

