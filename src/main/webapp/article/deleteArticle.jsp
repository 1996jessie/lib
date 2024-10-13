<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteArticle.jsp<br>
<%@include file="../../top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	int anum = Integer.parseInt(request.getParameter("anum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String aname = request.getParameter("aname");
	
	System.out.println("<deleteArticle.jsp> anum : " + anum + ", pageNum : " + pageNum + ", aname : " + aname);
	
	ArticleDao adao = ArticleDao.getInstance();
	int count = adao.getArticleCount();
	int pageSize = 10;
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	
	String msg = null;
	String url = null;
	
	boolean flag = adao.canIDeleteThisArticle(anum);
	
	if(mname.equals("관리자")) {
		//관리자는 무조건 삭제 가능
		int cnt = adao.deleteArticle(anum);
		if(cnt > 0) {
			msg = "delete 성공";
			if(pageCount < pageNum) {
				pageNum = pageCount;
			}
			url = "articleList.jsp?pageNum=" + pageNum;			
		} else {
			msg = "delete 실패";
			url = "showArticle.jsp?anum=" + anum + "&pageNum=" + pageNum;
		}
		
	} else if(aname.equals(mname)) {
		//내 글
		if(flag == true) {
			//답글 아직 안 달렸음
			int cnt = adao.deleteArticle(anum);
			if(cnt > 0) {
				msg = "delete 성공";
				if(pageCount < pageNum) {
					pageNum = pageCount;
				}
				url = "articleList.jsp?pageNum=" + pageNum;			
			} else {
				msg = "delete 실패";
				url = "showArticle.jsp?anum=" + anum + "&pageNum=" + pageNum;
			}
		} else {
			//답글 달려서 삭제 못함
			msg = "이미 답글이 달린 게시글은 삭제할 수 없습니다.";
			url = "showArticle.jsp?anum=" + anum + "&pageNum=" + pageNum;
		}
	} else {
		//내 글 아님
		msg = "삭제 권한이 없습니다.";
		url = "showArticle.jsp?anum=" + anum + "&pageNum=" + pageNum;
	}
	
	
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = '<%= url %>';
	</script> 