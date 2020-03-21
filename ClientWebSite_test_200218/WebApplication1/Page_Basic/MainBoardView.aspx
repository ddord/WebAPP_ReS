<%@ Page Title="메인 게시판 조회" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardView.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <div class="panel-body" id="inbox">
        <div class="h6 text-right"><asp:Button ID="btnListBack" runat="server" CssClass="btn btn-default" Height="30" Text="목록" /></div>
        <div class="panel-body border borders-lightgray" id="post_article">
            <div class="">
                <div class="fl">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td class="" id="board_Title"></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="fr">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td></td>
                                <td class="" id="board_Date"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <hr />
            <div class="fl">
                <table>
                    <tbody>
                        <tr>
                            <td class="" id="board_NickName"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="h3"></div>
            <div class="" id="board_Content"></div>
        </div>
    </div>
</asp:Content>
