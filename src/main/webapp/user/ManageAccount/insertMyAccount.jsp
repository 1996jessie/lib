<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
    <%@include file = "../../top.jsp" %>
    <script type="text/javascript">
    $(document).ready(function() {
        var use;
        var idCheck = false;
        var passwordSame = false;
        $('#idDuplicate').click(function(){
            idCheck = true;
            $.ajax({
                url : "insertIdCheck.jsp",
                data : {
                    id : $('input[name = id]').val(),
                },
                success: function(data) {
                    if($('input[name = id]').val() == "") {
                        use = "no id";
                    } else if($.trim(data) == "exist") {
                        use = "cannot insert"
                    } else if($.trim(data) == "not exist") {
                        use = "can insert";
                    }
                    alert("use : " + use);
                }
            });
        });
        
        $('input[name = id]').keydown(function(){
            idCheck = false;
            use = "";            
        });
        
        $('input[type = submit]').click(function(){
            var idPattern = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;
            var passwordPattern = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{8,20}$/;
            var id = $('input[name = id]').val();
            var password = $('input[name = password]').val();
            var repassword = $('input[name = repassword]').val();
            var email1 = $('input[name = email1]').val();
            var email2 = $('select[name = email2]').val();
            var phone1 = $('select[name = phone1]').val();
            var phone2 = $('input[name = phone2]').val();
            var phone3 = $('input[name = phone3]').val();
            var address1 = $('input[name = address1]').val();
            var address2 = $('input[name = address2]').val();
            
            if(idCheck == false) {
                alert("중복 체크 먼저 하세요");
                return false;
            } else if (!idPattern.test(id)) {
                alert("아이디는 영어 소문자와 숫자를 함께 사용하여 6~12글자로 입력해야 합니다.");
                $('input[name = id]').select();
                return false;
            } else if(use == "cannot insert") {
                alert("이미 있는 아이디입니다.");
                $('input[name = id]').select();
                return false;
            } else if(id == "") {
                alert("아이디 누락");
                $('input[name = id]').focus();
                return false;
            } else if(password == "") {
                alert("비밀번호 누락");
                $('input[name = password]').focus();
                return false;
            } else if(!passwordPattern.test(password)) {
                alert("비밀번호는 영어 소문자와 숫자를 함께 사용하여 8~20글자로 입력해야 합니다.");
                $('input[name = password]').select();
                return false;
            } else if(repassword == "") {
                alert("비밀번호 확인 누락");
                $('input[name = repassword]').focus();
                return false;
            } else if(password !== repassword) {
                alert("비밀번호가 일치하지 않습니다.");
                $('input[name = repassword]').select();
                return false;
            } else if(email1 == "") {
                alert("이메일1 누락");
                $('input[name = email1]').focus();
                return false;
            } else if(email2 == "") {
                alert("이메일2 누락");
                return false;
            } else if(email2 == "선택") {
                alert("이메일2를 선택하세요");
                return false;
            } else if(phone1 == "선택") {
                alert("전화번호1 누락");
                return false;
            } else if(phone2 == "") {
                alert("전화번호2 누락");
                $('input[name = phone2]').focus();
                return false;
            } else if(phone3 == "") {
                alert("전화번호3 누락");
                $('input[name = phone3]').focus();
                return false;
            } else if(address1 == "") {
                alert("주소1 누락");
                $('input[name = address1]').focus();
                return false;
            } else if(address2 == "") {
                alert("주소2 누락");
                $('input[name = address2]').focus();
                return false;
            } else if(phone2.length !== 4 || isNaN(phone2)) {
                alert("전화번호2는 4자리 숫자여야 합니다.");
                $('input[name = phone2]').select();
                return false;
            } else if(phone3.length !== 4 || isNaN(phone3)) {
                alert("전화번호3는 4자리 숫자여야 합니다.");
                $('input[name = phone3]').select();
                return false;
            } 
        });
        
        $("input[name = password]").keyup(function(){
            showPwmessage();
        });
        
        $("input[name = repassword]").keyup(function(){
            showPwmessage();
        });

        function showPwmessage() {
            var password = $('input[name = password]').val();
            var repassword = $('input[name = repassword]').val();
            if(password !== repassword) {
                $('#pwmessage').html("비밀번호 불일치").css('color','red');
                passwordSame = false;
            } else {
                $('#pwmessage').html("<font color=blue>비밀번호 일치</font>");
                passwordSame = true;
            }
        }
        
        $("select[name = email2]").change(function(){
            if($(this).val() == "직접 입력") {
                $('input[name = email3]').prop('disabled', false);
            } else {
                $('input[name = email3]').prop('disabled', true).val('');
            }
        });
    });
    </script>
     <style type="text/css">
        /* 테이블 스타일 */
        .signup-table {
            border-collapse: collapse;
            width: 50%;
            margin: auto; /* 테이블 가운데 정렬 */
        }
        .signup-table th, .signup-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .signup-table input[type="text"], .signup-table input[type="password"] {
            padding: 8px;
            width: 95%; /* 입력 필드가 한 줄에 나오도록 조정 */
            box-sizing: border-box; /* 입력 필드의 내부 패딩까지 포함하여 너비 설정 */
        }
        .signup-table input[type="submit"], .signup-table input[type="reset"], .signup-table input[type="button"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .signup-table input[type="submit"] {
            background-color: #007bff; /* 파란색 */
            color: white;
        }
        .signup-table input[type="reset"] {
            background-color: #6c757d; /* 회색 */
            color: white;
        }
        .signup-table input[type="button"] {
            background-color: #28a745; /* 초록색 */
            color: white;
        }
        .signup-table input[type="submit"]:hover {
            background-color: #0056b3; /* 파란색 어둡게 */
        }
        .signup-table input[type="reset"]:hover {
            background-color: #495057; /* 회색 어둡게 */
        }
        .signup-table input[type="button"]:hover {
            background-color: #218838; /* 초록색 어둡게 */
        }
        /* 메시지 스타일 */
        #pwmessage {
            font-size: 14px;
        }
        /* 전화번호 칸 너비 설정 */
        .signup-table input[type="text"].phone-input {
            width: 30%;
        }
    </style>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String mname2 = request.getParameter("mname");
    String rrn1 = request.getParameter("rrn1");
    String rrn2 = request.getParameter("rrn2");
    String[] email2 = {"선택", "naver.com", "daum.net", "google.com", "직접 입력"};
    String[] phone1 = {"선택", "010", "011", "016", "017"};
    int i;
%>

<form action="insertMyAccountProc.jsp" method="post">
    <table class="signup-table">
        <tr>
            <td>이름</td>
            <td>
                <input type="text" value="<%= mname2 %>" disabled>
                <input type="hidden" name="mname" value="<%= mname2 %>">
                <input type="hidden" name="rrn1" value="<%= rrn1 %>">
                <input type="hidden" name="rrn2" value="<%= rrn2 %>">
            </td>
        </tr>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" name="id" class="signup-input">
                <input type="button" id="idDuplicate" value="중복 확인" class="signup-button">
                <span class="signup-info">'영소문자'와 '숫자'로 이루어진 6~12자 이내</span>
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" name="password" class="signup-input">
                <span class="signup-info">'영소문자'와 '숫자'로 이루어진 8~20자 이내</span>
            </td>
            
        </tr>
        <tr>
            <td>비밀번호 확인</td>
            <td>
                <input type="password" name="repassword" class="signup-input">
                <span id="pwmessage"></span>
            </td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="text" name="email1" class="signup-input">@
                <select name="email2" class="signup-input">
                    <% for(i=0;i<email2.length;i++) { %>
                        <option value="<%= email2[i] %>"> <%= email2[i] %>
                    <% } %>
                </select>
                <input type="text" name="email3" class="signup-input" disabled>
            </td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>
                <select name="phone1" class="signup-input">
                    <% for(i=0;i<phone1.length;i++) { %>
                        <option value="<%= phone1[i] %>"> <%= phone1[i] %>
                    <% } %>
                </select>-
                <input type="text" name="phone2" class="signup-input phone-input">-
                <input type="text" name="phone3" class="signup-input phone-input">
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td>
                <input type="text" name="address1" class="signup-input">
                <input type="text" name="address2" class="signup-input">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="가입하기" class="signup-button">
                <input type="reset" value="취소" class="signup-button">
                <input type="button" value="돌아가기" class="signup-button">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
<%@include file = "../../bottom.jsp" %>
