<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
returnThisBook.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	int brmnum = Integer.parseInt(request.getParameter("brmnum"));
	String brbcode = request.getParameter("brbcode");

	System.out.println("<returnThisBook.jsp> brmnum : " + brmnum + ", brbcode : " + brbcode);
	
	BorrowDao brdao = BorrowDao.getInstance();
	int cnt = brdao.returnThisBook(brmnum, brbcode);
	
	String msg;
	String url;
	
	if(cnt > 0) {
		msg = "반납되었습니다";
		url = "borrowList.jsp";
	} else {
		msg = "반납 뭔가 잘못되었다.....";
		url = "borrowList.jsp";
	}
	
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 