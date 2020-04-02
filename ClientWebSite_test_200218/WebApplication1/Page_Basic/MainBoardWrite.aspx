<%@ Page Title="메인 게시판 작성" Language="C#" MasterPageFile="~/MasterPage/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardWrite.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardWrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">

    <%-- <script src="/Scripts/jquery-3.3.1.min.js"></script>--%>


    <script>                
        $(document).ready(function () {
            userID = '<%= UserId %>';
            userName = '<%= UserName %>';

            editorSetting("editor");
            
        });
        
        function boardWrite() {
            var titleValue, contentValue, titleRule, contentRule;
            var fieldValidCount = 0;

            titleValue = $("input[id$='txbBoardTitle']").val().trim();
            contentValue = $("#editor").val().trim();
            titleRule = /^[\w가-힣ㄱ-ㅎㅏ-ㅣ\s~!@#$%^&*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,50}$/;
            contentRule = /^[\w가-힣ㄱ-ㅎㅏ-ㅣ\s~!@#$%^&*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,300}$/;

            if (titleValue == "")
                alert("제목을 적어주세요.");
            else if (!titleRule.test(titleValue))
                alert("작성한 제목을 확인해주세요. (특수문자, 한문 등)");
            else
                fieldValidCount += 1;

            if (contentValue == "")
                alert("내용을 적어주세요.");
            else if (!contentRule.test(contentValue))
                alert("작성한 내용을 확인해주세요. (특수문자, 한문 등)");
            else
                fieldValidCount += 1;

            if (fieldValidCount == 2) {

                var insertValue = {
                    userId: userID,
                    userName: userName,
                    category: $("select[id$='ddlBoardCategory']").val(),
                    mainBoardTitle: titleValue,
                    mainBoardContent: contentValue,
                    statementType: ($("#btnWrite").text() == "등록") ? "Insert" : "Update"
                }

                $.ajax({
                    type: "POST",
                    url: "../Service/BoardCommon.asmx/InsertUpdateBoardWrite",
                    data: JSON.stringify(insertValue),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            alert("작성완료");                            
                            location.href = "/Page_Basic/MainBoardView.aspx?iNum=" + data.d;
                        } else {
                            alert("작성실패");
                        }
                    },
                    error: function (request, status, error) {
                        alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    }
                });
            }

        }

        <%--
        function validateMessage() {
            var titleValue, contentValue, titleRule, contentRule;
            var return_bool = false, fieldValidCount = 0;

            titleValue = $("input[id$='txbBoardTitle']").val().trim();
            contentValue = $("#editor").val().trim();
            titleRule = /^[\w가-힣ㄱ-ㅎㅏ-ㅣ\s!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,50}$/;
            contentRule = /^[\w가-힣ㄱ-ㅎㅏ-ㅣ\s!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,300}$/;

            if (titleValue == "")
                alert("제목을 적어주세요.");
            else if (!titleRule.test(titleValue))
                alert("작성한 제목을 확인해주세요. (특수문자, 한문 등)");
            else
                fieldValidCount += 1;

            if (contentValue == "")
                alert("내용을 적어주세요.");
            else if (!contentRule.test(contentValue))
                alert("작성한 내용을 확인해주세요. (특수문자, 한문 등)");
            else 
                fieldValidCount += 1;

            if (fieldValidCount == 2)
                return_bool = true;

            return return_bool;
        }
        --%>
    </script>  

    <div class="panel-body" id="inbox">
        <ul class="ul_width740">
            <li>
                <div class="col-xs-1">
                    <asp:Label ID="lblBoardWrite1" runat="server" Text="게시판" CssClass="width-8 label_title"></asp:Label>
                </div>
                
                <div class="col-xs-11">                                    
                    <asp:DropDownList ID="ddlBoardCategory" runat="server"></asp:DropDownList>
                </div>
            </li>
            <li>
                <div class="col-xs-1">
                    <asp:Label ID="lblBoardWrite2" runat="server" Text="제목" CssClass="width-8 label_title"></asp:Label>
                </div>
                <div class="col-xs-11">
                    <asp:TextBox ID="txbBoardTitle" runat="server" Width="450px" CausesValidation="True"></asp:TextBox>
                </div>
            </li>
            <li>
                <div class="col-xs-1">
                    <asp:Label ID="lblBoardWrite3" runat="server" Text="내용" CssClass="width-8 label_title"></asp:Label>
                </div>
                <div class="col-xs-11"> 
                    <textarea id="editor" name="editor" rows="10" cols="30" style="width:740px;height:500px" aria-label="editor"></textarea>
                    <%-- <asp:TextBox ID="txbBoardContent" runat="server" Width="740px" Height="500px" TextMode="MultiLine"></asp:TextBox> --%>
                </div>
                
            </li>
            <li>
                <div> 
                    <button ID="btnWrite" type="button" class="btn btn-default b" OnClick="boardWrite()">등록</button>
                     <%--<asp:Button ID="btnWrite" runat="server" Text="확인" CssClass="btn btn-default b" OnClick="btnWrite_Click" OnClientClick ="return validateMessage();" /> --%>                   
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
