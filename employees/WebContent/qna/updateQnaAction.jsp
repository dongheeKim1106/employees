<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="gd.emp.*" %>
<%
//인코딩 통일
	request.setCharacterEncoding("utf-8");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo +" <--qnaNo");
	String qnaTitle = request.getParameter("qnaTitle");
	System.out.println(qnaTitle +" <--qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	System.out.println(qnaContent +" <--qnaContent");
	String qnaUser = request.getParameter("qnaUser");
	System.out.println(qnaUser +" <--qnaUser");
	String qnaPw = request.getParameter("qnaPw");
	System.out.println(qnaPw +" <--qnaPw");

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	System.out.println(conn + "<-- conn");
	//qna_pw값을 제외한 나머지 값을 받음
	PreparedStatement stmt1 = conn.prepareStatement("update employees_qna set qna_title=?, qna_content=?, qna_user=? where qna_no=? and qna_pw=?");
	stmt1.setString(1, qnaTitle);
	stmt1.setString(2, qnaContent);
	stmt1.setString(3, qnaUser);
	stmt1.setInt(4, qnaNo);
	stmt1.setString(5, qnaPw);
	System.out.println(stmt1 + "<-- stmt1");
	int rows = stmt1.executeUpdate();
	if(rows == 0){
	%>
		<script>
			alert("비밀번호가 다릅니다");
			document.location.href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?&qnaNo=<%=qnaNo%>";
		</script>
	<%
	   return;
	}else{
	   response.sendRedirect(request.getContextPath()+"/qna/qnaList.jsp");
	}
%>
