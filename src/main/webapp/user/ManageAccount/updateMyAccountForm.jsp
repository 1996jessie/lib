<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp" %>    

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        //alert('1');
        
        $("input[name=newPassword]").keyup(function(){
            var newPassword = $(this).val();
            //alert("newPassword");
            showNewPwmessage();
        });
        
        $("input[name=reNewPassword]").keyup(function(){
            var reNewPassword = $(this).val();
            //alert("reNewPassword");
            showNewPwmessage();
        });

        function showNewPwmessage() {
            var newPassword = $("input[name=newPassword]").val();
            var reNewPassword = $("input[name=reNewPassword]").val();
            
            if (newPassword !== reNewPassword) {
                $('#newpwmessage').html("새 비밀번호 불일치").css('color', 'red');
            } else {
                $('#newpwmessage').html("<font color='blue'>새 비밀번호 일치</font>");
            }
        }

        $('input[type=submit]').click(function(){
            var newPassword = $('input[name=newPassword]').val();
            var reNewPassword = $('input[name=reNewPassword]').val();
            var newPasswordPattern = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{8,20}$/;
            
            if (newPassword !== "") {
                if (!newPasswordPattern.test(newPassword)) {
                    alert("새 비밀번호는 영어 소문자와 숫자를 함께 사용하여 8~20글자로 입력해야 합니다.");
                    $('input[name=newPassword]').select();
                    return false;
                } else if (newPassword !== reNewPassword) {
                    alert("새 비밀번호가 일치하지 않습니다.");
                    $('input[name=reNewPassword]').select();
                    return false;
                }
            }
        });
    });
</script>

<style>
/* 양식 테이블 스타일 */
.update-form-table {
    border: 1px solid #ddd;
    width: 50%;
    margin: auto;
    margin-top: 20px;
    border-collapse: collapse;
}

.update-form-table th,
.update-form-table td {
    border: 1px solid #ddd;
    padding: 10px;
}

.update-form-table th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}

.update-form-table td {
    text-align: center;
}

.update-form-table input[type="text"],
.update-form-table input[type="password"],
.update-form-table select {
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 3px;
}

.update-form-table span {
    font-size: 0.8em;
    color: #777;
}

.update-form-table input[type="submit"],
.update-form-table input[type="reset"],
.update-form-table input[type="button"] {
    padding: 8px 20px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.update-form-table input[type="submit"]:hover,
.update-form-table input[type="reset"]:hover,
.update-form-table input[type="button"]:hover {
    background-color: #f2f2f2;
}

</style>

<%
    request.setCharacterEncoding("UTF-8");
    String password2 = request.getParameter("password2");
    
    System.out.println("<updateAccountForm.jsp> id : " + id + ", password2 : " + password2);

    MemberBean mb = mdao.memberCheck(id, password2);
    
    String[] email2 = {"선택", "naver.com", "daum.net", "google.com", "직접 입력"};
    String[] phone1 = {"선택", "010", "011", "016", "017"};
    int i;
%>

<form action="updateMyAccountProc.jsp" method="post">
    <table class="update-form-table">
        <tr>
            <td>이름</td>
            <td>
                <input type="text" value="<%= mb.getMname() %>" disabled>
                <input type="hidden" name="mname" value="<%= mb.getMname() %>">
                <input type="hidden" name="rrn1" value="<%= mb.getRrn1() %>">
                <input type="hidden" name="rrn2" value="<%= mb.getRrn2() %>">
            </td>
        </tr>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" value="<%= mb.getId() %>" disabled>
                <input type="hidden" name="id" value="<%= mb.getId() %>">
            </td>
        </tr>
        
        <tr>
            <td>현재 비밀번호</td>
            <td>
                <input type="password" name="password" value="<%= mb.getPassword() %>" disabled>
                <input type="hidden" name="oldPassword" value="<%= mb.getPassword() %>">
            </td>
        </tr>
        <tr>
            <td>새 비밀번호</td>
            <td>
                <input type="password" name="newPassword"><br>
                <span>'영소문자'와 '숫자'로 이루어진 8~20자 이내</span>
            </td>
        </tr>
        <tr>
            <td>새 비밀번호 확인</td>
            <td>
                <input type="password" name="reNewPassword">
                <span id="newpwmessage"></span>
            </td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="text" name="email1" value="<%= mb.getEmail1() %>">@
                <select name="email2">
                    <% for(i=0; i<email2.length; i++) { %>
                        <option value="<%= email2[i] %>" <%= mb.getEmail2().equals(email2[i]) ? "selected" : "" %>><%= email2[i] %></option>
                    <% } %>
                </select>
            </td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>
                <select name="phone1">
                    <% for(i=0; i<phone1.length; i++) { %>
                        <option value="<%= phone1[i] %>" <%= mb.getPhone1().equals(phone1[i]) ? "selected" : "" %>><%= phone1[i] %></option>
                    <% } %>
                </select>-
                <input type="text" name="phone2" value="<%= mb.getPhone2() %>">-
                <input type="text" name="phone3" value="<%= mb.getPhone3() %>">
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td>
                <input type="text" name="address1" value="<%= mb.getAddress1() %>">
                <input type="text" name="address2" value="<%= mb.getAddress2() %>">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="수정하기">
                <input type="reset" value="취소">
                <input type="button" value="돌아가기">
            </td>
        </tr>
    </table>
</form>
<%@ include file="../../bottom.jsp" %>
