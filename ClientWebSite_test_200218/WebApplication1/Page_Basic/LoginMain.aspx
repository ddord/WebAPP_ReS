﻿<%@ Page Title="로그인" Language="C#" MasterPageFile="~/MasterPage/LogoOne.Master" AutoEventWireup="true" CodeBehind="LoginMain.aspx.cs" Inherits="WebApplication1.Page_Basic.LoginMain" %>
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
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div>
                                비밀번호
                                <asp:TextBox runat="server" ID="txbPassword" TextMode="Password" CssClass="form-control" Text="" />
                                <p class="err_txt" ID="login-error-message">
                                    <asp:Label ID="lbl_error" runat="server" Text="" Visible="false"></asp:Label></p>
                            </div>
                        </div>
                        <div style="margin-bottom: 10px" class="form-group">
                            <div class="col-md-offset-2 col-md-10">
                                <asp:Button runat="server" OnClick="SignIn" Text="로그인" CssClass="btn btn-default"/>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <p>
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled" NavigateUrl="/Page_Basic/NormalSignUp.aspx">계정 만들기</asp:HyperLink>
                    </p>
                </div>
            </section>
        </div>
        <div class ="col-xs-4"></div>
    </div>
</asp:Content>

