
<%@page import="book.BookDao"%>
<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../../top.jsp" %>
borrowThisBook.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	String bcode = request.getParameter("bcode");
	System.out.println("<borrowThisBook.jsp> mnum : " + mnum);
	System.out.println("<borrowThisBook.jsp> bnum : " + bnum);
	System.out.println("<borrowThisBook.jsp> bcode : " + bcode);
	
	String msg;
	String url;
	if(mnum == -1) {
		msg = "로그인 후 이용하세요";
		url = "/login/login.jsp";
	} else {
		BorrowDao brdao = BorrowDao.getInstance();
		int count = brdao.canIBorrow(mnum); 
		if(count >= 5) {
			msg = "최대 대출 권수를 초과해서 대출할 수 없습니다.";
			url = "/user/BorrowBook/borrowList.jsp";
		} else {
			boolean flag = brdao.canIBorrowThisBook(mnum, bcode);
			if(flag == true) {
				msg = "이미 내가 대출중인 도서입니다";
				url = "/user/SearchBook/searchBookAll.jsp";
			} else {
				boolean flag2 = brdao.isThisBookBorrowed(bcode);
				if(flag2 == true) {
					msg = "이미 대출중인 도서입니다.";
					url = "/user/SearchBook/searchBookAll.jsp";
				} else {
					int cnt = brdao.borrowThisBook(mnum, bnum, bcode); 
					if(cnt > 0) {
						msg = "대출되었습니다.";
						url = "/user/BorrowBook/borrowList.jsp";
						
						BookDao bdao = BookDao.getInstance();
						int cnt2 = bdao.lendBook(bcode);
						if(cnt2 > 0) {
							System.out.println("대출 수 증가 성공");
						} else {
							System.out.println("대출 수 증가 실패");
						}
					} else {
						msg = "뭔가가 잘못되었다......";
						url = "/SearchBook/searchBookAll.jsp";
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