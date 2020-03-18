<%@ Page Title="회원가입" Language="C#" MasterPageFile="~/LogoOne.Master" AutoEventWireup="true" CodeBehind="NormalSignUp.aspx.cs" Inherits="WebApplication1.Page_Basic.NomalSignUp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>

    <script type="text/javascript">
        var checkId = false;
        $(document).ready(function(){
            $("input[id$='btnCheckID']").click(function () {
                var id = $("input[id$='txbUserID']").val();
                var new_id = JSON.stringify({ id: id });
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "NormalSignUp.aspx/checkID", //이페이지에서 중복체크를 한다
                    dataType: "JSON",
                    data: new_id,//test.asp에 id 값을 보낸다                    
                    cache: false,
                    success: function (data) {
                        if (data.d == "아이디 생성이 가능합니다.") {
                            checkId = true;
                            $("#loadtext").html(data.d);
                        }
                        else {
                            checkId = false;
                            $("input[id$='txbUserID']").val('');
                            $("#loadtext").html(data.d);
                        }                        
                    },
                    error: function (request,status,error) {
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }
                });
                return false;
                });
        });

        $(document).ready(function(){
            $("input[id$='btnSignup']").click(function () {                   
                var user = {};
                user.ID = $("input[id$='txbUserID']").val().toString();
                user.Name = $("input[id$='txbUserName']").val().toString();
                user.Pwd = $("input[id$='txbPwd']").val().toString();
                user.PwdRe = $("input[id$='txbPwdRe']").val().toString();
                user.Addr = $("input[id$='txbAddress']").val().toString();
                user.Email = $("input[id$='txbEmail']").val().toString();
                user.IDcheck = checkId.toString();
                var userinfo = "{userInfo:" + JSON.stringify(user) + "}";

                $.ajax({
                    type: "POST",
                    url: "NormalSignUp.aspx/SignUp_click", //이페이지에서 중복체크를 한다.
                    data: userinfo,
                    contentType: "application/json;",
                    dataType: "JSON",
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

    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                    // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                    var fullAddr = ''; // 최종 주소 변수
                    var extraAddr = ''; // 조합형 주소 변수
                    var dong = '';

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        fullAddr = data.jibunAddress;

                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        fullAddr = data.jibunAddress;

                    }

                    dong = data.bname;
                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                    if (data.userSelectedType === 'R') {
                        //법정동명이 있을 경우 추가한다.
                        if (data.bname !== '') {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if (data.buildingName !== '') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                        fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    // document.getElementById("ContentPlaceHolder1_WUC_BizCompanyReg_sample6_postcode").value = data.postcode; //6자리 우편번호 사용
                    //document.getElementById("sample6_postcode").value = data.zonecode; //5자리 기초구역번호 사용
                    //document.getElementById("txbAddress").value = fullAddr;
                    $("input[id$='txbAddress']").val(fullAddr);
                }
            }).open();
        }
        /*
        $("input[id$='btnOpenAddr']").click(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                    // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                }
            }).open();
            return false;
        });
        */
    </script>

    <h2><%: Title %>.</h2>
    <hr />
        <div class="row" id="div11">
            <div class ="col-xs-4"></div>
            <div class = "col-xs-4">
                <section id="loginForm">
                    <div class="form-horizontal">                    
                        <asp:PlaceHolder runat="server" ID="SignUpForm" >
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    아이디 <asp:TextBox runat="server" ID="txbUserID" CssClass="form-control" Text="" />
                                    <asp:Button runat="server" ID="btnCheckID" Text="중복확인" CssClass="btn btn-default" Height="30" Width="100" />
                                    <br>
                                    <%-- <asp:RequiredFieldValidator ID="FieldValiUserID" runat="server" ControlToValidate="txbUserID" CssClass="text-danger" ErrorMessage="아이디는 필수 입력입니다." Display="Dynamic" ValidationGroup="Group1" />
                                    <asp:RegularExpressionValidator ID="ExpressionValidatorUserID" CssClass="text-danger" runat="server" ControlToValidate="txbUserID" ValidationExpression="^(([0-9])\w*|\w*([a-zA-Z]))*.{8,15}$" ErrorMessage="아이디는 8~15자리의 문자나 숫자로 이루어져야 합니다." Display="Dynamic"/>--%>
                                    <div id="loadtext" class="text-danger"></div>
                                </div>

                            </div>
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    성명(실제) <asp:TextBox runat="server" ID="txbUserName" CssClass="form-control" Text="" />
                                    <div id="loadname" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiUserName" runat="server" ControlToValidate="txbUserName" CssClass="text-danger" ErrorMessage="성명은 필수 입력입니다." Display="Dynamic" />--%>                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    비밀번호
                                    <asp:TextBox runat="server" ID="txbPwd" TextMode="Password" CssClass="form-control" Text="" />
                                    <div id="loadpwd" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiPwd" runat="server" ControlToValidate="txbPwd" CssClass="text-danger" ErrorMessage="비밀번호는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    비밀번호 확인
                                    <asp:TextBox runat="server" ID="txbPwdRe" TextMode="Password" CssClass="form-control" Text="" />
                                    <div id="loadpwdRe" class="text-danger"></div>
                                    <%--<asp:CompareValidator ID="FieldValiPwdCompare" runat="server" CssClass="text-danger" ErrorMessage="비밀번호 확인을 다시 입력 해주세요." ControlToValidate="txbPwd" ControlToCompare="txbPwdRe" Display="Dynamic"  />--%>                                    
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    주소
                                    <asp:TextBox runat="server" ID="txbAddress" CssClass="form-control" Text="" TextMode="SingleLine" ReadOnly="True" />
                                    <input type="button" id="btnpost" onclick="sample6_execDaumPostcode();" class="btn btn-default" value="주소 찾기" style="height:30px;width:100px;">
                                    <%--<asp:Button runat="server" ID="btnOpenAddr" Text="우편찾기" CssClass="btn btn-default" Height="30" Width="100" />--%>
                                    <div id="loadaddr" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiAdd" runat="server" ControlToValidate="txbAddress" CssClass="text-danger" ErrorMessage="주소는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="">
                                <div>
                                    이메일
                                    <asp:TextBox runat="server" ID="txbEmail" CssClass="form-control" Text="" />
                                    <div id="loadEmail" class="text-danger"></div>
                                    <%--<asp:RequiredFieldValidator ID="FieldValiEmail" runat="server" ControlToValidate="txbEmail" CssClass="text-danger" ErrorMessage="이메일는 필수 입력입니다." Display="Dynamic" />--%>
                                </div>
                            </div>
                            <div style="margin-bottom: 10px" class="text-center">
                                <div class="col-md-10">
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
