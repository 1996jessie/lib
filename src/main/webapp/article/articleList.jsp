<%@page import="article.ArticleBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="article.ArticleDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../top.jsp" %>
<style>
/* 공통 스타일 */
.write-table,
.no-article-table,
.article-table {
    width: 80%;
    margin: auto;
    margin-bottom: 20px;
    border-collapse: collapse;
}

.write-table,
.no-article-table {
    border: 1px solid;
    padding: 10px;
}

/* 글 쓰기 링크 테이블 스타일 */
.write-table {
    border-color: #4CAF50;
    background-color: #f1f1f1;
}

.write-table a {
    color: #4CAF50;
    text-decoration: none;
}

/* 저장된 글이 없는 경우 테이블 스타일 */
.no-article-table {
    border-color: #f44336;
    background-color: #f1f1f1;
}

/* 글 목록 테이블 스타일 */
.article-table {
    border: 1px solid #ddd;
}

.article-table th,
.article-table td {
    border: 1px solid #ddd;
    padding: 10px;
}

.article-table th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}

.article-table td {
    vertical-align: middle;
}

/* 페이지 링크 스타일 */
.page-links {
    text-align: center;
    margin-top: 20px;
}

.page-links a {
    color: #4CAF50;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color 0.3s;
}

.page-links a.active {
    background-color: #4CAF50;
    color: white;
}

.page-links a:hover:not(.active) {
    background-color: #ddd;
    color: #333;
}

/* 글 제목 링크 스타일 */
.article-table a {
    color: #333; /* 링크 색상을 검정색으로 고정 */
    text-decoration: none;
}

.article-table a:hover {
    text-decoration: underline;
}

/* 글 쓰기 링크 스타일 */
.write-table {
    border: 1px solid #4CAF50;
    background-color: #f1f1f1;
    width: 80%;
    margin: auto;
    margin-bottom: 20px;
    padding: 10px;
    border-radius: 5px; /* 테두리를 둥글게 만듦 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    transition: box-shadow 0.3s ease; /* 그림자 효과 애니메이션 */
}

.write-table:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 호버 시 그림자 효과 강화 */
}

.write-table a {
    color: #4CAF50;
    text-decoration: none;
    font-weight: bold; /* 텍스트 굵게 */
}

.write-table a:hover {
    color: #45a049;
}

</style>

<%
    request.setCharacterEncoding("UTF-8");
    int pageSize = 10; // 한 페이지에 10개씩
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    String pageNum = request.getParameter("pageNum"); // 문자열을 숫자로 바꿈
    if(pageNum == null) {
        pageNum = "1";
    }
    
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지의 시작번호
    int endRow = currentPage * pageSize; // 현재 페이지의 끝번호
    int count = 0;
    int number = 0;
    
    ArticleDao adao = ArticleDao.getInstance();
    ArrayList<ArticleBean> alist = adao.getArticles(startRow, endRow);
    count = adao.getArticleCount();
    
    number = count - (currentPage - 1) * pageSize;
    
    
	String msg2;	
	String url2;
	
	
	
	if(mname == null) {
		msg2 = "로그인 먼저 하세요";
		url2 = "../login/login.jsp";
%>	<script type="text/javascript">
		alert("<%= msg2 %>");
		location.href = "<%= url2 %>"
	</script>
<%	} else {
%>
<!-- 글 쓰기 링크 테이블 -->
<table class="write-table">
    <tr>
        <td align="right">
            <a href="insertArticle.jsp">글 쓰기</a>
        </td>
    </tr>
</table>

<% if(count == 0) { %>
    <!-- 저장된 글이 없는 경우 -->
    <table class="no-article-table">
        <tr>
            <td align="center">
                게시판에 저장된 글이 없습니다.
            </td>
        </tr>
    </table>
<% } else { %>
    <!-- 글 목록 테이블 -->
    <table class="article-table">
        <tr align="center">
            <td>번호</td>
            <td>제목</td>
            <td>작성자</td>
            <td>작성일</td>
            <td>조회</td>
        </tr>
        
        <% for(ArticleBean ab : alist) { %>
            <!-- 각 글 목록 항목 -->
            <tr align="center">
                <td><%= number-- %></td>
                <td align="left">
                    <% 
                        // 레벨에 따라 공백 계산
                        int wid = ab.getAlevel() * 5;
                        String padding = "";
                        for (int i = 0; i < wid; i++) {
                            padding += "&nbsp;";
                        }
                    %>
                    <%= padding %>
                    
                    <a href="showArticle.jsp?anum=<%=ab.getAnum()%>&pageNum=<%=pageNum%>">
                        <%= ab.getAtitle()%>
                        <% 
                        if(ab.getCheckPrivacy().equals("NO")) {
                        %>
                            <img src="../image/lock.jpg" height="15">
                        <% } %>
                    </a>
                </td>
                <td><%= ab.getAname() %></td>
                <td><%= ab.getAdate() %></td>
                <td><%= ab.getAreadcount() %></td>
            </tr>
        <% } //for %>
    </table>
<% }
}//else

    // 페이지 설정 생략...

%>

<!-- 페이지 링크 -->
<div class="page-links">
    <% if(count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int pageBlock = 10; // 한번에 10개의 페이지가 보이게 하자
        
        int startPage = ((currentPage - 1) / pageBlock * pageBlock) +  1;
        int endPage = startPage + pageBlock - 1;
        if(endPage > pageCount) {
            endPage = pageCount;
        }
        if(startPage > 10) { %>
            <a href="articleList.jsp?pageNum=<%= startPage-10 %>">이전</a>        
        <% }
        for(int i = startPage; i <= endPage; i++) { 
            if(i == currentPage) { %>
                <a href="#" class="active"><%= i %></a>
            <% } else { %>
                <a href="articleList.jsp?pageNum=<%= i %>"><%= i %></a>
            <% }
        }
        if(endPage < pageCount) { %>
            <a href="articleList.jsp?pageNum=<%= startPage+10 %>">다음</a>
        <% }
    } %>
</div>

<%@include file="../bottom.jsp" %>