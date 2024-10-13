<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<style type="text/css">
    /* 폼 스타일 */
    .delete-member-form {
        width: 50%;
        margin: auto;
        border: 1px solid #ddd;
        padding: 20px;
    }
    .delete-member-form td {
        padding: 10px;
    }
    .delete-member-form select {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        margin-top: 6px;
        margin-bottom: 16px;
        resize: vertical;
    }
    .delete-member-form input[type="submit"],
    .delete-member-form input[type="button"] {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        padding: 10px 20px;
        text-decoration: none;
        margin-right: 10px;
    }
    .delete-member-form input[type="submit"]:hover,
    .delete-member-form input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>

<%
    int delnum = Integer.parseInt(request.getParameter("mnum"));
    System.out.println("<deleteMemberByAdmin.jsp> delnum : " + delnum);
%>
<form action="deleteMemberByAdminProc.jsp?mnum=<%= delnum %>" method="post" class="delete-member-form">
    <table border="1" align="center">
        <tr align="center">
            <td> 삭제하는 이유를 고르세요 </td>
        </tr>
        <tr align="center">
            <td>
                <select name="delReason">
                    <option value="폭언 및 욕설">폭언 및 욕설</option>
                    <option value="도서 연체 가능 수 초과">도서 연체 가능 수 초과</option>
                    <option value="장기간 미이용자">장기간 미이용자</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="center">
                <input type="submit" value="확인">
                <input type="button" value="돌아가기" onclick="history.back()">
            </td>
        </tr>
    </table>
</form>

<%@include file="../../bottom.jsp" %>
