<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

deleteBookByBpubyear.jsp<br>


<%
	request.setCharacterEncoding("UTF-8");
	String checkThis[] = request.getParameterValues("checkThis");
	
	for(int i=0;i<checkThis.length;i++) {
		System.out.println("<deleteBookByBpubyear.jsp> checkThis[i]: " + checkThis[i]);
	}

	BookDao bdao = BookDao.getInstance();
	
	int cnt = bdao.deleteCheckedBook(checkThis);  
	
	String msg;
	String url;
	if(cnt > 0) {
		msg = "해당 도서 삭제 성공";
		url = "showBookByBpubyear.jsp";
	} else {
		msg = "해당 도서 삭제 실패";
		url = "showBookByBpubyear.jsp";
	}
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = '<%= url %>';
	</script> 
