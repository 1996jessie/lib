<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
insertArticleProc.jsp<br>


<%
	request.setCharacterEncoding("UTF-8");

	ArticleDao adao = ArticleDao.getInstance();
	
	
	String aname = request.getParameter("aname");
	System.out.println(aname);
	String atitle = request.getParameter("atitle");
	System.out.println(atitle);
	String checkPrivacy = request.getParameter("checkPrivacy");
	System.out.println(checkPrivacy);
	String adate = request.getParameter("adate");
	System.out.println(adate);
	String acontent = request.getParameter("acontent");
	System.out.println(acontent);

	int cnt = adao.insertArticle(aname, atitle, adate, checkPrivacy, acontent);    
	
	String msg;	
	String url;
	
	if(cnt > 0) {
		msg = "insert 성공";
		url = "articleList.jsp";
	} else {
		msg = "insert 실패";
		url = "articleList.jsp";
	}

%>
	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script>

