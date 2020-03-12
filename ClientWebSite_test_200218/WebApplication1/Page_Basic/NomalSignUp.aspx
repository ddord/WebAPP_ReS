<%@ Page Title="회원가입" Language="C#" MasterPageFile="~/LogoOne.Master" AutoEventWireup="true" CodeBehind="NomalSignUp.aspx.cs" Inherits="WebApplication1.Page_Basic.NomalSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/Scripts/jquery-3.3.1.min.js"></script> 
    <%-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script> "input[id$='btn_checkID']"   --%>
    <script type="text/javascript">
        $(document).ready(function(){
            $("input[id$='btnCheckID']").click(function () {
                var id = $("input[id$='txbUserID']").val();
                var new_id = JSON.stringify({id:id});
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "NomalSignUp.aspx/checkID", //이페이지에서 중복체크를 한다
                    dataType: "json",
                    data: new_id,//test.asp에 id 값을 보낸다                    
                    cache: false,
                    success: function (data) {
                        if (data.d == "아이디가 존재합니다.") {
                                $("input[id$='txbUserID']").val('');
                                $("#loadtext").html(data.d); //해당 내용을 보여준다
                            }
                            else {
                                $("#loadtext").html(data.d); //해당 내용을 보여준다
                            }
                        
                    },
                    error: function (request,status,error) {
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }
                });
                return false;
                });
        });
        </script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("input[id$='btnSignup']").click(function () {
                    <%--
                    var id = $("input[id$='txbUserID']").val();
                    var name = $("input[id$='txbUserName']").val();
                    var pwd = $("input[id$='txbPwd']").val();
                    var pwdRe = $("input[id$='txbPwdRe']").val();
                    var add = $("input[id$='txbAddress']").val();
                    var eMail = $("input[id$='txbEmail']").val();
                    var new_id = JSON.stringify({
                        id: id,
                        name: name,
                        pwd: pwd,
                        pwdRe: pwdRe,
                        add: add,
                    eMail: eMail});
                    var new_name = JSON.stringify({ name: name });
                    var new_pwd = JSON.stringify({ pwd: pwd });
                    var new_pwdRe = JSON.stringify({ pwdRe: pwdRe });
                    var new_addr = JSON.stringify({ add: add });
                    var new_eMail = JSON.stringify({ eMail: eMail });
                    var id = [$("input[id$='txbUserID']").val().toString(), $("input[id$='txbUserName']").val(), $("input[id$='txbPwd']").val(),
                        $("input[id$='txbPwdRe']").val(), $("input[id$='txbAddress']").val(), $("input[id$='txbEmail']").val()];--%>
                    
                    var user = {};
                    user.ID = $("input[id$='txbUserID']").val().toString();
                    user.Name = $("input[id$='txbUserName']").val().toString();
                    user.Pwd = $("input[id$='txbPwd']").val().toString();
                    user.PwdRe = $("input[id$='txbPwdRe']").val().toString();
                    user.Addr = $("input[id$='txbAddress']").val().toString();
                    user.Email = $("input[id$='txbEmail']").val().toString();
                    var userinfo = "{userInfo:" + JSON.stringify(user) + "}";

                    $.ajax({
                        type: "POST",
                        url: "NomalSignUp.aspx/SignUp_click", //이페이지에서 중복체크를 한다.
                        data: userinfo,
                        contentType: "application/json;",
                        dataType: "json",
                        cache: false,
                        success: function (data) {
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
                        error: function (request,status,error) {
                            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
                    });
                    return false;
                    });
                });
        </script>
    <%-- 
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
    </script>    --%>
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
                                    <asp:Button runat="server" ID="btnCheckID" Text="중복확인" CssClass="btn btn-default" Height="30" Width="100" />
                                    <br>
                                    <%-- <asp:RequiredFieldValidator ID="FieldValiUserID" runat="server" ControlToValidate="txbUserID" CssClass="text-danger" ErrorMessage="아이디는 필수 입력입니다." Display="Dynamic" ValidationGroup="Group1" />
                                    <asp:RegularExpressionValidator ID="ExpressionValidatorUserID" CssClass="text-danger" runat="server" ControlToValidate="txbUserID" ValidationExpression="^(([0-9])\w*|\w*([a-zA-Z]))*.{8,15}$" ErrorMessage="아이디는 8~15자리의 문자나 숫자로 이루어져야 합니다." Display="Dynamic"/>--%>
                                    <div id="loadtext" class="text-danger"></div>
                                </div>

                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    성명(실제) <asp:TextBox runat="server" ID="txbUserName" CssClass="form-control required" Text="" />
                                    <div id="loadname" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiUserName" runat="server" ControlToValidate="txbUserName" CssClass="text-danger" ErrorMessage="성명은 필수 입력입니다." Display="Dynamic" />--%>                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    비밀번호
                                    <asp:TextBox runat="server" ID="txbPwd" TextMode="Password" CssClass="form-control required" Text="" />
                                    <div id="loadpwd" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiPwd" runat="server" ControlToValidate="txbPwd" CssClass="text-danger" ErrorMessage="비밀번호는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    비밀번호 확인
                                    <asp:TextBox runat="server" ID="txbPwdRe" TextMode="Password" CssClass="form-control equalTo" Text="" />
                                    <div id="loadpwdRe" class="text-danger"></div>
                                    <%--<asp:CompareValidator ID="FieldValiPwdCompare" runat="server" CssClass="text-danger" ErrorMessage="비밀번호 확인을 다시 입력 해주세요." ControlToValidate="txbPwd" ControlToCompare="txbPwdRe" Display="Dynamic"  />--%>                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    주소
                                    <asp:TextBox runat="server" ID="txbAddress" CssClass="form-control required" Text="" />
                                    <div id="loadaddr" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiAdd" runat="server" ControlToValidate="txbAddress" CssClass="text-danger" ErrorMessage="주소는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div>
                                    이메일
                                    <asp:TextBox runat="server" ID="txbEmail" CssClass="form-control required" Text="" />
                                    <div id="loadEmail" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiEmail" runat="server" ControlToValidate="txbEmail" CssClass="text-danger" ErrorMessage="이메일는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="form-group">
                                <div class="text-center col-md-offset-2 col-md-10">
                                    <asp:Button runat="server" Text="확인" ID="btnSignup" CssClass="btn btn-default" Height="40" Width="140" />
                                    <%--<asp:Button runat="server" Text="확인" OnClick="SignUp_Click" CssClass="btn btn-default" Height="40" Width="140" />--%>
                                </div>                            
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </section>
            </div>
            <div class ="col-xs-4"></div>
        </div>
</asp:Content>
