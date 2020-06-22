<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<%
		//인코딩 통일
		request.setCharacterEncoding("utf-8");
		// dept_no를 요청
		String deptNo = request.getParameter("dept_no");
		// 디버깅
		System.out.println(deptNo + "<--deptNo");
		// db 연결후 쿼리준비
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	 	stmt = conn.prepareStatement("delete from employees_departments where dept_no=?");
	 	stmt.setString(1, deptNo);
	 	
	 	stmt.executeUpdate();
	 	
	 	response.sendRedirect("./departmentsList.jsp");
	%>
</body>
</html>