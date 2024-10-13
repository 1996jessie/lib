<%@page import="reserve.ReserveDao"%>
<%@page import="book.BookDao"%>
<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
borrowReservedBook.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int rmnum = Integer.parseInt(request.getParameter("rmnum"));
	int rbnum = Integer.parseInt(request.getParameter("rbnum"));
	String rbcode = request.getParameter("rbcode");
	int rank = Integer.parseInt(request.getParameter("rank"));
	
	System.out.println("<borrowReservedBook.jsp> rmnum : " + rmnum + ", rbcode : " + rbcode + ", rank : " + rank);

	String msg;
	String url;
	if(rank != 1) {
		msg = "아직 순서 돌아오지 않았음";
		url = "../ReserveBook/reserveList.jsp";
	} else {
		BorrowDao brdao = BorrowDao.getInstance();
		boolean flag = brdao.isThisBookBorrowed(rbcode);
		if(flag == true) {
			msg = "아직 반납되지 않았음";
			url = "../ReserveBook/reserveList.jsp";
		} else {
			int count = brdao.canIBorrow(rmnum);
			if(count>=5) {
				msg = "대출 최대 도서 초과";
				url = "borrowList.jsp";
			} else {
				boolean flag2 = brdao.canIBorrowThisBook(rmnum, rbcode);
				if(flag2 == true) {
					msg = "이미 대출중인 도서입니다";
					url = "borrowList.jsp";
				} else {
					int cnt = brdao.borrowThisBook(rmnum, rbnum, rbcode);
					if(cnt > 0) {
						msg = "대출 성공";
						url = "borrowList.jsp";
						
						BookDao bdao = BookDao.getInstance();
						int cnt2 = bdao.lendBook(rbcode);  
						if(cnt2 > 0) {
							System.out.println("대출 수 증가 성공");
						} else {
							System.out.println("대출 수 증가 실패");
						}
						
						ReserveDao rdao = ReserveDao.getInstance();
						int count2 = rdao.checkReserveCount(rbcode);  
						
						int cnt3 = bdao.countReservedBook(count, rbcode);    
						if(cnt3 > 0) {  
							System.out.println("예약 수 업데이트 성공");
						} else {
							System.out.println("예약 수 업데이트 실패");
						}
						
						int cnt4 = rdao.cancelReservation(rmnum, rbcode);
						if(cnt4 > 0) {
							System.out.println("예약 명단에서 제거 성공");
						} else {
							System.out.println("예약 명단에서 제거 실패");
						}
						
					} else {
						msg = "대출 실패";
						url = "borrowList.jsp";
					}
				}
			}
		}
	}  
	
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 
