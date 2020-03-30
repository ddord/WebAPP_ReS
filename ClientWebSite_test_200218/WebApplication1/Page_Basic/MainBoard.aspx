<%@ Page Title="메인 게시판" Language="C#" MasterPageFile="~/NestedLeftSide.Master" AutoEventWireup="true" CodeBehind="MainBoard.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoard" %>
<%--
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <link rel="stylesheet" type="text/css"
        href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js">
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "Method_Basic.asmx/GetMainBoardList",                
                dataType: "json",
                success: function (data) {
                    $("#datatable").DataTable({
                        paging: true,
                        sort: false,
                        searching: true,
                        scrollY: 200,
                        data: data,
                        columns: [
                            { "data": "Category" },
                            { "data": "Title" },
                            { "data": "Name" },
                            { "data": "WirteDate" }
                        ]
                    });
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
        });
    </script>
    <div class="panel-body">
        <table id="datatable" class="table table-hover">
            <thead>
                <tr>
                    <th scope="col" class="col-md-1">분류
                    </th>
                    <th scope="col" class="col-md-5">제    목
                    </th>
                    <th scope="col" class="col-md-2">작성자
                    </th>
                    <th scope="col" class="col-md-2">날짜
                    </th>
                </tr>
            </thead>
        </table>
    </div>
</asp:Content>
--%>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentSub" runat="server">
    <script src="/Scripts/jquery-3.3.1.min.js"></script> 
    
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
                <table border="1" class="width-100">
                <tr class="board_height40">
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
                <tr class="board_height40">
                    <td class="col-md-2"><%#Eval("category")%></td>
                    <td class="col-md-5">
                        <asp:LinkButton ID="lnkbDetails" runat="server" Text='<%# Eval("mainBoardTitle")%>' CommandArgument='<%# Eval("category") + "/" + Eval("mainBoardNo")%>' OnClick="lnkbDetails_Click"></asp:LinkButton></td>
                    <td class="col-md-2"><%#Eval("id_Name")%></td>
                    <td class="col-md-1">                    
                        <%# DateTime.Now.ToString("yyyy.MM.dd.") == String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) ? String.Format("{0:HH:mm}", Eval("writeDate")) : String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) %>
                    </td>
                        <%--<td class="col-md-2"><%#Eval("writeDate")%></td>--%>
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
                        CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page_enabled" : "page_disabled" %>'
                        OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
               </ItemTemplate>
            </asp:Repeater>
        </div>       
    </div>
</asp:Content>

