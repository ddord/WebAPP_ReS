<%@ Page Title="메인 게시판 조회" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardView.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <div class="panel-body" id="inbox">
        <div class="h6 text-right">            
            <asp:Button ID="btnListBack" runat="server" CssClass="btn btn-default" Height="30" Text="목록" OnClick="btnListBack_Click" /></div>
        <div class="border borders-lightgray" id="post_article">
            <div class="tit-box">
                <div class="fl width-83">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td class="">
                                    <asp:Label ID="lblBoardTilte" runat="server" Text="board_Title" CssClass="Title_14px b"></asp:Label>
                                </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="fr width-16">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td></td>
                                <td class="">
                                    <asp:Label ID="lblBoardDate" runat="server" Text="board_Date" CssClass="text-right date_11px"></asp:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <hr />
            <div class="">
                <table>
                    <tbody>
                        <tr>
                            <td class="" id="board_NickName">
                                <asp:Label ID="lblBoardNickName" runat="server" Text="board_NickName" CssClass=""></asp:Label><asp:Label ID="lblUserId" runat="server" Text="lblUserId"></asp:Label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="h3"></div>
            <div class="" id="board_Content">
                <asp:Label ID="lblBoardContent" runat="server" Text="board_Content" CssClass=""></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
