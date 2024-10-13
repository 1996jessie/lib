<%@page import="book.BookDao"%>
<%@page import="book.BookBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>



<script type="text/javascript">
    function allCheck(obj) {
        var checkThis = document.getElementsByName("checkThis");
        var check = obj.checked;
        if (check) {
            for (var i = 0; i < checkThis.length; i++) {
                checkThis[i].checked = true;
            }
        } else {
            for (var i = 0; i < checkThis.length; i++) {
                checkThis[i].checked = false;
            }
        }
    }

    function deleteThese() {
        var checkThis = document.getElementsByName("checkThis");
        var flag = false;
        for (var i = 0; i < checkThis.length; i++) {
            if (checkThis[i].checked) {
                flag = true;
            }
        }
        if (flag == false) {
            alert("삭제할 항목을 1개 이상 선택하세요.");
            return;
        }
        document.deleteForm.submit();
    }
</script>
<style type="text/css">
    /* 테이블 스타일 */
    table {
        border-collapse: collapse;
        width: 90%;
        margin: 20px auto; /* 가운데 정렬 */
        background-color: #f9f9f9; /* 배경색 추가 */
    }
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #007bff; /* 헤더 배경색 */
        color: white; /* 헤더 글자색 */
    }
    tr:nth-child(even) {
        background-color: #f2f2f2; /* 짝수 행 배경색 */
    }
    /* 버튼 스타일 */
    input[type="submit"],
    input[type="button"] {
        padding: 8px 16px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    input[type="submit"]:hover,
    input[type="button"]:hover {
        background-color: #0056b3;
    }
    
        .year-select-container {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 20px;
    }

    .select-label {
        margin-right: 10px;
        font-size: 16px;
    }

    .year-select {
        padding: 5px;
        font-size: 16px;
    }

    .search-button {
        padding: 5px 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        font-size: 16px;
    }

    .search-button:hover {
        background-color: #0056b3;
    }
</style>

<form action="showBookByBpubyear.jsp" method="post">
    <div class="year-select-container">
        <label for="bpubyear" class="select-label">출간년도 선택</label>
        <select name="bpubyear" id="bpubyear" class="year-select">
            <% for (int i = 2024; i >= 1970; i--) { %>
                <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>
        년
        <input type="submit" value="도서 조회" class="search-button">
    </div>
</form>


<%
    int i;
    BookDao bdao = BookDao.getInstance();
%>

<%
    request.setCharacterEncoding("UTF-8");
    String bpubyear = request.getParameter("bpubyear");
    int blendcount = 0;
    try {
        blendcount = Integer.parseInt(request.getParameter("blendcount"));
    } catch (NumberFormatException e) {

    }
    System.out.println("<deleteBookByBpubyear.jsp> bpubyear : " + bpubyear + ", blendcount : " + blendcount);
    ArrayList<BookBean> blist = bdao.getBookByBpubyear(bpubyear);
%>
<form name="deleteForm" action="deleteBookByBpubyear.jsp" method="post">
    <table class="result-table" align="center" width="90%" border="1">

        <% if (blist.size() > 0) {
            String requestDir = request.getContextPath() + "/admin/ManageBook/bookImage";
        %>
            <tr>

                <td colspan="11" align="center">
                    <%= bpubyear %>년 구매 도서 목록
                    <input type="button" value="삭제" onclick="deleteThese()">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="checkbox" name="checkAll" onclick="allCheck(this)">
                </td>
                <td>도서명</td>
                <td>저자</td>
                <td>대분류</td>
                <td>소분류</td>
                <td>코드</td>
                <td>도서 사진</td>
                <td>발간년도</td>
                <td>구매일</td>
                <td>대출횟수</td>
            </tr>

            <%
                for (BookBean bb : blist) {
            %>
                <tr>
                    <td><input type="checkbox" name="checkThis" value="<%= bb.getBnum() %>"></td>
                    <td><%= bb.getBtitle() %></td>
                    <td><%= bb.getBauthor() %></td>
                    <td>
                        <%
                            int cnum = Integer.parseInt(bb.getBcategory());
                            String[] category = {"---", "총류", "철학", "종교", "사회과학", "자연과학", "기술과학", "예술", "언어", "문학", "역사"};
                        %>
                        <%= category[cnum / 100 + 1] %>
                    </td>
                    <td>
                        <%
                            int snum = Integer.parseInt(bb.getScategory());
                            String[][] scategory = {
                                    {"---", "도서학", "문헌정보학", "백과사전", "강연집", "일반연속간행물", "일반 학회", "신문", "일반 전집", "향토자료"},
                                    {"---", "형이상학", "인식론", "철학의세계", "경학", "동양철학", "서양철학", "논리학", "심리학", "윤리학"},
                                    {"---", "비교종교학", "불교", "기독교", "도교", "천도교", "없음", "힌두교", "이슬람교", "기타 제종교"},
                                    {"---", "통계학", "경제학", "사회학", "정치학", "행정학", "법학", "교육학", "풍속", "국방"},
                                    {"---", "수학", "물리학", "화학", "천문학", "지학", "광물학", "생명과학", "식물학", "동물학"},
                                    {"---", "의학", "농업", "공학", "건축공학", "기계공학", "전기공학", "화학공학", "제조업", "생활과학"},
                                    {"---", "건축술", "조각및조형미술", "공예", "서예", "회화", "사진예술", "음악", "공연예술", "오락"},
                                    {"---", "한국어", "중국어", "일본어", "영어", "독일어", "프랑스어", "스페인어", "이탈리아어", "기타제어"},
                                    {"---", "한국문학", "중국문학", "일본문학", "영미문학", "독일문학", "프랑스문학", "스페인및포르투갈문학", "이탈리아문학", "기타제문학"},
                                    {"---", "아시아", "유럽", "아프리카", "북아메리카", "남아메리카", "오세아니아", "양극지방", "지리", "전기"}
                            };
                        %>
                        <%= scategory[cnum / 100][snum / 10] %>
                    </td>
                    <td><%= bb.getBcode() %></td>
                    <td>
                        <img src="<%= requestDir + "/" + bb.getBimage() %>" width="50" height="50">
                    </td>
                    <td><%= bb.getBpubyear() %></td>
                    <td><%= bb.getBbuydate() %></td>
                    <td><%= bb.getBlendcount() %></td>
                </tr>
            <%
                }
            %>

        <% } else { %>
            <tr>
                <td align="center">해당 연도 발간 도서가 없습니다.</td>
            </tr>
        <% } %>

    </table>
</form>
<%@include file="../../bottom.jsp" %>
