<%@page import="book.BookDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
admin-ManageBook-insertBookProc.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String uploadDir = config.getServletContext().getRealPath("admin/ManageBook/bookImage");
	MultipartRequest mr = null;

	mr = new MultipartRequest(request, uploadDir, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
	
	String scategory = mr.getParameter("scategory");
	System.out.println("scategory : " + scategory);
	
	String opimage = mr.getOriginalFileName("bimage");
	String requestDir = request.getContextPath()+"admin/ManageBook/bookImage";
	requestDir = requestDir + "/" + opimage;

	BookDao bdao = BookDao.getInstance();
	int cnt = bdao.insertBook(mr);
	
	String msg;
	String url;
	if(cnt > 0) {
		int cnt2 = bdao.makeBcode(mr);
		if(cnt2 > 0) {
			msg = "insert 성공";
			url = "showBook.jsp";
		}else {
			msg = "코드 못만들었다";
			url = "showBook.jsp";
		}
	} else {
		msg = "insert 실패";
		url = "insertBook.jsp";
	}
	
%>
	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 
