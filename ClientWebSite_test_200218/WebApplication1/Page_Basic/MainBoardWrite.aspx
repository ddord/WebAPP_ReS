<%@ Page Title="" Language="C#" MasterPageFile="~/NestedLeftSide.master" AutoEventWireup="true" CodeBehind="MainBoardWrite.aspx.cs" Inherits="WebApplication1.Page_Basic.MainBoardWrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentSub" runat="server">
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.1/jquery.validate.min.js" type="text/javascript"></script>  
    
    <script type="text/javascript">                
        $(document).ready(function () {
            jQuery(function () {
                // You can specify some validation options here but not rules and messages
                jQuery('#inbox').validate();
                // Add a custom class to your name mangled input and add rules like this
                jQuery('#txbBoardTitle').rules('add', {
                    required: true,
                    messages: {
                        required: 'Some custom message for the username required field'
                    }
                });
            });
        });         
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
                    <asp:TextBox ID="txbBoardContent" runat="server" Width="740px" Height="500px" TextMode="MultiLine" CausesValidation="True"></asp:TextBox>                    
                </div>
            </li>
            <li>
                <div> 
                    <asp:Button ID="btnWrite" runat="server" Text="확인" CssClass="btn btn-default b" OnClick="btnWrite_Click" />                   
                </div>
            </li>
        </ul>
    </div>
</asp:Content>
