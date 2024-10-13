<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp" %>       

<style>
/* 입력 양식 테이블 스타일 */
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

.update-form-table input[type="password"] {
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 3px;
}

.update-form-table input[type="submit"],
.update-form-table input[type="button"] {
    padding: 8px 20px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.update-form-table input[type="submit"]:hover,
.update-form-table input[type="button"]:hover {
    background-color: #f2f2f2;
}

</style>
<%

	request.setCharacterEncoding("UTF-8");

String msg2;	
String url2;



if(mname == null) {
	msg2 = "로그인 먼저 하세요";
	url2 = request.getContextPath()+"/login/login.jsp";
%>	<script type="text/javascript">
	alert("<%= msg2 %>");
	location.href = "<%= url2 %>"
</script>
<%	} else {
%>

<form action="updateMyAccountForm.jsp" method="post">
    <table class="update-form-table">
        <tr align="center">
            <th>비밀번호를 입력하세요</th>
        </tr>
        <tr>
            <td align="center">
                <input type="password" name="password2">
            </td>
        </tr>
        <tr>
            <td align="center">
                <input type="submit" value="수정">
                <input type="button" value="돌아가기">
            </td>
        </tr>
    </table>
</form>
<%  } %>
<%@ include file="../../bottom.jsp" %>    
