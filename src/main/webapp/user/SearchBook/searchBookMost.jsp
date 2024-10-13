<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file= "../../top.jsp" %>
<style>
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
</style>
<%
	request.setCharacterEncoding("UTF-8");

	BookDao bdao = BookDao.getInstance();
	ArrayList<BookBean> blist = bdao.getBookByMost();
%>

	
<%
	if(blist.size() == 0) {
%>	<table class="book-table" align="center">
		<tr>
			<td align = "center">도서가 없습니다.</td>
		</tr>
	</table>
<%	} else {
		for(BookBean bb : blist) {
%>		<table class="book-table" align="center">
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
<%		}
	}
%>
	</table>
<%@include file="../../bottom.jsp" %>