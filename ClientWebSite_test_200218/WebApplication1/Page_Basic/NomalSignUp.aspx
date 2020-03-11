<%@ Page Title="회원가입" Language="C#" MasterPageFile="~/LogoOne.Master" AutoEventWireup="true" CodeBehind="NomalSignUp.aspx.cs" Inherits="WebApplication1.Page_Basic.NomalSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <hr />
    <div class="row">
        <div class ="col-xs-4"></div>
        <div class = "col-xs-4">
            <section id="loginForm">
                <div class="form-horizontal">                    
                    <asp:PlaceHolder runat="server" ID="SignUpForm" >
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                아이디 <asp:TextBox runat="server" ID="txbUserID" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator ID="FieldValiUserID" runat="server" ControlToValidate="txbUserID" CssClass="text-danger" ErrorMessage="아이디 필드는 필수입니다." />
                                <asp:RegularExpressionValidator ID="ExpressionValidatorUserID" CssClass="text-danger" runat="server" ControlToValidate="txbUserID" ValidationExpression="^(([0-9])\w*|\w*([a-zA-Z]))*.{15}$" ErrorMessage="아이디는 반드시 15자리의 문자로 이루어져야 합니다." Display="Dynamic"/>
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                비밀번호
                                <asp:TextBox runat="server" ID="txbPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txbPassword" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                비밀번호 확인
                                <asp:TextBox runat="server" ID="TextBox1" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txbPassword" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                주소
                                <asp:TextBox runat="server" ID="TextBox2" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txbPassword" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                이메일
                                <asp:TextBox runat="server" ID="TextBox3" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txbPassword" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div class="text-center col-md-offset-2 col-md-10">
                                <%-- <asp:Button runat="server" OnClick="SignUp_Click" Text="확인" CssClass="btn btn-default" Height="40" Width="140" />--%>
                            </div>                            
                        </div>
                    </asp:PlaceHolder>
                </div>
            </section>
        </div>
        <div class ="col-xs-4"></div>
    </div>
</asp:Content>
