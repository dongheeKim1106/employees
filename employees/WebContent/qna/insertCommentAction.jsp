<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo + "<--qnaNo");
	String comment = request.getParameter("comment");
	System.out.println(comment + "<--comment");
	String commentPw = request.getParameter("commentPw");
	System.out.println(commentPw + "<--commentPw");
	// DB 연결 준비 및 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	// 쿼리문 준비 후 저장
	PreparedStatement stmt1 = conn.prepareStatement("select max(comment_no) from employees_qna_comment");
	System.out.println(stmt1 + "<--stmt1");
	ResultSet rs1 = stmt1.executeQuery();
	int commentNo = 1;
	if (rs1.next()) {
		commentNo = rs1.getInt("max(comment_no)") + 1;
	}
	// 입력
	PreparedStatement stmt2 = null;
	if(comment.equals("") && commentPw.equals("")) {
	%>
		<script>
			alert("빈 칸이 있습니다.");
			document.location.href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=qnaNo%>";
		</script>
	<%		
		return;
	} else {
		stmt2 = conn.prepareStatement("insert into employees_qna_comment(comment_no, qna_no, comment, comment_date, comment_pw) value (?,?,?,now(),?)");
		stmt2.setInt(1, commentNo);
		stmt2.setInt(2, qnaNo);
		stmt2.setString(3, comment);
		stmt2.setString(4, commentPw);
	}
	stmt2.executeUpdate();
	System.out.println(stmt2 + "<--stmt2");

	response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?qnaNo=" + qnaNo);
%>
