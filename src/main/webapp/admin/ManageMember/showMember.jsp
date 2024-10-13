<%@page import="reserve.ReserveBean"%>
<%@page import="reserve.ReserveDao"%>
<%@page import="borrow.BorrowBean"%>
<%@page import="borrow.BorrowDao"%>
<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>    

<style>
    .member-table {
        width: 90%;
        margin: auto;
        border-collapse: collapse;
    }

    .member-table caption {
        font-size: 1.2em;
        font-weight: bold;
        margin-bottom: 10px;
    }

    .member-table th, .member-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    .member-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .member-table tr:hover {
        background-color: #ddd;
    }

    .member-table td.action {
        white-space: nowrap;
    }

    .member-table .delete-link {
        color: red;
        cursor: pointer;
    }

    .member-table .delete-link:hover {
        text-decoration: underline;
    }
</style>

<script type="text/javascript">
    function checkDel(mnum) {
        var isDel = confirm("정말 삭제하시겠습니까?");
        if (isDel) {
            location.href = "deleteMemberByAdmin.jsp?mnum=" + mnum;
        } else {
            location.href = "showMember.jsp";
        }
    }
</script>

<table class="member-table">
    <caption>회원 목록</caption>
    <tr>
        <th>회원번호</th>
        <th>회원명</th>
        <th>회원 아이디</th>
        <th>회원 전화번호</th>
        <th>회원 주소</th>
        <th>대출 수</th>
        <th>예약 수</th>
        <th class="action">회원 제명</th>
    </tr>

    <%
        ArrayList<MemberBean> mlist = mdao.getAllMember();
        if(mlist.size() == 0) {
    %>
        <tr>
            <td colspan="8">등록된 회원이 없습니다.</td>
        </tr>
    <%
        } else {
            for(MemberBean mb : mlist) {
                BorrowDao brdao = BorrowDao.getInstance();
                ArrayList<BorrowBean> brlist = brdao.getAllBorrowedBookByMe(mb.getMnum());
                ReserveDao rdao = ReserveDao.getInstance();
                ArrayList<ReserveBean> rlist = rdao.getAllReservedBookByMe(mb.getMnum());
    %>
        <tr>
            <td><%= mb.getMnum() %></td>
            <td><%= mb.getMname() %></td>
            <td><%= mb.getId() %></td>
            <td><%= mb.getPhone1() %>-<%= mb.getPhone2() %>-<%= mb.getPhone3() %></td>
            <td><%= mb.getAddress1() %></td>
            <td><%= brlist.size() %></td>
            <td><%= rlist.size() %></td>
            <td class="action"><a href="javascript:checkDel('<%= mb.getMnum() %>')" class="delete-link"><input type = button value = "삭제"></a></td>
        </tr>
    <%
            }
        }
    %>
</table>

<%@include file="../../bottom.jsp" %>
