<%@ Page Title="메인 게시판" Language="C#" MasterPageFile="~/NestedLeftSide.Master" AutoEventWireup="true" CodeBehind="MainBoard.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoard" %>

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
                    $("#datatable").dataTable({
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

