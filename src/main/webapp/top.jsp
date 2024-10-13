<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $('#searchByBtitle').click(function(){
        var btitle = $('input[name = btitle]').val();
        
        if(btitle == "") {
            alert("검색하고 싶은 도서명을 입력하세요");
            $('input[name = btitle]').focus();
            return false;
        } else {
            return true; // 입력값이 비어 있지 않으면 검색 동작 실행
        }
    }); //submit 클릭
}); //ready
</script>

<style>
.menu-container {
    width: 90%;
    margin: 0 auto;
}

.menu-list {
    list-style: none;
    padding: 0;
    display: table;
    width: 100%;
}

.menu-item {
    display: table-cell;
    margin-right: 20px;
    text-align: center;
    vertical-align: middle;
    width: 20%; /* 각 항목의 너비를 20%로 설정 */
}

.menu-item a {
    text-decoration: none;
    color: #333;
    display: block;
    padding: 10px;
    background-color: #f4f4f4;
    border: 1px solid #ccc;
}

.submenu {
    display: none;
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
    padding: 0;
    width: 16.7%; /* 하위 목록의 너비를 100%로 설정 */
}

.menu-item:hover .submenu {
    display: block;
}

.submenu li {
    display: block;
}

.submenu li a {
    display: block;
    padding: 10px;
    text-decoration: none;
    color: #333;
}

.submenu li a:hover {
    background-color: #f4f4f4;
}

#search-container {
    width: 60%; /* 전체 너비의 90%로 설정 */
    margin: 0 auto; /* 가운데 정렬을 위해 왼쪽과 오른쪽에 자동 마진 추가 */
}

#search-container input[type="text"] {
    width: 80%; /* 검색 칸의 너비를 80%로 설정 */
    padding: 10px; /* 내부 여백 추가 */
    font-size: 16px; /* 글꼴 크기 설정 */
}

#search-container input[type="submit"] {
    width: 15%; /* 검색 버튼의 너비를 15%로 설정 */
    padding: 10px; /* 내부 여백 추가 */
    font-size: 16px; /* 글꼴 크기 설정 */
}

#search-container img {
    max-width:15%; /* 이미지의 최대 너비를 전체의 25%로 설정 */
    height: auto; /* 가로 세로 비율을 유지하면서 이미지의 높이를 자동으로 조정 */
}

/* 로그아웃 버튼 스타일 */
.login-button, .logout-button, .register-button {
    display: inline-block;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.login-button {
    background-color: #4CAF50;
    color: white;
}

.login-button:hover {
    background-color: #45a049;
}

.logout-button {
    background-color: #f44336;
    color: white;
}

.logout-button:hover {
    background-color: #d32f2f;
}

.register-button {
    background-color: #2196F3;
    color: white;
}

.register-button:hover {
    background-color: #1e88e5;
}

.user-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
}

    .menu-container {
        font-family: Arial, sans-serif;
    }
    
    .menu-list {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }
    
    .menu-item {
        background-color: #f8f9fa; /* 기본 배경색 */
        padding: 10px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .menu-item:hover {
        background-color: #e9ecef; /* 마우스 올릴 때 배경색 */
    }
    
    .menu-item a {
        text-decoration: none;
        color: #212529;
    }
    
    .submenu {
        display: none;
        background-color: #fff;
        padding: 0;
        margin: 0;
        border: 1px solid #dee2e6;
    }
    
    .submenu li {
        padding: 8px 10px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .submenu li:hover {
        background-color: #f8f9fa; /* 마우스 올릴 때 배경색 */
    }
    
    .menu-item:hover .submenu {
        display: block;
        position: absolute;
    }
</style>
<%
	String id = (String)session.getAttribute("id");
	String password = (String)session.getAttribute("password");
	String mname = (String)session.getAttribute("mname");
	
	MemberDao mdao = MemberDao.getInstance();
	int mnum = mdao.findmnum(id);
	
	if(id == null) {
	    System.out.println("<top.jsp> null");
%>      
		<body align = "center">
		

			<table align="center" width="80%">
			    <tr>
			        <td width="25%">
			            <a href="<%= request.getContextPath() %>/main.jsp"><img src="<%= request.getContextPath() %>/image/도서관이미지.jpg" id="library-image" width="100%"></a>
			        </td>
			        <td align="center" id="search-container">
			            <form action="<%= request.getContextPath() %>/user/SearchBook/searchBookByBtitle.jsp">
			                <input type="text" name="btitle2">
			                <input type="submit" id="searchByBtitle" value="검색">
			            </form>
			        </td>
			        <td>
			            <a href="<%= request.getContextPath() %>/login/login.jsp" class="login-button">로그인</a>
			        </td>
			        <td>
			            <a href="<%= request.getContextPath() %>/user/ManageAccount/canIInsert.jsp" class="register-button">회원가입</a>
			        </td>
			    </tr>
			</table>

			
			<div class="menu-container">
			    <ul class="menu-list">

			        <li class="menu-item">
			            <a href="#">도서</a>
			            <ul class="submenu">
			                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookAll.jsp">모든 도서 보기</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookByBtitle.jsp">제목별 검색</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookByCategory.jsp">카테고리별 검색</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookMost.jsp">베스트셀러</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookNew.jsp">신간</a></li>
			            </ul>
			        </li>
			        <li class="menu-item">
			            <a href="#">나의 도서관</a>
			            <ul class="submenu">
			                <li><a href="<%= request.getContextPath() %>/user/BorrowBook/borrowList.jsp">내 대출 도서 보기</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/ReserveBook/reserveList.jsp">내 예약 도서 보기</a></li>
			            </ul>
			        </li>
            <li class="menu-item">
                <a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a>
                <ul class="submenu">                   
                    <li><a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a></li>
                </ul>
            </li>
			        <li class="menu-item">
			            <a href="#">내 정보</a>
			            <ul class="submenu">
			                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/showMyAccount.jsp?password=<%= password %>">내 정보 보기</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/updateMyAccount.jsp">내 정보 수정</a></li>
			                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/deleteMyAccount.jsp">회원 탈퇴</a></li>
			            </ul>
			        </li>
			    </ul>
			</div>
		</body>
	
	<%  } else { 
	if(id.equals("admin")) {
	System.out.println("session으로 설정한 adminid : " + id);
	%>      
<body align="center">
<table align="center" width="70%">
    <tr>
        <td width = 25%>
        	<a href="<%= request.getContextPath() %>/main.jsp"><img src="<%= request.getContextPath() %>/image/도서관이미지.jpg" id="library-image" width="100%"></a>
        </td>
        <td align="center" id="search-container">
        	 <form action="<%= request.getContextPath() %>/user/SearchBook/searchBookByBtitleInTop.jsp">
                <input type="text" name="btitleInTop">
                <input type="submit" id="searchByBtitle" value="검색">
            </form>
        </td>
        <td class="user-name"><%= mname %>님</td>
        <td><a href="<%= request.getContextPath() %>/login/logout.jsp" class="logout-button">로그아웃</a></td>
    </tr>

</table>
    
    <div class="menu-container">
        <ul class="menu-list">

            <li class="menu-item">
                <a href="<%= request.getContextPath() %>/admin/ManageBook/showBook.jsp">도서</a>
                <ul class="submenu">
                    <li><a href = "<%= request.getContextPath() %>/admin/ManageBook/showBook.jsp">도서 관리</a></li>
                    <li><a href = "<%= request.getContextPath() %>/admin/ManageBook/insertBook.jsp">도서 추가</a></li>
                    <li><a href = "<%= request.getContextPath() %>/admin/ManageBook/showBookByCategory.jsp">카테고리별 도서 관리</a></li>
                    <li><a href = "<%= request.getContextPath() %>/admin/ManageBook/showBookByBpubyear.jsp">연도별 도서 관리</a></li>                   
                </ul>
            </li>
            <li class="menu-item">
                <a href = "<%= request.getContextPath() %>/admin/ManageMember/showMember.jsp">회원 관리</a>
                <ul class="submenu">
                    <li><a href="<%= request.getContextPath() %>/admin/ManageMember/showMember.jsp">회원 보기</a></li>
                    
                </ul>
            </li>
            <li class="menu-item">
                <a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a>
                <ul class="submenu">                   
                    <li><a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a></li>
                </ul>
            </li>
            <li class="menu-item">
                <a href="#">내 정보</a>
                <ul class="submenu">
                    <li><a href="<%= request.getContextPath() %>/user/ManageAccount/showMyAccount.jsp?password=<%= password %>">내 정보 보기</a></li>
                    <li><a href="<%= request.getContextPath() %>/user/ManageAccount/updateMyAccount.jsp">내 정보 수정</a></li>
                    <li><a href="<%= request.getContextPath() %>/user/ManageAccount/deleteMyAccount.jsp">회원 탈퇴</a></li>
                </ul>
            </li>
        </ul>
    </div>
</body>

	<% } else {
	System.out.println("session으로 설정한 id : " + id);
	%>      
		<body align = "center">
		
		
<table align="center" width="70%">
    <tr>
        <td width = 25%>
        	<a href="<%= request.getContextPath() %>/main.jsp"><img src="<%= request.getContextPath() %>/image/도서관이미지.jpg" id="library-image" width="100%"></a>
        </td>
        <td align="center" id="search-container">
        	 <form action="<%= request.getContextPath() %>/user/SearchBook/searchBookByBtitle.jsp">
                <input type="text" name="btitle2">
                <input type="submit" id="searchByBtitle" value="검색">
            </form>
        </td>
        <td class="user-name"><%= mname %>님</td>
        <td><a href="<%= request.getContextPath() %>/login/logout.jsp" class="logout-button">로그아웃</a></td>
    </tr>

</table>
	
<div class="menu-container">
    <ul class="menu-list">

        <li class="menu-item">
            <a href="<%= request.getContextPath() %>/user/SearchBook/searchBookAll.jsp">도서</a>
            <ul class="submenu">
                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookAll.jsp">모든 도서 보기</a></li>
                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookByBtitle.jsp">제목별 검색</a></li>
                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookByCategory.jsp">카테고리별 검색</a></li>
                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookMost.jsp">베스트셀러</a></li>
                <li><a href="<%= request.getContextPath() %>/user/SearchBook/searchBookNew.jsp">신간</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="<%= request.getContextPath() %>/user/BorrowBook/borrowList.jsp">나의 도서관</a>
            <ul class="submenu">
                <li><a href="<%= request.getContextPath() %>/user/BorrowBook/borrowList.jsp">내 대출 도서 보기</a></li>
                <li><a href="<%= request.getContextPath() %>/user/ReserveBook/reserveList.jsp">내 예약 도서 보기</a></li>
            </ul>
        </li>
            <li class="menu-item">
                <a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a>
                <ul class="submenu">                   
                    <li><a href="<%= request.getContextPath() %>/article/articleList.jsp">묻고답하기</a></li>
                </ul>
            </li>
        <li class="menu-item">
            <a href="#">내 정보</a>
            <ul class="submenu">
                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/showMyAccount.jsp?password=<%= password %>">내 정보 보기</a></li>
                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/updateMyAccount.jsp">내 정보 수정</a></li>
                <li><a href="<%= request.getContextPath() %>/user/ManageAccount/deleteMyAccount.jsp">회원 탈퇴</a></li>
            </ul>
        </li>
    </ul>
</div>
		</body>
	<% }
	}
%>
