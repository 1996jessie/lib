<%@page import="java.text.SimpleDateFormat"%>
<%@page import="article.ArticleBean"%>
<%@page import="article.ArticleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>

<style type="text/css">
    /* 테이블 스타일 */
    .article-table {
        border-collapse: collapse;
        width: 80%;
        margin: auto;
    }
    .article-table th, .article-table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    /* 버튼 스타일 */
    .article-button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        margin: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .article-button-primary {
        background-color: #007bff; /* 파란색 */
        color: white;
    }
    .article-button-secondary {
        background-color: #6c757d; /* 회색 */
        color: white;
    }
    .article-button-success {
        background-color: #28a745; /* 초록색 */
        color: white;
    }
    .article-button:hover {
        filter: brightness(90%);
    }
</style>

<script type="text/javascript">
    function checkDel(anum, pageNum, aname) {
        alert(anum + "," + pageNum + "," + aname);
        var isDel = confirm("정말 삭제하시겠습니까?");
        alert(isDel);
        if(isDel) {
            location.href = "deleteArticle.jsp?anum="+anum+"&pageNum="+pageNum+"&aname="+aname;
        } else {
            location.href = "showArticle.jsp";
        }
    }
</script>

<%
    int anum = Integer.parseInt(request.getParameter("anum"));
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
    
    System.out.println("<showArticle.jsp> anum : " + anum + ", pageNum : " + pageNum);

    ArticleDao adao = ArticleDao.getInstance();
    ArticleBean ab = adao.getThisArticle(anum);
    System.out.println("ab.getCheckPrivacy()" + ab.getCheckPrivacy());
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    int aref = ab.getAref();
    int astep = ab.getAstep();
    int alevel = ab.getAlevel();
    System.out.println("<showArticle.jsp>부모가 넘길 aref : " + aref + ", 부모의 astep : " + astep + ", 부모의 alevel : " + alevel);
    String msg= null;
    String url = null;
    int[] arefArray = adao.getArticleAref(mname);
    for(int i=0;i<arefArray.length;i++) {
        System.out.println(arefArray[i]);
    }
    
    boolean isArefMatched = false;
    for (int i = 0; i < arefArray.length; i++) {
        if (aref == arefArray[i]) {
            isArefMatched = true;
            break;
        }
    }
    
    if(ab.getCheckPrivacy().equals("NO")) {
        if(ab.getAname().equals(mname) || mname.equals("관리자") || isArefMatched) {
%>
            <table class="article-table">
                <tr>
                    <th>글 번호</th>
                    <td><%= ab.getAnum() %></td>
                    <th>조회수</th>
                    <td><%= ab.getAreadcount() %></td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><%= ab.getAname() %></td>
                    <th>작성일</th>
                    <td><%= ab.getAdate() %></td>
                </tr>
                <tr>
                    <th>글 제목</th>
                    <td colspan="3"><%= ab.getAtitle() %></td>
                </tr>
                <tr>
                    <th>글 내용</th>
                    <td colspan="3"><%= ab.getAcontent() %></td>
                </tr>
                <tr>
                    <td colspan="4" align="right">
                        <input type="button" class="article-button article-button-primary" value="글 수정" onclick="location.href='updateArticle.jsp?anum=<%= ab.getAnum() %>&pageNum=<%= pageNum %>'">
                        <input type="button" class="article-button article-button-secondary" value="글 삭제" onclick="javascript:checkDel('<%= ab.getAnum() %>','<%= pageNum %>','<%= ab.getAname() %>')">
                        <input type="button" class="article-button article-button-secondary" value="답글 쓰기" onclick="location.href='replyArticle.jsp?anum=<%= ab.getAnum() %>&pageNum=<%= pageNum %>&aref=<%= ab.getAref() %>&astep=<%= ab.getAstep() %>&alevel=<%= ab.getAlevel() %>&checkPrivacy=<%= ab.getCheckPrivacy() %>'">
                        <input type="button" class="article-button article-button-success" value="글 목록" onclick="location.href='articleList.jsp?pageNum=<%= pageNum %>'">
                    </td>
                </tr>
            </table>
<%          
        } else {
            msg = "비밀글은 작성자와 관리자만 읽을 수 있습니다.";
            url = "articleList.jsp?pageNum="+pageNum;
%>
            <script type="text/javascript">
                alert("<%= msg %>");
                location.href = '<%= url %>';
            </script> 
<%         }
    } else {
%>  
        <table class="article-table">
            <tr>
                <th>글 번호</th>
                <td><%= ab.getAnum() %></td>
                <th>조회수</th>
                <td><%= ab.getAreadcount() %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%= ab.getAname() %></td>
                <th>작성일</th>
                <td><%= ab.getAdate() %></td>
            </tr>
            <tr>
                <th>글 제목</th>
                <td colspan="3"><%= ab.getAtitle() %></td>
            </tr>
            <tr>
                <th>글 내용</th>
                <td colspan="3"><%= ab.getAcontent() %></td>
            </tr>
            <tr>
                <td colspan="4" align="right">
                    <input type="button" class="article-button article-button-primary" value="글 수정" onclick="location.href='updateArticle.jsp?anum=<%= ab.getAnum() %>&pageNum=<%= pageNum %>'">
                    <input type="button" class="article-button article-button-secondary" value="글 삭제" onclick="javascript:checkDel('<%= ab.getAnum() %>','<%= pageNum %>','<%= ab.getAname() %>')">
                    <input type="button" class="article-button article-button-secondary" value="답글 쓰기" onclick="location.href='replyArticle.jsp?anum=<%= ab.getAnum() %>&pageNum=<%= pageNum %>&aref=<%= ab.getAref() %>&astep=<%= ab.getAstep() %>&alevel=<%= ab.getAlevel() %>&checkPrivacy=<%= ab.getCheckPrivacy() %>'">
                    <input type="button" class="article-button article-button-success" value="글 목록" onclick="location.href='articleList.jsp?pageNum=<%= pageNum %>'">
                </td>
            </tr>
        </table>
<%      
    }
%>

<%@include file="../../bottom.jsp" %>
