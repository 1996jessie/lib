<%@page import="book.BookDao"%>
<%@page import="reserve.ReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cancelReservation.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int rmnum = Integer.parseInt(request.getParameter("rmnum"));
	String rbcode = request.getParameter("rbcode");
	
	System.out.println("<cancelReservation.jsp> rmnum : " + rmnum + ", rbcode : " + rbcode);

	ReserveDao rdao = ReserveDao.getInstance();
	
	int cnt = rdao.cancelReservation(rmnum, rbcode); 
	
	String msg;
	String url;
	
	if(cnt > 0) {
		msg = "예약을 취소했습니다.";
		url = "reserveList.jsp";
		int count = rdao.checkReserveCount(rbcode);  
		BookDao bdao = BookDao.getInstance();
		int cnt2 = bdao.countReservedBook(count, rbcode);    
		if(cnt2 > 0) {  
			System.out.println("예약 수 업데이트 성공");
		} else {
			System.out.println("예약 수 업데이트 실패");
		}
	} else {
		msg = "예약 취소 실패";
		url = "reserveList.jsp";
	}

%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 