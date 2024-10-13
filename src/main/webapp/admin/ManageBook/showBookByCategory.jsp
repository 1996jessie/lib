<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../../top.jsp"%>   

showBookByCategory.jsp<br>
<script type="text/javascript">
	function checkDel(bnum, bimage) {
		var isDel = confirm("정말 삭제하시겠습니까?");
		//alert(choice);
		if(isDel) {
			location.href = "deleteBook.jsp?bnum="+bnum+"&bimage="+bimage;
		} else {
			location.href = "showBook.jsp";
		}
	}
</script>

<style type="text/css">
    /* 왼쪽 카테고리 목록 */
    .category-table {
        border-collapse: collapse;
        width: 20%;
        float: left;
        margin-right: 10px;
        background-color: #f0f0f0; /* 배경색 추가 */
        text-align: center; /* 가운데 정렬 추가 */
    }
    .category-table td {
        border: 1px solid #ccc;
        padding: 8px;
    }
    .category-table td a {
        text-decoration: none;
        color: #333;
        font-weight: bold;
    }
    .category-table td a:hover {
        color: #ff6347; /* 마우스 호버시 색상 변경 */
    }

    /* 오른쪽 도서 목록 */
    .books-table {
        width: 75%;
        float: right;
        background-color: #f9f9f9; /* 배경색 추가 */
    }
    .books-table hr {
        border: 0;
        height: 1px;
        background: #ccc;
        margin-bottom: 10px;
    }
    .books-table font strong {
        font-weight: bold;
        font-size: 1.2em;
    }
    .books-table td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    .books-table td img {
        border: 1px solid #ccc;
    }
    .books-table .btn {
        padding: 6px 12px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .books-table .btn:hover {
        background-color: #0056b3;
    }
</style>






<!-- 왼쪽에 카테고리 목록 표시 -->
<table class="category-table" border="1" align="left" style="margin-right: 10px;">
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=000">
                총류
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=100">
                철학
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=200">
                종교
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=300">
                사회과학
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=400">
                자연과학
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=500">
                기술과학
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=600">
                예술
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=700">
                언어
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=800">
                문학
            </a>
        </td>
    </tr>
    <tr>
        <td>
            <a href="showBookByCategory.jsp?bcategory=900">
                역사
            </a>
        </td>
    </tr>
</table>

<!-- 오른쪽에 도서 목록 표시 -->

<%
    request.setCharacterEncoding("UTF-8");
    String bcategory = request.getParameter("bcategory");
    System.out.println("<showBookByCategory.jsp> bcategory : " + bcategory);

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

    BookDao bdao = BookDao.getInstance();
    int bcategoryNum = 0;
    try {
        bcategoryNum = Integer.parseInt(bcategory) / 100;
    } catch (NumberFormatException e) {
    }
    System.out.println("bcategoryNum : " + bcategoryNum);
    
    if(bcategory == null) {
    %>
		<hr width="75%" align ="right">  
		<strong>대분류를 선택하세요</strong>
		<hr width="75%" align = "right">
    <%	
    } else {
    
    for(int i=1;i<scategory[bcategoryNum].length;i++) {
        String scategoryValue = String.valueOf(i * 10);
        ArrayList<BookBean> blist = bdao.getBookByCat(bcategory, scategoryValue);
%>      
    <hr width="75%" align ="right">  
    <font><strong><%= scategory[bcategoryNum][i] %></strong></font>
    <hr width="75%" align = "right">
   <table class="books-table" border="1" width="75%" align="right">
<%      
        if(blist.size() == 0) {
%>          
            <tr align = "center">
                <td colspan = "10">등록된 도서가 없습니다.</td>
            </tr>
<%          } else {
                for(BookBean bb : blist) {
                    String requestDir = request.getContextPath()+"/admin/ManageBook/bookImage";
%>
            <tr align = "center">
                <td><%= bb.getBnum() %></td>
                <td><%= bb.getBtitle() %></td>
                <td><%= bb.getBauthor() %></td>
                <td>
                <%
                    int cnum = Integer.parseInt(bb.getBcategory());                     
                    String[] bcategory2 = {"---","총류","철학","종교","사회과학","자연과학","기술과학","예술","언어","문학","역사"};
                %>
                    <%= bcategory2[cnum / 100 + 1] %>
                </td>
                <td>
                <%
                    int snum = Integer.parseInt(bb.getScategory());
                %>
                <%= scategory[cnum / 100][snum / 10] %></td>
                <td><%= bb.getBcode() %></td>
                <td>
                    <a href="introduceBook.jsp?bnum=<%= bb.getBnum() %>">
                        <img src="<%= requestDir + "/" + bb.getBimage() %>" width="50" height="50">
                    </a>
                </td>
                <td><%= bb.getBpublisher() %></td>
                <td><%= bb.getBpubyear() %></td>
                <td><%= bb.getBbuydate() %></td>
                <td><%= bb.getBprice() %></td>
                <td><%= bb.getBlendcount() %></td>
                <td><%= bb.getBreservecount() %></td>
                <td><a href="updateBook.jsp?bnum=<%= bb.getBnum() %>&bcode=<%= bb.getBcode()%>"><input type = button value = "수정"></a></td>
                <td><a href="javascript:checkDel('<%= bb.getBnum() %>','<%= bb.getBimage() %>')"><input type = button value = "삭제"></a></td>
            </tr>
<%              }
        }
%>
    </table>
<%      
	}
}
%>
<%@include file="../../bottom.jsp"%>