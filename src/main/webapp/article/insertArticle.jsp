<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>

<style type="text/css">
    /* 폼 스타일 */
    .article-form {
        width: 60%;
        margin: auto;
        padding: 20px;
        border: 1px solid;
    }
    .article-form input[type="text"],
    .article-form textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .article-form input[type="radio"] {
        margin-right: 10px;
    }
    .article-form input[type="submit"],
    .article-form input[type="reset"],
    .article-form input[type="button"] {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        padding: 10px 20px;
        text-decoration: none;
        margin-right: 10px;
    }
    .article-form input[type="submit"]:hover,
    .article-form input[type="reset"]:hover,
    .article-form input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>

<%
    String msg;    
    String url;
    
    Date nowDate = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    if(mname == null) {
        msg = "로그인 먼저 하세요";
        url = "../login/login.jsp";
%>  <script type="text/javascript">
        alert("<%= msg %>");
        location.href = "<%= url %>"
    </script>
<%  } else {
%>
<form action="insertArticleProc.jsp" method="post" class="article-form">
    <table align="center">
        <tr>
            <td>작성일</td>
            <td><%= sdf.format(nowDate) %>
            <input type="hidden" name="adate" value="<%= sdf.format(nowDate) %>">
            </td>
        </tr>
        <tr>
            <td>작성자</td>
            <td><%= mname %>
            <input type="hidden" name="aname" value="<%= mname %>">
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td><input type="text" name="atitle"></td>
        </tr>
        <tr>
            <td>비밀글 여부</td>
            <td>
                <label><input type="radio" name="checkPrivacy" value="YES"> 공개</label>
                <label><input type="radio" name="checkPrivacy" value="NO"> 비공개</label>
            </td>
        </tr>
        <tr>
            <td colspan="2">글 내용</td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea rows="10" cols="50" name="acontent"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="제출하기">
                <input type="reset" value="취소">
                <input type="button" value="돌아가기" onclick="location.href='articleList.jsp'">
            </td> 
        </tr>
    </table>
</form>
<% } %>

<%@include file="../../bottom.jsp" %>
