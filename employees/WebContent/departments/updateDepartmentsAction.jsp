<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="gd.emp.*" %>
<%
	// 인코딩 통일
	request.setCharacterEncoding("utf-8");
	// 수정 값 받아오기
	String deptNo = request.getParameter("deptNo");
	// 디버깅
	System.out.println(deptNo +"<--deptNo");
	String deptName = request.getParameter("deptName");
	// 디버깅
	System.out.println(deptName +"<--deptName");
	
	// DB 연결 후 쿼리설정 밑 적용
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	System.out.println(conn + "<-- conn");
	PreparedStatement stmt1 = conn.prepareStatement("update employees_departments set dept_name=? where dept_no=?");
	stmt1.setString(1, deptName);
	stmt1.setString(2, deptNo);
	System.out.println(stmt1 + "<-- stmt1");
	stmt1.executeUpdate();
	response.sendRedirect(request.getContextPath()+"/departments/departmentsList.jsp");
%>