<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "../../top.jsp" %>
searchBookByBtitleProc.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	String btitle = request.getParameter("btitle");
	System.out.println("<searchBook.jsp> btitle : " + btitle);

	BookDao bdao = BookDao.getInstance();
	ArrayList<BookBean> blist = bdao.getBookContainsBtitle(btitle);
%>

	<table border = 1>
		<tr>
			<td>요청하신 <%= btitle %> 에 대한 자료 검색 결과이며 총 <%= blist.size() %>개가 검색되었습니다.</td>
		</tr>
<%
	if(btitle == null) {
%>		<tr>
			<td>검색 결과가 없습니다.</td>
		</tr>
<%	} else {
		for(BookBean bb : blist) {
%>			<table border = 1>
				<tr>
					<td rowspan = 3> 
						<img src="<%= request.getContextPath()+"/admin/ManageBook/bookImage/"+bb.getBimage()%>" width="120" height="80">
					</td>
					<td>서명</td>
					<td><%= bb.getBtitle() %></td>
					<td>저자</td>
					<td><%= bb.getBauthor() %></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><%= bb.getBpublisher() %></td>
					<td>번호</td>
					<td><%= bb.getBnum() %></td>
				</tr>
				<tr>
					<td colspan = 2>
						<a href = "../BorrowBook/borrowThisBook.jsp?bcode=<%= bb.getBcode() %>&mnum=<%= mnum %>">
							대출
						</a>
					</td>
					<td colspan = 2>
						<a href = "../ReserveBook/reserveThisBook.jsp?bcode=<%= bb.getBcode() %>&mnum=<%= mnum %>&bnum=<%= bb.getBnum() %>">
							예약
						</a>
					</td>
				</tr>
			</table>
<%		}
	}
%>
	</table>
	
<%@include file= "../../bottom.jsp" %>