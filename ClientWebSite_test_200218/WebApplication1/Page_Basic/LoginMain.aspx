<%@ Page Title="로그인" Language="C#" MasterPageFile="~/MainSite.Master" AutoEventWireup="true" CodeBehind="LoginMain.aspx.cs" Inherits="WebApplication1.Page_Basic.LoginMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <hr />
                    <asp:PlaceHolder runat="server" ID="LoginStatus" Visible="false">
                        <p class="text-danger">
                           <asp:Literal runat="server" ID="StatusText" />
                        </p>
                    </asp:PlaceHolder>
                    <asp:PlaceHolder runat="server" ID="LoginForm" Visible="false">
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                <asp:TextBox runat="server" ID="txbUserID" CssClass="form-control" Text="아이디" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                <asp:TextBox runat="server" ID="txbPassword" TextMode="Password" CssClass="form-control" Text="패스워드"/>
                                <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ErrorMessage="error" />
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <%-- <asp:Button runat="server" OnClick="SignIn" Text="Log in" CssClass="btn btn-default"/>--%>
                            </div>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder runat="server" ID="LogoutButton" Visible="false">
                        <div style="margin-bottom: 10px" class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <%-- <asp:Button runat="server" OnClick="SignOut" Text="Log out" CssClass="btn btn-default"/>--%>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <p>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">등록</asp:HyperLink>
                        로컬 계정이 없는 경우.
                    </p>
                </div>
            </section>
        </div>
    </div>
</asp:Content>

