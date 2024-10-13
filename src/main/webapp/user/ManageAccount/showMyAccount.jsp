<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp" %>   

<script type="text/javascript">
	function checkDel(mnum) {
		var isDel = confirm("정말 탈퇴하시겠습니까?");
		//alert(choice);
		if(isDel) {
			location.href = "deleteMyAccount.jsp?mnum="+mnum;
		} else {
			location.href = "showMyAccount.jsp";
		}
	}
</script>

<style>
/* 테이블 스타일 */
.my-info-table {
    border: 1px solid #ddd;
    width: 80%;
    margin: auto;
    margin-bottom: 20px;
    border-collapse: collapse;
}

.my-info-table caption {
    font-size: 1.2em; /* 캡션 폰트 사이즈 조절 */
    font-weight: bold; /* 캡션 글꼴 굵게 */
    margin-bottom: 10px; /* 캡션과 테이블 사이 간격 조절 */
}

.my-info-table th,
.my-info-table td {
    border: 1px solid #ddd;
    padding: 10px;
}

.my-info-table th {
    background-color: #f2f2f2;
    font-weight: bold;
    color: #333;
}

.my-info-table td {
    vertical-align: middle;
}

/* 링크 스타일 */
.my-info-table a {
    color: #333; /* 링크 색상을 검정색으로 고정 */
    text-decoration: none;
}

.my-info-table a:hover {
    text-decoration: underline;
}
/* 버튼 스타일 */
.my-info-btn {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.my-info-btn:hover {
    background-color: #45a049;
}


</style>
<%
	
	password = request.getParameter("password");
	System.out.println("<showMyAccount.jsp> id " + id + ", password : " + password);

	MemberBean mb = mdao.memberCheck(id, password);
	
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
<button class="my-info-btn" onclick="location.href='updateMyAccount.jsp?id=<%= mb.getId() %>'">내 정보 수정</button> 
<button class="my-info-btn" onclick="checkDel('<%= mb.getMnum() %>')">회원 탈퇴</button>

<table class="my-info-table">
    <caption>나의 정보</caption>
        <tr align="center">
            <th>회원번호</th>
            <th>이름</th>
            <th>아이디</th>
            <th>비밀번호</th>
            <th>이메일</th>
            <th>주민등록번호</th>
            <th>전화번호</th>
            <th>주소</th>
        </tr>
        
        <%
            if(mb == null) {
        %>
                <tr align="center">
                    <td colspan="8">가입된 정보가 없습니다.</td>
                </tr>
        <%  } else { %>
                <tr align="center">
                    <td><%= mb.getMnum() %></td>
                    <td><%= mb.getMname() %></td>
                    <td><%= mb.getId() %></td>
                    <td><%= mb.getPassword() %></td>
                    <td><%= mb.getEmail1() %> @ <%= mb.getEmail2() %></td>
                    <td><%= mb.getRrn1() %> - <%= mb.getRrn2() %></td>
                    <td><%= mb.getPhone1() %> - <%= mb.getPhone2() %> - <%= mb.getPhone3() %></td>
                    <td><%= mb.getAddress1() %><br>
                        <%= mb.getAddress2() %>
                    </td>
                </tr>
        <%  } %>
</table>
<%  } %>
<%@ include file="../../bottom.jsp" %>
