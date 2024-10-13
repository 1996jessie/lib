<%@page import="borrow.BorrowDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteMyAccountProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	String password = request.getParameter("password");
	
	System.out.println("<deleteMyAccountProc.jsp> mnum : " + mnum + ", password : " + password);

	MemberDao mdao = MemberDao.getInstance();
	BorrowDao brdao = BorrowDao.getInstance();
	
	boolean flag = brdao.checkCanIDeleteMyAccount(mnum);

	String msg;
	String url;
	
	if(flag == true) {
		msg = "대출 중인 도서가 있습니다. 반납 후 탈퇴하세요";
		url = "../BorrowBook/borrowList.jsp";
	} else {
		int cnt = mdao.deleteMemberBySelf(mnum, password);
		System.out.println("<deleteMyAccountProc.jsp> 성공 개수 : " + cnt);

		if(cnt > 0) {
			msg = "delete 성공";
			url = "canIInsert.jsp";
			session.invalidate();
			String viewPage = request.getContextPath() + "/main.jsp"; // 절대 경로
			response.sendRedirect(viewPage);
		} else {
			msg = "비밀번호가 일치하지 않습니다.";
			url = "deleteMyAccount.jsp?mnum=" + mnum;
		}
	}

%>

<script type="text/javascript">
    alert("<%= msg %>");
    location.href = '<%= url %>';
</script> 