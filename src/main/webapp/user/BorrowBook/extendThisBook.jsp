<%@page import="reserve.ReserveDao"%>
<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
extendThisBook.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int brmnum = Integer.parseInt(request.getParameter("brmnum"));
	String brbcode = request.getParameter("brbcode");

	System.out.println("<extendThisBook.jsp> brmnum : " + brmnum + ", brbcode : " + brbcode);
	BorrowDao brdao = BorrowDao.getInstance();
	boolean flag = brdao.canIExtendThisBook(brmnum, brbcode);
	
	String msg;
	String url;
	if(flag == true) {
		msg = "이미 2번 연장한 도서";
		url = "borrowList.jsp";
	} else {
		ReserveDao rdao = ReserveDao.getInstance();
		int rcount = rdao.canIReserveThis(brbcode);
		if(rcount >= 1) {
			msg = "예약자가 있는 도서는 연장할 수 없음";
			url = "borrowList.jsp";
		} else {
			int cnt = brdao.extendReturnDate(brmnum, brbcode);
			if(cnt > 0) {
				msg = "연장되었습니다";
				url = "borrowList.jsp";
			} else {
				msg = "연장 뭔가 잘못됨";
				url = "borrowList.jsp";
			}
		}
	}

%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 
	
	<%@include file = "../../bottom.jsp" %>