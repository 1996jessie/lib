<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../../top.jsp" %>

<style>
/* 삭제 양식 테이블 스타일 */
.delete-form-table {
    border: 1px solid #ddd;
    width: 50%;
    margin: auto;
    margin-top: 20px;
    border-collapse: collapse;
}

.delete-form-table th,
.delete-form-table td {
    border: 1px solid #ddd;
    padding: 10px;
}

.delete-form-table th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}

.delete-form-table td {
    text-align: center;
}

.delete-form-table select {
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 3px;
}

.delete-form-table input[type="password"] {
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 3px;
}

.delete-form-table input[type="submit"],
.delete-form-table input[type="button"] {
    padding: 8px 20px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.delete-form-table input[type="submit"]:hover,
.delete-form-table input[type="button"]:hover {
    background-color: #f2f2f2;
}

</style>
<%	
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

<form action = "deleteMyAccountProc.jsp?mnum=<%= mnum %>" method = "post">
    <table class="delete-form-table" align="center">
        <tr align="center">
            <td> 탈퇴 사유를 선택하세요 </td>
        </tr>
        <tr>
            <td align="center">
                <select name="delReason">
                    <option value="너무 멀어서">너무 멀어서</option>
                    <option value="원하는 책이 없어서">원하는 책이 없어서</option>
                    <option value="서비스 불만족">서비스 불만족</option>
                </select>
            </td>
        </tr>
        
        <tr>
            <td align="center">비밀번호를 입력하세요</td>
        </tr>
        <tr>
            <td align="center"><input type="password" name="password"></td>
        </tr>
        <tr>
            <td align="center">
                <input type="submit" value="탈퇴하기">
                <input type="button" value="돌아가기">
            </td>
        </tr>
    </table>
</form>
<%  } %>