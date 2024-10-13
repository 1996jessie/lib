<%@page import="member.MemberBean"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
updateMyAccountProc.jsp<br>

<%
    request.setCharacterEncoding("UTF-8");
    String mname = request.getParameter("mname");
    String rrn1= request.getParameter("rrn1");
    String rrn2 = request.getParameter("rrn2");
    
    String newPassword = request.getParameter("newPassword");
    String oldPassword = request.getParameter("oldPassword");
    String email1 = request.getParameter("email1");
    String email2 = request.getParameter("email2");
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String address1 = request.getParameter("address1");
    String address2 = request.getParameter("address2");
    
    
    System.out.println("newPassword : " + newPassword);
    System.out.println("oldPassword : " + oldPassword);

    String password = null;
    if(newPassword != null && !newPassword.isEmpty()) {
        password = newPassword;
    } else {
        // 비밀번호가 변경되지 않았을 때 이전 비밀번호를 사용하도록 설정
        password = oldPassword;
    }
    
    
    MemberBean mb = new MemberBean();
    mb.setMname(mname);
    mb.setRrn1(rrn1);
    mb.setRrn2(rrn2);
    mb.setPassword(password);
    mb.setEmail1(email1);
    mb.setEmail2(email2);
    mb.setPhone1(phone1);
    mb.setPhone2(phone2);
    mb.setPhone3(phone3);
    mb.setAddress1(address1);
    mb.setAddress2(address2);
    
    MemberDao mdao = MemberDao.getInstance();
    
    System.out.println("<updateMyAccountProc.jsp> mb.getPassword() : " + mb.getPassword());
    System.out.println();
    int cnt = mdao.updateMember(mb);

    String msg;
    String url;
    
    if(cnt > 0) {
        msg = "member update 성공";
        url = "showMyAccount.jsp?id="+mb.getId()+"&password="+mb.getPassword();
        session.getAttribute("password");
    } else {
        msg = "member update 실패";
        url = "updateMyAccountForm.jsp?id="+mb.getId()+"&password2="+mb.getPassword();
    }
%>
    <script type="text/javascript">
        alert("<%= msg %>");
        location.href = "<%= url %>"
    </script> 
