<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file = "../../top.jsp"%>
<html>
<head>
    <title>비밀번호 찾기</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
    <style type="text/css">
        /* 테이블 스타일 */
        .form-table {
            border-collapse: collapse;
            width: 50%;
            margin: auto; /* 테이블 가운데 정렬 */
        }
        .form-table th, .form-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .form-table input[type="text"], 
        .form-table input[type="password"] {
            padding: 8px;
            width: 40%; /* 주민등록번호 입력 필드가 한 줄에 나오도록 조정 */
            box-sizing: border-box; /* 입력 필드의 내부 패딩까지 포함하여 너비 설정 */
        }
        .form-table input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            font-size: 16px;
            background-color: #007bff; /* 파란색 */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-table input[type="submit"]:hover {
            background-color: #0056b3; /* 파란색 어둡게 */
        }
        .form-table input[type="reset"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            font-size: 16px;
            background-color: #6c757d; /* 회색 */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-table input[type="reset"]:hover {
            background-color: #495057; /* 회색 어둡게 */
        }
        .form-table input[type="button"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            font-size: 16px;
            background-color: #28a745; /* 초록색 */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-table input[type="button"]:hover {
            background-color: #218838; /* 초록색 어둡게 */
        }
    </style>
</head>
<body>

<form action="findPasswordProc.jsp" method="post">
    <table class="form-table">
        <tr>
            <td>이름</td>
            <td><input type="text" name="mname"></td>
        </tr>
        <tr>
            <td>주민등록번호</td>
            <td>
                <input type="text" name="rrn1">-
                <input type="password" name="rrn2">
            </td>
        </tr>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" name="id">
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="확인">
                <input type="reset" value="취소">
                <input type="button" value="돌아가기">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
<%@include file = "../../bottom.jsp"%>