<%@page import="reserve.ReserveDao"%>
<%@page import="borrow.BorrowDao"%>
<%@page import="java.io.File"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
admin-ManageBook-deleteBook.jsp<br>

<%
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	System.out.println("<admin-ManageBook-deleteBook.jsp> bnum : " + bnum);

	request.setCharacterEncoding("UTF-8");
	String bimage = request.getParameter("bimage");
	
	
	BookDao bdao = BookDao.getInstance();
	BorrowDao brdao = BorrowDao.getInstance();
	ReserveDao rdao = ReserveDao.getInstance();
	boolean flag = brdao.checkCanAdminDeleteThisBook(bnum);
	boolean flag2 = rdao.checkCanAdminDeleteThisBook(bnum);
	  
	String msg = null;
	String url = null;;
	
	if(flag == true) {
		msg = "회원이 대출중인 도서는 삭제할 수 없습니다.";
		url = "showAllBorrowedBook.jsp";
	} else {
		if(flag2 == true) {
			msg = "회원이 예약중인 도서는 삭제할 수 없습니다.";
			url = "showBook.jsp";
		} else {
			int cnt = bdao.deleteBook(bnum);
		 	String configFolder = config.getServletContext().getRealPath("admin/ManageBook/bookImage");
		 	
		 	if(cnt > 0) {
		 		File delFile = new File(configFolder, bimage);
		 		if(delFile.exists()) {
		 			delFile.delete();
					msg = "delete Book 성공";
					url = "showBook.jsp";
		 		}
		 	} else {
				msg = "delete Book 실패";
				url = "showBook.jsp";
		 	}
		}
	}
	
 %>  
 
 	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script>