<%@page import="book.BookBean"%>
<%@page import="book.BookDao"%>
<%@page import="borrow.BorrowBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="borrow.BorrowDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>

<style type="text/css">
    /* 대출 목록 테이블 스타일 */
    .borrow-table {
        border-collapse: collapse;
        width: 80%;
        margin: auto; /* 가운데 정렬 추가 */
        margin-top: 20px; /* 상단 여백 추가 */
    }
    .borrow-table th, .borrow-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    .borrow-table th {
        background-color: #f2f2f2; /* 헤더 배경색 추가 */
    }
    .borrow-table tr:nth-child(even) {
        background-color: #f9f9f9; /* 짝수 행 배경색 추가 */
    }
    .borrow-table tr:hover {
        background-color: #f2f2f2; /* 호버시 배경색 변경 */
    }
    .borrow-table a {
        text-decoration: none;
        color: #007bff; /* 링크 색상 변경 */
    }
    .borrow-table a:hover {
        color: #0056b3; /* 호버시 링크 색상 변경 */
    }
    .borrow-table .button-cell {
        text-align: center;
    }
    .borrow-table .button-cell a {
        display: inline-block;
        padding: 6px 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .borrow-table .button-cell a:hover {
        background-color: #0056b3; /* 호버시 배경색 변경 */
    }
</style>



<%
	request.setCharacterEncoding("UTF-8");
	BorrowDao brdao = BorrowDao.getInstance();
	BookDao bdao = BookDao.getInstance();
	ArrayList<BorrowBean> brlist = brdao.getAllBorrowedBookByMe(mnum);  
	
	
	String msg2;	
	String url2;
	
	
	
	if(mname == null) {
		msg2 = "로그인 먼저 하세요";
		url2 = request.getContextPath()+"/login/login.jsp";
%>	<script type="text/javascript">
		alert("<%= msg2 %>");
		location.href = "<%= url2 %>"
	</script>
<%	} else {
%>
	<table border = 1 align = "center" width = 80%>
<%
	if(brlist.size() == 0) {
%>		<tr>
			<td align = "center">대출한 도서가 없습니다</td>
		</tr>
<%	} else {
		for(BorrowBean brb : brlist) {
			System.out.println(brb.getBrbcode());
			BookBean bb = bdao.getBookByBcode(brb.getBrbcode());  
%>			<table class ="borrow-table" align = "center">
				<tr>
					<td>회원번호</td>
					<td><%= brb.getBrmnum() %></td>
					<td>도서번호</td>
					<td><%= brb.getBrbcode() %></td>
				</tr>
				
				<tr>
					<td>도서명</td>
					<td><%= bb.getBtitle() %></td>
					<td>저자</td>
					<td><%= bb.getBauthor() %></td>	
				</tr>
				<tr>
					<td>대출일</td>
					<td><%= brb.getBorrowdate() %></td>
					<td>반납예정일</td>
					<td><%= brb.getReturndate() %></td>
				</tr>
				<tr>
					<td colspan = 2>
						<a href = "../BorrowBook/returnThisBook.jsp?brmnum=<%= brb.getBrmnum() %>&brbcode=<%= brb.getBrbcode() %>">
							반납
						</a>
					</td>
					<td colspan = 2>
						<a href = "../BorrowBook/extendThisBook.jsp?brmnum=<%= brb.getBrmnum() %>&brbcode=<%= brb.getBrbcode() %>">
							연장
						</a>
					</td>
				</tr>
			</table>
<%			}
		}
	}
%>
	</table>
<%@include file="../../bottom.jsp" %>