<%@ Page Title="메인 게시판" Language="C#" MasterPageFile="~/NestedLeftSide.Master" AutoEventWireup="true" CodeBehind="MainBoard.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#datatable').data
        });
    </script>

    <table id="datatable" class="table table-hover">
        <thead>
            <tr>
                <th scope="col" class="col-md-1">분류
                </th>
                <th scope="col" class="col-md-5">제목
                </th>
                <th scope="col" class="col-md-3">글쓴이
                </th>
                <th scope="col" class="col-md-3">날짜
                </th>
            </tr>
        </thead>
        <tbody>
            <tr class="">
                <td class="col-md-1" >1</td>
                <td class="col-md-5">Montería</td>
                <td class="col-md-3">Colombia</td>
                <td class="col-md-3">2019.01.02.</td>
            </tr>
            <tr>
                <td class ="col-md-1">2</td>
                <td class ="col-md-5">Birmingham</td>
                <td class ="col-md-3">United Kingdom</td>
                <td class ="col-md-3">2019.01.02.</td>
            </tr>
            
        </tbody>
    </table>
</asp:Content>

