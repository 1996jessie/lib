<%@page import="member.MemberDao"%>
<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "../../top.jsp" %>

<style>
    /* 스타일은 여기에 */
    .book-table {
        border-collapse: collapse;
        width: 80%;
        margin: auto;
        border: 1px solid #ddd;
    }
    .book-table th, .book-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .book-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .book-table img {
        width: 200px; /* 이미지 크기 조정 */
        height: 150px; /* 이미지 크기 조정 */
    }
    .book-table .button-cell {
        text-align: right;
    }
    .book-table .borrow-button {
        background-color: #4CAF50;
    }
    .book-table .reserve-button {
        background-color: #008CBA;
    }
    .book-table .button-cell a {
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        display: inline-block;
        border-radius: 5px;
        margin-left: 5px;
    }
    .book-table .button-cell a:hover {
        opacity: 0.8;
    }
    .pagination {
        margin: 20px 0;
        text-align: center;
    }
    .pagination a {
        color: black;
        float: left;
        padding: 8px 16px;
        text-decoration: none;
        transition: background-color .3s;
        border: 1px solid #ddd;
        margin: 0 4px;
        border-radius: 50%;
    }
    .pagination a.active {
        background-color: #4CAF50;
        color: white;
        border: 1px solid #4CAF50;
    }
    .pagination a:hover:not(.active) {background-color: #ddd;}
</style>


<%
    // JSP 코드는 여기에
    request.setCharacterEncoding("UTF-8");

    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null) {
        pageNum = "1";  
    }
    System.out.println("pageNum : "+pageNum);
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    
    BookDao bdao = BookDao.getInstance();
    ArrayList<BookBean> blist = bdao.getBookByPage(startRow, endRow);  
    
    count = bdao.getBookCount();
    number = count - (currentPage - 1) * pageSize;

    if(blist.size() == 0) {
%>
    <!-- 테이블은 여기에 -->
    <table class="book-table" align="center">
        <tr>
            <td>도서가 없습니다.</td>
        </tr>
    </table>
<%  
    } else {
        for(BookBean bb : blist) {
%>      
    <!-- 테이블은 여기에 -->
    <table class="book-table" align="center">
        <tr>
            <td rowspan="5"> 
                <img src="<%= request.getContextPath()+"/admin/ManageBook/bookImage/"+bb.getBimage()%>">
            </td>
            <td style="width: 50%;">서명</td>
            <td style="width: 50%; text-align: center;"><%= bb.getBtitle() %></td>
            
        </tr>
        <tr>
            <td>저자</td>
            <td><%= bb.getBauthor() %></td>
        </tr>
        
        <tr>       
            <td>출판사</td>
            <td><%= bb.getBpublisher() %></td>
        </tr>
        <tr>       

            <td>도서 코드</td>
            <td><%= bb.getBcode() %></td>
        </tr>        
        <tr class="button-cell">
            <td colspan="3">
                <a href="../BorrowBook/borrowThisBook.jsp?bcode=<%= bb.getBcode() %>&mnum=<%= mnum %>&bnum=<%= bb.getBnum() %>" class="borrow-button">
                    대출
                </a>

                <a href="../ReserveBook/reserveThisBook.jsp?bcode=<%= bb.getBcode() %>&mnum=<%= mnum %>&bnum=<%= bb.getBnum() %>" class="reserve-button">
                    예약
                </a>
            </td>
        </tr>
    </table>
<%      
        }
    }

    if(count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 10; //한번에 10개의 페이지가 보이게 하자
        
        int startPage = ((currentPage - 1) / pageBlock * pageBlock) +  1;
        int endPage = startPage + pageBlock - 1;
        if(endPage > pageCount) {
            endPage = pageCount;
        }
        if(startPage > 10) {
    %>
            <a href = "searchBookAll.jsp?pageNum=<%= startPage-10 %>">&laquo;</a>       
    <%      }
        for(int i = startPage;i<=endPage;i++) {
    %>      
            <a href = "searchBookAll.jsp?pageNum=<%= i %>" <%= (i == currentPage) ? "class=\"active\"" : "" %>><%= i %></a>
    <%      }
        if(endPage < pageCount) {
    %>      <a href = "searchBookAll.jsp?pageNum=<%= startPage+10 %>">&raquo;</a>
    <%      }
    }   
%>

<%@include file="../../bottom.jsp" %>
