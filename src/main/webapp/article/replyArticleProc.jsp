<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
replyArticleProc.jsp<br>


<%
	request.setCharacterEncoding("UTF-8");
	
	int aref = Integer.parseInt(request.getParameter("aref"));
	int astep = Integer.parseInt(request.getParameter("astep"));
	int alevel = Integer.parseInt(request.getParameter("alevel"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String checkPrivacy = request.getParameter("checkPrivacy");

	System.out.println("<replyArticle.jsp> aref : " + aref + ", astep : " + astep + ", alevel : " + ", pageNum : " + pageNum + ", checkPrivacy : " + checkPrivacy);
%>

<jsp:useBean id = "ab" class = "article.ArticleBean">
	<jsp:setProperty name = "ab" property="*"/>
</jsp:useBean>

<%
	ArticleDao adao = ArticleDao.getInstance();
	int cnt = adao.replyArticle(ab);

	String msg;
	String url;
	if(cnt > 0) {
		msg = "답글 쓰기 성공";
		url = "articleList.jsp";
	} else {
		msg = "답글 쓰기 실패";
		url = "replyArticle.jsp?anum="+ab.getAnum()+"&aref="+aref+"&astep="+astep+"&alevel="+alevel+"&pageNum="+pageNum+"&checkPrivacy="+checkPrivacy;
	}
%>

<jsp:forward page="articleList.jsp?pageNum=<%= pageNum %>"/>