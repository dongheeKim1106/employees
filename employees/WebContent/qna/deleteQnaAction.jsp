<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo + " <--qnaNo");
	String qnaPw = request.getParameter("qnaPw");
	System.out.println(qnaPw + " <--qnaPw");
	
	// DB 연결 준비 및 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	System.out.println(conn + "<--conn");
	// 쿼리문 준비 후 저장
	PreparedStatement stmt = conn.prepareStatement("delete from employees_qna where qna_no=? and qna_pw=?");
	// ?값 입력
	stmt.setInt(1, qnaNo);
	stmt.setString(2, qnaPw);
	System.out.println(stmt + "  <--stmt");
	// 쿼리 결과 저장 1 or 0
	int row = stmt.executeUpdate(); 
	System.out.println(row + "<--row");
	// 성공 실패 여부를 확인
	if(row == 0) {
	%>
		<script>
			alert("비밀번호가 다릅니다.");
			document.location.href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qnaNo%>";
		</script>
	<%	
		return;
	} else {
		response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp");
	}
%>
