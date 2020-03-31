<%@ Page Title="" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardWrite.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardWrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.1/jquery.validate.min.js" type="text/javascript"></script>  
    
    <script type="text/javascript">                
        $(document).ready(function () {
        }); 

        function validateMessage() {
            var titleValue, contentValue, titleRule, contentRule;
            var return_bool = false, fieldValidCount = 0;

            titleValue = $("input[id$='txbBoardTitle']").val();
            contentValue = $("input[id$='txbBoardContent']").val();
            titleRule = /[\w가-힣\s!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,50}$/;
            contentRule = /[\w가-힣\s!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]{1,300}$/;

            if (titleValue == "") {
                $("#titleValiMessage").text("제목을 적어주세요.");
            }
            else if (titleRule.test(titleValue)) {
                $("#titleValiMessage").text("작성한 내용을 확인해주세요. (특수문자, 한문 등)");
            }
            else
                fieldValidCount += 1;

            if (contentValue == "") {
                $("#contentValiMessage").text("내용을 적어주세요.");
            }
            else if (contentRule.test(contentValue)) {
                $("#contentValiMessage").text("작성한 내용을 확인해주세요. (특수문자, 한문 등)");
            }
            else
                fieldValidCount += 1;

            if (fieldValidCount == 2)
                return_bool = true;

            return return_bool;
        }
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
                    <div id ="titleValiMessage" class="error_label"></div>
                </div>
            </li>
            <li>
                <div class="col-xs-1">
                    <asp:Label ID="lblBoardWrite3" runat="server" Text="내용" CssClass="width-8 label_title"></asp:Label>
                </div>
                <div class="col-xs-11"> 
                    <asp:TextBox ID="txbBoardContent" runat="server" Width="740px" Height="500px" TextMode="MultiLine"></asp:TextBox> 
                    <div id ="contentValiMessage" class="error_label"></div>
                </div>
                
            </li>
            <li>
                <div> 
                    <asp:Button ID="btnWrite" runat="server" Text="확인" CssClass="btn btn-default b" OnClick="btnWrite_Click" OnClientClick ="return validateMessage();" />                   
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
