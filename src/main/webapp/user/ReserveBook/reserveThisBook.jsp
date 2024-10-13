<%@page import="borrow.BorrowDao"%>
<%@page import="book.BookDao"%>
<%@page import="reserve.ReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file = "../../top.jsp" %>
reserveThisBook.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	String bcode = request.getParameter("bcode");
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	System.out.println("<reserveThisBook.jsp> bnum : " + bnum);
	System.out.println("<reserveThisBook.jsp> bcode : " + bcode);
	System.out.println("<reserveThisBook.jsp> mnum : " + mnum);

	String msg;
	String url;
	if(mnum == -1) {
		msg = "로그인 후 이용하세요";
		url = "/login/login.jsp";
	} else {
		ReserveDao rdao = ReserveDao.getInstance();  	
		int mycount = rdao.canIReserve(mnum); 
		if(mycount >= 3) {
			msg = "최대 예약 권수를 초과해서 예약할 수 없습니다.";
			url = "/user/BorrowBook/borrowList.jsp";
		} else {
			BorrowDao brdao = BorrowDao.getInstance();
			
			boolean flag = brdao.isThisBookBorrowed(bcode);
			if(flag == false) {
				msg = "서가에 있는 도서는 예약할 수 없습니다.";
				url = "/user/SearchBook/searchBookAll.jsp";
			} else {
				boolean flag2 = brdao.canIBorrowThisBook(mnum, bcode);
				if(flag2 == true) {
					msg = "이미 본인이 대출중인 도서는 예약할 수 없습니다.";
					url = "/user/SearchBook/searchBookAll.jsp";
				} else {
					int bookcount = rdao.canIReserveThis(bcode);
					if(bookcount>=3) {
						msg = "예약 최대 인원수를 초과했습니다.";
						url = "/user/SearchBook/searchBookAll.jsp";
					} else {
						boolean flag3 = rdao.canIReserveThisBook(mnum, bcode);
						if(flag3 == true) {
							msg = "이미 예약 중인 도서입니다.";
							url = "/user/ReserveBook/reserveList.jsp";
						} else {
							int cnt = rdao.reserveThisBook(mnum, bnum, bcode);    
							if(cnt > 0) {
								msg = "예약되었습니다.";
								url = "/user/ReserveBook/reserveList.jsp";  
								BookDao bdao = BookDao.getInstance();
								System.out.println("<reserveThisBook.jsp> bcode : " + bcode);
								int count = rdao.checkReserveCount(bcode);  
								System.out.println("<reserveThisBook.jsp> 총 예약인원 count : " + count);
								int cnt2 = bdao.countReservedBook(count, bcode);  
								if(cnt2 > 0) {  
									System.out.println("예약 수 업데이트 성공");
								} else {
									System.out.println("예약 수 업데이트 실패");
								}
							} else {
								msg = "예약 뭔가 잘못됨";
								url = "/user/SearchBook/searchBookAll.jsp";
							}	
						}
					}
				}
			}
		}
	}
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= request.getContextPath() + url %>"
	</script> 
	
<%@include file = "../../bottom.jsp" %>


