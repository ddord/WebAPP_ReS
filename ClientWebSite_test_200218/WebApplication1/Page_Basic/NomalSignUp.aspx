<%@ Page Title="회원가입" Language="C#" MasterPageFile="~/LogoOne.Master" AutoEventWireup="true" CodeBehind="NomalSignUp.aspx.cs" Inherits="WebApplication1.Page_Basic.NomalSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function validatePromo(src, args) {
            var isValid;
            $.ajax({
                type: "POST",
                url: "NomalSignUp.aspx/IsPromoValid",
                data: "{'code': '" + args + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (msg) {
                    isValid = msg.d;
                }
            });
            args.IsValid = isValid;
        }
    </script>
    <h2><%: Title %>.</h2>
    <hr />
        <div class="row" id="div11">
            <div class ="col-xs-4"></div>
            <div class = "col-xs-4">
                <section id="loginForm">
                    <div class="form-horizontal">                    
                        <asp:PlaceHolder runat="server" ID="SignUpForm" >
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    아이디 <asp:TextBox runat="server" ID="txbUserID" CssClass="form-control required" Text="" />
                                    <asp:RequiredFieldValidator ID="FieldValiUserID" runat="server" ControlToValidate="txbUserID" CssClass="text-danger" ErrorMessage="아이디는 필드는 입력입니다." Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="ExpressionValidatorUserID" CssClass="text-danger" runat="server" ControlToValidate="txbUserID" ValidationExpression="^(([0-9])\w*|\w*([a-zA-Z]))*.{8,15}$" ErrorMessage="아이디는 8~15자리의 문자로 이루어져야 합니다." Display="Dynamic"/>

                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    성명(실제) <asp:TextBox runat="server" ID="txbUserName" CssClass="form-control required" Text="" />
                                    <asp:RequiredFieldValidator ID="FieldValiUserName" runat="server" ControlToValidate="txbUserName" CssClass="text-danger" ErrorMessage="성명은 필수 입력입니다." Display="Dynamic" />                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    비밀번호
                                    <asp:TextBox runat="server" ID="txbPwd" TextMode="Password" CssClass="form-control required" Text="" />
                                    <asp:RequiredFieldValidator ID="FieldValiPwd" runat="server" ControlToValidate="txbPwd" CssClass="text-danger" ErrorMessage="비밀번호는 필수 입력입니다." Display="Dynamic"  />
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    비밀번호 확인
                                    <asp:TextBox runat="server" ID="txbPwdRe" TextMode="Password" CssClass="form-control equalTo" Text="" />
                                    <asp:CompareValidator ID="FieldValiPwdCompare" runat="server" CssClass="text-danger" ErrorMessage="비밀번호 확인을 다시 입력 해주세요." ControlToValidate="txbPwd" ControlToCompare="txbPwdRe" Display="Dynamic"  />                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    주소
                                    <asp:TextBox runat="server" ID="txbAddress" CssClass="form-control required" Text="" />
                                    <asp:RequiredFieldValidator ID="FieldValiAdd" runat="server" ControlToValidate="txbAddress" CssClass="text-danger" ErrorMessage="주소는 필수 입력입니다." Display="Dynamic"  />
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    이메일
                                    <asp:TextBox runat="server" ID="txbEmail" CssClass="form-control required" Text="" />
                                    <asp:RequiredFieldValidator ID="FieldValiEmail" runat="server" ControlToValidate="txbEmail" CssClass="text-danger" ErrorMessage="이메일는 필수 입력입니다." Display="Dynamic"  />
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div class="text-center col-md-offset-2 col-md-10">
                                    <asp:Button runat="server" Text="확인" OnClick="SignUp_Click" CssClass="btn btn-default" Height="40" Width="140" />
                                </div>                            
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </section>
            </div>
            <div class ="col-xs-4"></div>
        </div>
</asp:Content>
