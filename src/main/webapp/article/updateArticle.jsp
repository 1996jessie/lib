<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="article.ArticleBean"%>
<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<style type="text/css">
    /* 폼 스타일 */
    .update-form {
        width: 60%;
        margin: auto;
        padding: 20px;
        border: 1px solid;
    }
    .update-form input[type="text"],
    .update-form textarea {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    .update-form input[type="radio"] {
        margin-right: 10px;
    }
    .update-form input[type="submit"],
    .update-form input[type="reset"],
    .update-form input[type="button"] {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        padding: 10px 20px;
        text-decoration: none;
        margin-right: 10px;
    }
    .update-form input[type="submit"]:hover,
    .update-form input[type="reset"]:hover,
    .update-form input[type="button"]:hover {
        background-color: #0056b3;
    }
</style>

<%
    int anum = Integer.parseInt(request.getParameter("anum"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));

    ArticleDao adao = ArticleDao.getInstance();
    ArticleBean ab = adao.getThisArticle(anum);
    
    Date nowDate = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    if(ab.getAname().equals(mname)) {
%>
    <form action="updateArticleProc.jsp?anum=<%= anum %>&pageNum=<%= pageNum %>" method="post" class="update-form">
    <table align="center">
        <tr>
            <td>수정일</td>
            <td><%= sdf.format(nowDate) %>
            <input type="hidden" name="adate" value="<%= sdf.format(nowDate) %>"></td>
        </tr>
        <tr>
            <td>작성자</td>
            <td><%= mname %>
            <input type="hidden" name="aname" value="<%= mname %>">
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td><input type="text" name="atitle" value="<%= ab.getAtitle() %>"></td>
        </tr>
        <tr>
            <td>비밀글 여부</td>
            <td>
                <label><input type="radio" name="checkPrivacy" value="YES" <%= (ab.getCheckPrivacy().equals("YES")) ? "checked" : "" %>> 공개</label>
                <label><input type="radio" name="checkPrivacy" value="NO" <%= (ab.getCheckPrivacy().equals("NO")) ? "checked" : "" %>> 비공개</label>
            </td>
        </tr>
        <tr>
            <td colspan="2">글 내용</td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea rows="10" name="acontent"><%= ab.getAcontent() %></textarea>
                <input type="hidden" name="aref" value="<%= ab.getAref() %>">
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

        
<%  } else {
        String msg = "수정은 본인만 할 수 있습니다.";
        String url = "showArticle.jsp?anum="+anum+"&pageNum="+pageNum;
%>
    <script type="text/javascript">
        alert("<%= msg %>");
        location.href = '<%= url %>';
    </script> 

<%       
    }   
%>
<%@include file="../../bottom.jsp" %>
