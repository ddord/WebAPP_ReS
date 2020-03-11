<%@ Page Title="로그인" Language="C#" MasterPageFile="~/MainPage.Master" AutoEventWireup="true" CodeBehind="normalRegiste.aspx.cs" Inherits="WebApplication1.Page_Basic.LoginMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <hr />
    <div class="row">
        <div class ="col-xs-4"></div>
        <div class = "col-xs-4">
            <section id="loginForm">
                <div class="form-horizontal">                    
                    <asp:PlaceHolder runat="server" ID="LoginStatus" Visible="false">
                        <p class="text-danger">
                           <asp:Literal runat="server" ID="StatusText" />
                        </p>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" ID="LoginForm" Visible="false">
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                아이디 <asp:TextBox runat="server" ID="txbUserID" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                비밀번호
                                <asp:TextBox runat="server" ID="txbPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                비밀번호 확인
                                <asp:TextBox runat="server" ID="TextBox1" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                주소
                                <asp:TextBox runat="server" ID="TextBox2" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                이메일
                                <asp:TextBox runat="server" ID="TextBox3" TextMode="Password" CssClass="form-control" Text="" />
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" OnClick="SignIn" Text="확인" CssClass="btn btn-default" Height="60" Width="120" />
                            </div>                            
                        </div>
                    </asp:PlaceHolder>
                    <p>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">계정 만들기</asp:HyperLink>
                    </p>
                </div>
            </section>
        </div>
        <div class ="col-xs-4"></div>
    </div>
</asp:Content>

