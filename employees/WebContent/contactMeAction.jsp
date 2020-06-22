<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	// 인코딩 통일
	request.setCharacterEncoding("utf-8");
	// form 에서 값을 요청후 확인
	String name = request.getParameter("name");
	System.out.println(name + "<--name");
	String email = request.getParameter("email");
	System.out.println(email + "<--email");
	String phone = request.getParameter("phone");
	System.out.println(phone + "<--phone");
	String message = request.getParameter("message");
	System.out.println(message + "<--message");
	
	// DB 연결 및 쿼리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	PreparedStatement stmt = conn.prepareStatement("insert into employees_contact (name,email,phone,message) VALUES (?,?,?,?)");
	stmt.setString(1,name);
	stmt.setString(2,email);
	stmt.setString(3,phone);
	stmt.setString(4,message);
	// 쿼리 실행
	stmt.executeUpdate();
	// home으로 이동
	response.sendRedirect("./index.jsp");
%>