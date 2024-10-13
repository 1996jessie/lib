<%@page import="java.util.Date"%>
<%@page import="borrow.BorrowDao"%>
<%@page import="book.BookBean"%>
<%@page import="book.BookDao"%>
<%@page import="reserve.ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reserve.ReserveDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<style>
<style type="text/css">
    /* 예약 목록 테이블 스타일 */
    .reserve-table {
        border-collapse: collapse;
        width: 80%;
        margin: auto; /* 가운데 정렬 추가 */
        margin-top: 20px; /* 상단 여백 추가 */
    }
    .reserve-table th, .reserve-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    .reserve-table th {
        background-color: #f2f2f2; /* 헤더 배경색 추가 */
    }
    .reserve-table tr:nth-child(even) {
        background-color: #f9f9f9; /* 짝수 행 배경색 추가 */
    }
    .reserve-table tr:hover {
        background-color: #f2f2f2; /* 호버시 배경색 변경 */
    }
    .reserve-table a {
        text-decoration: none;
        color: #007bff; /* 링크 색상 변경 */
    }
    .reserve-table a:hover {
        color: #0056b3; /* 호버시 링크 색상 변경 */
    }
    .reserve-table .button-cell {
        text-align: center;
    }
    .reserve-table .button-cell a {
        display: inline-block;
        padding: 6px 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .reserve-table .button-cell a:hover {
        background-color: #0056b3; /* 호버시 배경색 변경 */
    }
</style>


<%
	request.setCharacterEncoding("UTF-8");
	ReserveDao rdao = ReserveDao.getInstance();
	BookDao bdao = BookDao.getInstance();
	ArrayList<ReserveBean> rlist = rdao.getAllReservedBookByMe(mnum);
	
	
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
<table border="1" align="center" width="80%">
<%	
	if(rlist.size() == 0) {
%>		
	<tr>
		<td align="center">예약한 도서가 없습니다.</td>
	</tr>
<%	
	} else {
		for(ReserveBean rb : rlist) {
			BookBean bb = bdao.getBookByBcode(rb.getRbcode());
			SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
			BorrowDao brdao = BorrowDao.getInstance();
			String returndate = brdao.getReturnDate(rb.getRbcode());
			Date date = originalFormat.parse(returndate);
			String formattedDate = targetFormat.format(date);
%>			
			<table class ="reserve-table" align = "center">
				<tr>
					<td>회원번호</td>
					<td><%= rb.getRmnum() %></td>
					<td>도서번호</td>
					<td><%= rb.getRbcode() %></td>
				</tr>
				
				<tr>
					<td>도서명</td>
					<td><%= bb.getBtitle() %></td>
					<td>저자</td>
					<td><%= bb.getBauthor() %></td>	
				</tr>
				
				<tr>
					<td>반납예정일</td>
					<td><%= formattedDate %></td>
					<td>내 순서/예약인원</td>
					<td>
					<%	
						int count = rdao.countReservation(rb.getRbcode());
						int rank = rdao.countMyOrder(rb.getRmnum(), rb.getRbcode());
					%>
					<%= rank %>번째/<%= count %>명
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="../ReserveBook/cancelReservation.jsp?rmnum=<%= rb.getRmnum() %>&rbcode=<%= rb.getRbcode() %>">
							예약 취소
						</a> 
					</td>
					<td colspan="2">
						<a href="../BorrowBook/borrowReservedBook.jsp?rmnum=<%= rb.getRmnum() %>&rbcode=<%= rb.getRbcode() %>&rank=<%= rank %>">
							대출하기
						</a>
					</td>
				</tr>
			</table>
<%		}
	}
}
%>	
</table>
<%@include file="../../bottom.jsp" %>
