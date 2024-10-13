<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String btitle = request.getParameter("btitle");
	String bauthor = request.getParameter("bauthor");

	BookDao bdao = BookDao.getInstance();
	boolean flag = bdao.searchBook(btitle, bauthor);
	
	if(flag) {
		out.print("exist");
	}else {
		out.print("not exist"); 
	}
%>