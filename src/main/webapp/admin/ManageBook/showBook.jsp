<%@page import="reserve.ReserveDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../../top.jsp" %>
<style>
    .book-table {
        border-collapse: collapse;
        width: 90%;
        margin: auto;
        border: 2px solid #ddd;
    }
    .book-table th, .book-table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
        font-family: Arial, sans-serif;
    }
    .book-table caption {
        caption-side: top;
        margin-bottom: 10px;
        font-weight: bold;
        font-size: 1.2em;
        color: #333;
    }
    .book-table img {
        width: 50px;
        height: 50px;
    }
    .book-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .book-table th {
        background-color: #4CAF50;
        color: white;
    }
    .book-table td a {
        text-decoration: none;
        color: #337ab7;
    }
    .book-table td a:hover {
        color: #23527c;
        font-weight: bold;
    }
    .book-table .add-book-button {
        position: relative;
        top: 10px;
        left: 700px;
        text-decoration: none;
        padding: 5px 10px;
        background-color: #4CAF50;
        color: white;
        border-radius: 3px;
    }
    
    .pagination {
        margin-top: 20px;
        text-align: center;
    }
    .pagination a {
        text-decoration: none;
        color: #337ab7;
        padding: 5px 10px;
        border: 1px solid #ddd;
        margin: 0 2px;
        border-radius: 3px;
    }
    .pagination a.active {
        background-color: #4CAF50;
        color: white;
    }
    .pagination a:hover:not(.active) {
        background-color: #ddd;
    }
    .table-container {
        position: relative;
    }
</style>
<script type="text/javascript">
    function checkDel(bnum, bimage) {
        var isDel = confirm("정말 삭제하시겠습니까?");
        if(isDel) {
            location.href = "deleteBook.jsp?bnum="+bnum+"&bimage="+bimage;
        } else {
            location.href = "showBook.jsp";
        }
    }
</script>

<a href="insertBook.jsp" class="add-book-button"><input type="button" value="도서 추가"></a>

<table class="book-table">
	<caption>도서 목록</caption>
		<tr align = "center">
			<td>도서번호</td>
			<td>도서명</td>
			<td>저자</td>
			<td>카테고리</td>
			<td>세부카테고리</td>
			<td>도서 코드</td>
			<td>이미지</td>
			<td>출판사</td>
			<td>출판년도</td>
			<td>구입날짜</td>
			<td>가격</td>
			<td>대출수</td>
			<td>현재 예약 인원</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		
		<%
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			BookDao bdao = BookDao.getInstance();
			
			
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
			
			
			ArrayList<BookBean> blist = bdao.getBookByPage(startRow, endRow);  
			
			count = bdao.getBookCount();
			number = count - (currentPage - 1) * pageSize;
			
			
			if(blist.size() == 0) {
				
				
		%>		<tr align = "center">
					<td colspan = "10">등록된 도서가 없습니다.</td>
				</tr>
		<%	} else {
				for(BookBean bb : blist) {	
					String requestDir = request.getContextPath()+"/admin/ManageBook/bookImage";
					System.out.println("<showBook.jsp> : " + bb.getBpubyear());
					ReserveDao rdao = ReserveDao.getInstance();
					int breservecount = rdao.checkReserveCount(bb.getBcode());
					int cnt = bdao.countReservedBook(breservecount, bb.getBcode());
					if(cnt > 0) {
						System.out.println("현재 예약인원 업데이트 성공");
					}
		%>			
				<tr align = "center">
					<td><%= bb.getBnum() %></td>
					<td><%= bb.getBtitle() %></td>
					<td><%= bb.getBauthor() %></td>
					<td>
					<%
						int cnum = Integer.parseInt(bb.getBcategory());						
						String[] bcategory = {"---","총류","철학","종교","사회과학","자연과학","기술과학","예술","언어","문학","역사"};
					%>
						<%= bcategory[cnum / 100 + 1] %>
					</td>
					<td>
					<%
						int snum = Integer.parseInt(bb.getScategory());
						String[][] scategory = {
								{"---","도서학","문헌정보학","백과사전","강연집","일반연속간행물","일반 학회","신문","일반 전집","향토자료"},
								{"---","형이상학", "인식론", "철학의세계","경학","동양철학","서양철학","논리학","심리학","윤리학"},
								{"---","비교종교학", "불교", "기독교","도교","천도교","없음", "힌두교","이슬람교","기타 제종교"},
								{"---","통계학", "경제학", "사회학","정치학","행정학","법학","교육학","풍속","국방"},
								{"---","수학", "물리학", "화학","천문학","지학","광물학","생명과학","식물학","동물학"},
								{"---","의학", "농업", "공학","건축공학","기계공학","전기공학","화학공학","제조업","생활과학"},
								{"---","건축술", "조각및조형미술", "공예","서예","회화","사진예술","음악","공연예술","오락"},
								{"---","한국어", "중국어", "일본어","영어","독일어","프랑스어","스페인어","이탈리아어","기타제어"},
								{"---","한국문학","중국문학","일본문학","영미문학","독일문학","프랑스문학","스페인및포르투갈문학","이탈리아문학","기타제문학"},
								{"---","아시아", "유럽", "아프리카","북아메리카","남아메리카","오세아니아","양극지방","지리","전기"}
							};
					%>
					<%= scategory[cnum / 100][snum / 10] %></td>
					<td><%= bb.getBcode() %></td>
					<td>
						<img src = "<%= requestDir + "/" + bb.getBimage() %>" width = "50" height = "50">
					</td>
					<td><%= bb.getBpublisher() %></td>
					
					<td><%= bb.getBpubyear() %></td>
					<td><%= bb.getBbuydate() %></td>
					<td><%= bb.getBprice() %></td>
					<td><%= bb.getBlendcount() %></td>
					<td><%= breservecount %></td>
					<td><a href="updateBook.jsp?bnum=<%= bb.getBnum() %>&bcode=<%= bb.getBcode()%>">수정</a></td>
					<td><a href = "javascript:checkDel('<%= bb.getBnum() %>','<%= bb.getBimage() %>')"> 삭제 </a></td>
				</tr>
		<%		}
			}
		%>
</table>
<div class="pagination">
    <%
    if(count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 10; // 한번에 10개의 페이지가 보이게 하자

        int startPage = ((currentPage - 1) / pageBlock * pageBlock) +  1;
        int endPage = startPage + pageBlock - 1;
        if(endPage > pageCount) {
            endPage = pageCount;
        }
        if(startPage > 10) {
    %>
                <a href="showBook.jsp?pageNum=<%= startPage-10 %>">[이전]</a>     
    <%  }
        for(int i = startPage; i <= endPage; i++) {
            String activeClass = (i == currentPage) ? "active" : "";
    %>
                <a href="showBook.jsp?pageNum=<%= i %>" class="<%= activeClass %>"><%= i %></a>
    <%  }
        if(endPage < pageCount) {
    %>
                <a href="showBook.jsp?pageNum=<%= startPage+10 %>">[다음]</a>
    <%  }
    }   
    %>
</div>

<%@include file="../../bottom.jsp"%>