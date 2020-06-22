<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
</head>
<body>
	<%
		// 인코딩 통일
		request.setCharacterEncoding("UTF-8");
		// 열 : dept_no, dept_name
		// dept_no ?
		// dept_no를 구하는 알고리즘
		// 드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 커넥션
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		System.out.println(conn);
		// 쿼리 구하기
		PreparedStatement stmt = null;
		stmt = conn.prepareStatement("select dept_no from employees_departments order by dept_no desc limit 0,1"); // select max(dept_no) from departments
		System.out.println(stmt);
		// 쿼리 결과값을 rs가 가르키는 곳으로 저장
		ResultSet rs = null;
		rs = stmt.executeQuery();
		System.out.println(rs);
		// dept_no를 받는 변수 선언 (String은 특수하기 때문에 null 대신 문자열로 받는게 좋다)
		String deptNo = "";
		// rs를 받는다면
		if(rs.next()) {
			deptNo = rs.getString("dept_no");
		}
		System.out.println(deptNo);
		
		// d를 자르는 과정
		// deptNo의 첫번째를 자르는 방법
		String deptNo2 = deptNo.substring(1);
		System.out.println(deptNo2);
		// deptNo2를 숫자열로 변환해 deptNo3에 저장
		int deptNo3 = Integer.parseInt(deptNo2);
		System.out.println(deptNo3);
		// deptNo3 + 1 을 nextDeptNo에 저장
		int nextDeptNo = deptNo3 + 1;
		System.out.println(nextDeptNo);
		
		String nextDeptNo2 = "";
		
		// 100으로 나눠서 0보다 크면 (100이상의 숫자)
		if(nextDeptNo/100 > 0) {
			nextDeptNo2 = "d" + nextDeptNo;
		// 10으로 나눠서 0보다 크면 (10이상의 숫자)
		} else if(nextDeptNo/10 >0) {
			nextDeptNo2 = "d0" + nextDeptNo;
		// 그외 나머지
		} else {
			nextDeptNo2 = "d00" + nextDeptNo;
		}
		System.out.println(nextDeptNo2);
		
		// deptName 요청
		String deptName = request.getParameter("deptName");
		// stmt2 선언
		PreparedStatement stmt2 = null;
		%>
		<%
		if(deptName.equals("")){
		%>
			<script>
				alert("내용을 입력하세요");
				document.location.href="<%=request.getContextPath()%>/departments/insertDepartmentsForm.jsp";
			</script>
		<%
			return;
		} else {
			// 2번째 쿼리
			stmt2 = conn.prepareStatement("insert into employees_departments(dept_no, dept_name) values(?,?)");
			// ? 값
			stmt2.setString(1, nextDeptNo2);
			stmt2.setString(2, deptName);
			System.out.println(stmt2);
		}
		// 쿼리 실행후 업데이트
		stmt2.executeUpdate();
		// 절대주소로 실행후 넘어감
		response.sendRedirect(request.getContextPath()+"/departments/departmentsList.jsp");
	%>
</body>
</html>