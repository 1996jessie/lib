<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="book.BookBean"%>
<%@page import="book.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
admin-ManageBook-updateBookProc.jsp<br>

<%

	String configFolder = config.getServletContext().getRealPath("admin/ManageBook/bookImage");
	MultipartRequest mr = new MultipartRequest(request, configFolder, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
	
    String newimage = mr.getFilesystemName("bimage");
    String orgbimage = mr.getParameter("orgbimage");
    int bnum = Integer.parseInt(request.getParameter("bnum"));
    String bbuydate = mr.getParameter("bbuydate");
    System.out.println("<admin-ManageBook-updateBookProc.jsp> bnum : " + bnum);
	System.out.println("<admin-ManageBook-updateBookProc.jsp> orgbimage : " + orgbimage);
	System.out.println("<admin-ManageBook-updateBookProc.jsp> bbuydate : " + bbuydate);
    String img = null;
    if(orgbimage == null) {
    	if(newimage != null) { 
    		//System.out.println("새 이미지 업로드");
    		img = newimage;
    	}else {
    		 //System.out.println("딱히 할 일 없음");
    	}
    } else {
    	if(newimage != null) {
    		//System.out.println("기존 파일 삭제 & 새 이미지 업로드");
    		img = newimage;
    		File delFile = new File(configFolder, orgbimage);
    		delFile.delete();
    	}else {
    		//System.out.println("기존 이미지 그대로 사용");
    		img = orgbimage;
    	}
    }
	
	BookDao bdao = BookDao.getInstance();
	int cnt = bdao.updateBook(mr,img);
	
	
	String msg;
	String url;
	if(cnt > 0) {
		int cnt2 = bdao.makeBcode(mr);
		if(cnt2 > 0) {
			msg = "update Book 성공";
			url = "showBook.jsp";
		} else {
			msg = "코드 수정 에러";
			url = "showBook.jsp";
		}
		
	} else {
		msg = "update Book 실패";
		url = "updateBook.jsp?bnum="+mr.getParameter("bnum");
	}
%>

	<script type="text/javascript">
		alert("<%= msg %>");
		location.href = "<%= url %>"
	</script> 
