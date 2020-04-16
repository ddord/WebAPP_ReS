<%@ Page Title="메인 게시판 조회" Language="C#" MasterPageFile="~/MasterPage/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardView.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <script>
        $(document).ready(function () {
            userID = '<%=Session["userID"]%>';
            category = '<%=Session["category"]%>';
            boardNo = '<%=Session["boardNo"]%>';

            BoardViewSetting();
            getBoardViewValue();
        });
       
        function BoardViewSetting() {
            editorSetting("txaBoardContent", "");

            editor = $("#txaBoardContent").data("kendoEditor");
            $(editor.body).attr('contenteditable', false);
            $('.k-editor-toolbar').hide();
        }
       
        function getBoardViewValue() {
            var userInfo = {
                userId: userID,
                category: category,
                boardNo: boardNo,
                statementType: "ViewAricle"
            }

            $.ajax({
                type: "POST",
                url: "../Service/BoardCommon.asmx/SelectBoardView",
                data: JSON.stringify(userInfo),
                dataType: "json", 
                contentType: "application/json; charset=utf-8",               
                success: function (data) {
                    if (data.d.length > 0) {
                        var list = JSON.parse(data.d);
                        $('#lblBoardTitle').text(list[0].mainBoardTitle);
                        $('#lblBoardDate').text(list[0].writeDate.split('T')[0]);
                        $('#lblBoardNickName').text(list[0].id_Name);
                        $('#lblUserId').text("(" + list[0].userID.substring(0, 3) + "****)");
                        editor.value(list[0].mainBoardContent);
                    }
                    else {
                        alert("에러: 글을 불러오지 못했습니다.");
                        location.href("../Page_Basic/MainBoard.aspx");
                    }
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });

        }
    </script>        
    
    <div class="panel-body" id="inbox">
        <div class="h6 text-right">   
            <span class="margin_LR_5">
                <asp:Button ID="btnBoardModify" runat="server" CssClass="btn btn-default" Height="30" Text="수정" OnClick="btnBoardModify_Click" Visible="False" />
            </span>
            <span class="margin_LR_5">
                <asp:Button ID="btnBoardDelete" runat="server" CssClass="btn btn-default" Height="30" Text="삭제" OnClick="btnBoardDelete_Click" Visible="False" />
            </span>
            <span class="margin_LR_5">
                <asp:Button ID="btnListBack" runat="server" CssClass="btn btn-default" Height="30" Text="목록" OnClick="btnListBack_Click" />
            </span>          
        </div>
        <div class="border borders-lightgray" id="post_article">
            <div class="tit-box">
                <div class="fl width-83">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td class="">
                                    <span id="lblBoardTitle" class ="Title_14px b">                                        
                                    </span><%-- <asp:Label ID="lblBoardTilte" runat="server" CssClass="Title_14px b"></asp:Label>--%>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="fr width-16">
                    <table>
                        <tbody>
                            <tr style="vertical-align:top;">
                                <td class="">
                                    <span id="lblBoardDate" class ="text-right date_11px">                                        
                                    </span><%--<asp:Label ID="lblBoardDate" runat="server" CssClass="text-right date_11px"></asp:Label>--%>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="">
                <table>
                    <tbody>
                        <tr>
                            <td class="" id="board_NickName">
                                <span id="lblBoardNickName" class ="text-right date_11px">                                        
                                </span>
                                <span id="lblUserId" class ="text-right date_11px">                                        
                                </span><%--<asp:Label ID="lblBoardNickName" runat="server" CssClass=""></asp:Label><asp:Label ID="lblUserId" runat="server"></asp:Label>--%>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="h3"></div>
            <div id="board_Content">
                <textarea id="txaBoardContent" aria-label="editor" style="height:600px;"></textarea>
            </div>
        </div>
    </div>
</asp:Content>
