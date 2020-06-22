<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	//request 인코딩 설정
	request.setCharacterEncoding("utf-8");
	//request 매개값 설정(ip, title, content, user.pw)
	String qnaIp = request.getRemoteAddr();
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaUser = request.getParameter("qnaUser");
	String qnaPw = request.getParameter("qnaPw");
	// 매게값 공백이 있으면 폼으로 되돌려 보낸다 (ck 추가)
	if (qnaTitle.equals("") || qnaContent.equals("") || qnaUser.equals("") || qnaPw.equals("")) {
		response.sendRedirect(request.getContextPath() + "/qna/insertQnaForm.jsp?ck=fail");
		return; // 코드진행 (명령) 을 끝낸다
	}

	System.out.println(qnaIp + "<--ip");
	System.out.println(qnaTitle + "<--title");
	System.out.println(qnaContent + "<--Content");
	System.out.println(qnaUser + "<--User");
	System.out.println(qnaPw + "<--Pw");

	// qnaNo
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	System.out.println(conn + "<--conn");
	PreparedStatement stmt1 = conn.prepareStatement("select max(qna_no) from qna");
	System.out.println(stmt1 + "<--stmt1");
	ResultSet rs1 = stmt1.executeQuery();
	System.out.println(rs1 + "<--rs1");
	// rs1에 값이 있으면 qnaNo 그 값의 +1
	// rs1에 값이 없으면 qnaNo = 1
	int qnaNo = 1;
	if (rs1.next()) {
		qnaNo = rs1.getInt("max(qna_no)") + 1;
	}
	System.out.println(qnaNo + "<--qnaNo");
	// qnaDate : sql문에서 now() 함수 사용
	/*
			insert into qna(qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date)
			values(?,?,?,?,?,now())
	*/
	// 쿼리2 준비
	PreparedStatement stmt2 = conn.prepareStatement("insert into employees_qna(qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip) values (?,?,?,?,?,now(),?)");
	stmt2.setInt(1, qnaNo);
	stmt2.setString(2, qnaTitle);
	stmt2.setString(3, qnaContent);
	stmt2.setString(4, qnaUser);
	stmt2.setString(5, qnaPw);
	stmt2.setString(6, qnaIp);
	stmt2.executeUpdate();
	response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp");
%>