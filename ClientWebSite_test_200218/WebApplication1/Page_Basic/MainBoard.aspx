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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {   

            $(document).ajaxStart(function () {
                $("[id$=loadingImg]").show();
            });
  
            $(document).ajaxStop(function () {
                $("[id$=loadingImg]").hide();
            });
        
            $("#submitButton").click(function (e) {
                CallServerFunction(1);
                return false;
            });

            $("#pagingDiv").on("click", "a", function () {
                CallServerFunction($(this).attr("pn"));
            });
        });

        function CallServerFunction(pageNo) {
            $.ajax({
                type: "POST",
                url: "Method_Basic.asmx/bind",
                data: "{pageNo:" + pageNo + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result, status, xhr) {
                    OnSuccess(msg.d, pageNo);
                },
                error: function (req, status, error) {
                    alert("code:" + req.status + "\n" + "message:" + req.responseText + "\n" + "status:" + status + "\n" + "error:" + error);
                }
            });
        }

        function OnSuccess(message, pageNo) {
            var xmlDoc = $.parseXML(message);
            var xml = $(xmlDoc);
            var product = xml.find("Table");
            var row = $("[id*=grvMainBoard] tr:last-child").clone(true);
            $("[id*=grvMainBoard] tr").not($("[id*=grvMainBoard] tr:first-child")).remove();
  
            $.each(product, function () {
                var customer = $(this);
                $("td", row).eq(0).html($(this).find("Category").text());
                $("td", row).eq(1).html($(this).find("Title").text());
                $("td", row).eq(2).html($(this).find("Name").text());
                $("td", row).eq(3).html($(this).find("WirteDate").text());
                $("[id*=grvMainBoard]").append(row);
                row = $("[id*=grvMainBoard] tr:last-child").clone(true);
            });
  
            var result = Paging(pageNo, 10, xml.find("Table1 > Total").text(), "myClass", "myDisableClass");
            $("#pagingDiv").html(result)
        } 

        function Paging(PageNumber, PageSize, TotalRecords, ClassName, DisableClassName) {
            var ReturnValue = "";
  
            var TotalPages = Math.ceil(TotalRecords / PageSize);
            if (+PageNumber > 1) {
                if (+PageNumber == 2)
                    ReturnValue = ReturnValue + "<a pn='" + (+PageNumber - 1) + "' class='" + ClassName + "'>Previous</a>&nbsp;&nbsp;&nbsp;";
                else {
                    ReturnValue = ReturnValue + "<a pn='";
                    ReturnValue = ReturnValue + (+PageNumber - 1) + "' class='" + ClassName + "'>Previous</a>&nbsp;&nbsp;&nbsp;";
                }
            }
            else
                ReturnValue = ReturnValue + "<span class='" + DisableClassName + "'>Previous</span>&nbsp;&nbsp;&nbsp;";
            if ((+PageNumber - 3) > 1)
                ReturnValue = ReturnValue + "<a pn='1' class='" + ClassName + "'>1</a>&nbsp;.....&nbsp;|&nbsp;";
            for (var i = +PageNumber - 3; i <= +PageNumber; i++)
                if (i >= 1) {
                    if (+PageNumber != i) {
                        ReturnValue = ReturnValue + "<a pn='";
                        ReturnValue = ReturnValue + i + "' class='" + ClassName + "'>" + i + "</a>&nbsp;|&nbsp;";
                    }
                    else {
                        ReturnValue = ReturnValue + "<span style='font-weight:bold;'>" + i + "</span>&nbsp;|&nbsp;";
                    }
                }
            for (var i = +PageNumber + 1; i <= +PageNumber + 3; i++)
                if (i <= TotalPages) {
                    if (+PageNumber != i) {
                        ReturnValue = ReturnValue + "<a pn='";
                        ReturnValue = ReturnValue + i + "' class='" + ClassName + "'>" + i + "</a>&nbsp;|&nbsp;";
                    }
                    else {
                        ReturnValue = ReturnValue + "<span style='font-weight:bold;'>" + i + "</span>&nbsp;|&nbsp;";
                    }
                }
            if ((+PageNumber + 3) < TotalPages) {
                ReturnValue = ReturnValue + ".....&nbsp;<a pn='";
                ReturnValue = ReturnValue + TotalPages + "' class='" + ClassName + "'>" + TotalPages + "</a>";
            }
            if (+PageNumber < TotalPages) {
                ReturnValue = ReturnValue + "&nbsp;&nbsp;&nbsp;<a pn='";
                ReturnValue = ReturnValue + (+PageNumber + 1) + "' class='" + ClassName + "'>Next</a>";
            }
            else
                ReturnValue = ReturnValue + "&nbsp;&nbsp;&nbsp;<span class='" + DisableClassName + "'>Next</span>";
  
            return (ReturnValue);
        }
    </script>

    <div class="panel-body">
        <asp:Repeater ID="RepeaterMainBoardList" runat="server">
            <HeaderTemplate>
                <table  border="1">
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
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="col-md-1"><%#Eval("category")%></td>
                    <td class="col-md-5">
                        <asp:LinkButton ID="lnkbDetails" runat="server" Text='<%# Eval("mainBoardTitle")%>' CommandArgument='<%# Eval("category") + "/" + Eval("mainBoardNo")%>' OnClick="lnkbDetails_Click"></asp:LinkButton></td>
                    <td class="col-md-2"><%#Eval("id_Name")%></td>
                    <td class="col-md-2">                    
                        <%# DateTime.Now.ToString("yyyy.MM.dd.") == String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) ? String.Format("{0:HH:mm}", Eval("writeDate")) : String.Format("{0:yyyy.MM.dd.}", Eval("writeDate")) %>
                    </td>
                        <%-- %><td class="col-md-2"><%#Eval("writeDate")%></td>--%>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <div id="pagingDiv"></div>
        <img id="loadingImg" src="loading.gif" />
    </div>
</asp:Content>

