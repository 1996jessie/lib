<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file= "../../top.jsp" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	//alert("1");
    $('#searchByBtitle2').click(function(){
    	//alert("2");
        var btitle2 = $('input[name = btitle2]').val();
        
        if(btitle2 == "") {
            alert("검색하고 싶은 도서명을 입력하세요");
            $('input[name = btitle2]').focus();
            return false;
        } else {
            return true; // 입력값이 비어 있지 않으면 검색 동작 실행
        }
    }); //submit 클릭
}); //ready
</script>
 
<style>
    /* 스타일은 여기에 */
    .search-table {
        border-collapse: collapse;
        width: 80%;
        margin: auto;
        border: 1px solid #ddd;
    }
    .search-table th, .search-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    .search-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .search-table img {
        width: 120px;
        height: 80px;
    }
    .search-table a {
        background-color: #4CAF50;
        color: white;
        padding: 8px 16px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        border-radius: 5px;
    }
    .search-table a:hover {
        background-color: #45a049;
    }
    .search-form {
        width: 80%;
        margin: auto;
        text-align: center;
        margin-top: 20px;
    }
    .search-form input[type="text"] {
        padding: 8px;
        width: 60%;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    .search-form input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .search-form input[type="submit"]:hover {
        background-color: #45a049;
    }
    
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
<div class="search-form">
    <form action="searchBookByBtitle.jsp" method="post">
        검색할 도서명 :
        <input type="text" name="btitle2">
        <input type="submit" id="searchByBtitle2" value="검색">
    </form>
</div>
        
	<%
		request.setCharacterEncoding("UTF-8");
		String btitleInTop = request.getParameter("btitleInTop");
		System.out.println("<searchBookByBtitle> btitleInTop : " + btitleInTop);
		BookDao bdao = BookDao.getInstance();
		ArrayList<BookBean> blist = bdao.getBookContainsBtitle(btitleInTop);
			
		if(blist.size() > 0) {
	%>		 <table class="search-table" align="center">
				<tr >
					<td align = "center">요청하신 <strong>"<%= btitleInTop %>"</strong> 에 대한 자료 검색 결과이며 총 <%= blist.size() %>개가 검색되었습니다.</td>
				</tr>
			</table>
	<% 		
			for(BookBean bb : blist) {
	%>			
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
			
<%		}
	} else {
%>
		 <table class="search-table" align="center">
			<tr>
				<td align = "center">검색한 결과가 없습니다.</td>
			</tr>
		</table>
<%		
	}
%>
<%@include file= "../../bottom.jsp" %>