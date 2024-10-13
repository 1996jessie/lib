<%@page import="borrow.BorrowBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<style type="text/css">
    /* 테이블 스타일 */
    .borrow-table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
    }
    .borrow-table th, .borrow-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }
    .borrow-table th {
        background-color: #f2f2f2;
    }
</style>

<%
    BorrowDao brdao = BorrowDao.getInstance();
    ArrayList<BorrowBean> brlist = brdao.getAllBorrowedBook();
%>

<table class="borrow-table">
    <% if(brlist.size() == 0) { %>
        <tr>
            <td colspan="6" align="center">
                대출된 도서가 없습니다.
            </td>
        </tr>
    <% } else { %>
        <tr>
            <th>대출번호</th>
            <th>회원번호</th>
            <th>도서코드</th>
            <th>대출일</th>
            <th>반납일</th>
            <th>연장횟수</th>
        </tr>
        <% for(BorrowBean brb : brlist) { %>
            <tr>
                <td><%= brb.getBrnum() %></td>
                <td><%= brb.getBrmnum() %></td>
                <td><%= brb.getBrbcode() %></td>
                <td><%= brb.getBorrowdate() %></td>
                <td><%= brb.getReturndate() %></td>
                <td><%= brb.getExtendcount() %></td>    
            </tr>
        <% } %>
    <% } %>
</table>

<%@include file="../../bottom.jsp" %>
