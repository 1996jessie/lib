<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
logout.jsp<br>

<%
    session.invalidate();
    String viewPage = request.getContextPath() + "/main.jsp"; // 절대 주소로 변경
    response.sendRedirect(viewPage);
%>
