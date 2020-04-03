<%@ Page Title="메인 게시판 조회" Language="C#" MasterPageFile="~/MasterPage/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardView.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <script>
        $(document).ready(function () {
            userID = '<%=Session["userID"]%>';
            category = '<%=Session["category"]%>';
            boardNo = '<%=Session["boardNo"]%>';

            editorSetting("txaBoardContent");
            BoardViewSetting();
            getBoardViewValue();
        });
       
        function BoardViewSetting() {
            editor = $("#txaBoardContent").data("kendoEditor");
            $(editor.body).attr('contenteditable', false);
            $('.k-editor-toolbar').hide();
        }
       
        function getBoardViewValue() {
            var userInfo = {
                userId: userID,
                category: category,
                boardNo: boardNo,
                statementType: "Select"
            }

            $.ajax({
                type: "POST",
                url: "../Service/BoardCommon.asmx/SelectBoardView",
                data: userInfo,
                dataType: "json",
                success: function (data, status, jqXhr) {
                    if (data.d[6] == "다시 확인 해주시기 바랍니다.") {
                        $("#loadtext").html(data.d[0]); //해당 내용을 보여준다
                        $("#loadname").html(data.d[1]); //해당 내용을 보여준다
                        $("#loadpwd").html(data.d[2]); //해당 내용을 보여준다
                        $("#loadpwdRe").html(data.d[3]); //해당 내용을 보여준다
                        $("#loadaddr").html(data.d[4]); //해당 내용을 보여준다
                        $("#loadEmail").html(data.d[5]); //해당 내용을 보여준다
                        alert(data.d[6]);
                    }
                    else {
                        alert(data.d[6]);
                        location.href = "/Page_Basic/LoginMain.aspx";
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
                                    <asp:Label ID="lblBoardTilte" runat="server" Text="board_Title" CssClass="Title_14px b"></asp:Label>
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
                                    <asp:Label ID="lblBoardDate" runat="server" Text="board_Date" CssClass="text-right date_11px"></asp:Label>
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
                                <asp:Label ID="lblBoardNickName" runat="server" Text="board_NickName" CssClass=""></asp:Label><asp:Label ID="lblUserId" runat="server" Text="lblUserId"></asp:Label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="h3"></div>
            <div class="" id="board_Content">
                <textarea id="txaBoardContent" readonly="readonly" >테스트</textarea>
                <%-- <asp:Label ID="lblBoardContent" runat="server" Text="board_Content" CssClass=""></asp:Label>--%>
            </div>
        </div>
    </div>
</asp:Content>
