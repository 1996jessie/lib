<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
updateArticleProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int anum = Integer.parseInt(request.getParameter("anum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

%>

<jsp:useBean id="ab" class = "article.ArticleBean">
	<jsp:setProperty name = "ab" property = "*"/>
</jsp:useBean>

<%
	ArticleDao adao = ArticleDao.getInstance();
	int cnt = adao.updateArticle(ab);
	
	String msg;
	String url;
	
	if(cnt > 0) {	
		msg = "update 성공";
		url = "articleList.jsp?pageNum="+pageNum;
	}else {
		msg = "update 실패";
		url = "updateArticle.jsp?anum="+anum+"&pageNum="+pageNum;
	}
%>
	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = '<%= url %>';
	</script> 