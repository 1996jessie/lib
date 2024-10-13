<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp" %>  

<style type="text/css">
    /* 로그인 폼 스타일 */
    form.login-form {
        margin-top: 20px; /* 상단 여백 추가 */
        text-align: center; /* 내용 가운데 정렬 */
    }
    table.login-table {
        border-collapse: collapse;
        width: 50%;
        margin: auto; /* 가운데 정렬 */
    }
    table.login-table, th.login-table, td.login-table {
        border: 1px solid #ddd;
        padding: 8px;
    }
    input.text-input,
    input.password-input,
    input.submit-button,
    input.reset-button,
    input.back-button {
        padding: 6px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin: 4px;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    input.text-input,
    input.password-input {
        width: 70%;
    }
    input.submit-button {
        background-color: #007bff;
        color: white;
        cursor: pointer;
    }
    input.submit-button:hover {
        background-color: #0056b3;
    }
    input.reset-button,
    input.back-button {
        background-color: #6c757d;
        color: white;
        cursor: pointer;
    }
    input.reset-button:hover,
    input.back-button:hover {
        background-color: #495057;
    }
    a.link-button {
        text-decoration: none;
        color: #007bff;
        margin: 4px; /* 버튼 사이 간격 추가 */
    }
    a.link-button:hover {
        color: #0056b3;
    }
</style>



<form action="loginProc.jsp" method="post" class="login-form">
    <table border="1" align="center" class="login-table">
        <tr>
            <td>아이디</td>
            <td><input type="text" name="id" class="text-input"></td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td><input type="password" name="password" class="password-input"></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="확인" class="submit-button">
                <input type="reset" value="취소" class="reset-button">
                <input type="button" value="돌아가기" class="back-button">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <a href="findId.jsp" class="link-button">아이디 찾기</a>
                <a href="findPassword.jsp" class="link-button">비밀번호 찾기</a>
                <a href="../user/ManageAccount/canIInsert.jsp" class="link-button">회원가입하기</a>
            </td>
        </tr>
    </table>
</form>



<%@ include file = "../../bottom.jsp" %>