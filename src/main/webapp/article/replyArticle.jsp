<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<style type="text/css">
    /* 폼 스타일 */
    .reply-form {
        width: 60%;
        margin: auto;
        padding: 20px;
        border: 1px solid;
    }
    .reply-form table {
        width: 100%;
        border-collapse: collapse;
    }
    .reply-form td {
        padding: 10px;
    }
    .reply-form input[type="text"],
    .reply-form textarea {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .reply-form input[type="submit"],
    .reply-form input[type="reset"],
    .reply-form input[type="button"] {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        padding: 10px 20px;
        text-decoration: none;
        margin-right: 10px;
    }
    .reply-form input[type="submit"]:hover,
    .reply-form input[type="reset"]:hover,
    .reply-form input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>

<%
    request.setCharacterEncoding("UTF-8");
    int anum = Integer.parseInt(request.getParameter("anum"));
    int aref = Integer.parseInt(request.getParameter("aref"));
    int astep = Integer.parseInt(request.getParameter("astep"));
    int alevel = Integer.parseInt(request.getParameter("alevel"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    String checkPrivacy = request.getParameter("checkPrivacy");
%>

<form action="replyArticleProc.jsp?pageNum=<%= pageNum %>" method="post" class="reply-form">
    <table>
        <tr>
            <td colspan="2" align="right" onclick="location.href = 'articleList.jsp'">글목록</td>
        </tr>
        <tr>
            <td width="150" align="center">이름</td>
            <td>
                <%= mname %>
                <input type="hidden" name="aname" maxlength="10" value="<%= mname %>">
            </td>
        </tr>
        <tr>
            <td width="150" align="center">제목</td>
            <td><input type="text" name="atitle" value="[답글]"></td>
        </tr>
        <tr>
            <td width="150" align="center">내 용</td>
            <td>
                <textarea name="acontent" rows="10" cols="50"></textarea>
                <input type="hidden" name="anum" value="<%= anum %>">
                <input type="hidden" name="aref" value="<%= aref %>">
                <input type="hidden" name="astep" value="<%= astep %>">
                <input type="hidden" name="alevel" value="<%= alevel %>">
                <input type="hidden" name="checkPrivacy" value="<%= checkPrivacy %>">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="답글쓰기">
                <input type="reset" value="다시작성">
                <input type="button" value="목록보기" onclick="location.href = 'articleList.jsp?pageNum=<%= pageNum %>'">
            </td>
        </tr>
    </table>
</form>

<%@include file="../../bottom.jsp" %>
