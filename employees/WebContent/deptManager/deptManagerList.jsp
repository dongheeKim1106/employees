<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="gd.emp.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>DeptEmpList</title>
	
	<!-- Custom fonts for this theme -->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	
	<!-- Theme CSS -->
	<link href="css/freelancer.min.css" rel="stylesheet">
</head>
<body>
	<%
		// 자바 코드
		// encoding 통일
		request.setCharacterEncoding("UTF-8");
		// seachWord 설정
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
		// 목록수 변수 설정
		String pageOption="";
		if(request.getParameter("pageOption") != null) {
			pageOption = request.getParameter("pageOption");
		}
		System.out.println(pageOption + "<--pageOption");
		// 첫번째 페이지를 담을 변수
		int currentPage = 1;
		// 값이 null 값이 아니면 숫자로 변환
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println(currentPage);
		// 한페이지의 목록을 받을 변수
		int rowPerPage = 10;
		// 목록수 설정
		if(pageOption.equals("30")) {
			rowPerPage = 30;
		} else if(pageOption.equals("50")) {
			rowPerPage = 50;
		} else if(pageOption.equals("100")) {
			rowPerPage = 100;
		} else {
			rowPerPage = 10;
		}
		// 알고리즘
		int beginRow = (currentPage-1)*rowPerPage;
		System.out.println(beginRow);
		// DB 연결
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		System.out.println(conn);
		// 쿼리 문 변수
		PreparedStatement stmt1 = null;
		if(searchWord.equals("")) {
			stmt1 = conn.prepareStatement("select dm.dept_no, d.dept_name, dm.emp_no, concat(e.first_name,' ',e.last_name) as full_name, dm.from_date, dm.to_date from employees_dept_manager dm inner join employees_departments d inner join employees_employees e on dm.dept_no = d.dept_no and dm.emp_no = e.emp_no order by emp_no asc limit ?,?");
			// ? 값
			stmt1.setInt(1, beginRow);
			stmt1.setInt(2, rowPerPage);
		} else {
			stmt1 = conn.prepareStatement("select dm.dept_no, d.dept_name, dm.emp_no, concat(e.first_name,' ',e.last_name) as full_name, dm.from_date, dm.to_date from employees_dept_manager dm inner join employees_departments d inner join employees_employees e on dm.dept_no = d.dept_no and dm.emp_no = e.emp_no where dept_no like ? order by emp_no asc limit ?,?");
			// ? 값
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		}
		// 쿼리 결과 변수
		ResultSet rs1 = null;
		System.out.println(stmt1);
		// 쿼리 진행
		rs1 = stmt1.executeQuery();
		System.out.println(rs1);
		// rs -> list
		ArrayList<DeptManagerInner> list = new ArrayList<DeptManagerInner>();
		while(rs1.next()) {
			DeptManagerInner d = new DeptManagerInner();
			d.deptNo = rs1.getString("dept_no");
			d.deptName = rs1.getString("dept_name");
			d.empNo = rs1.getInt("emp_no");
			d.firstName = rs1.getString("full_name");
			d.lastName = rs1.getString("full_name");
			d.fromDate = rs1.getString("from_date");
			d.toDate = rs1.getString("to_date");
			list.add(d);
		}
		// 페이징 수
		int pagePerGroup = 10;
		// 마지막 페이지
		int lastPage = 0;
		// 총 행의 갯수
		int totalRow = 0;
		// 2번째 쿼리
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")) {
			stmt2 = conn.prepareStatement("select count(*) from employees_dept_manager");
		} else {
			stmt2 = conn.prepareStatement("select count(*) from employees_dept_manager where dept_no like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		}
		// 2번째 쿼리 결과
		ResultSet rs2 = null;
		rs2 = stmt2.executeQuery();
		System.out.println(stmt2);
		System.out.println(rs2);
		// 값을 받으면 totalRow 에 전체 행 저장
		if(rs2.next()) {
			totalRow = rs2.getInt("count(*)");
		}
		// 마지막 페이지 
		lastPage = totalRow / rowPerPage;
		// 만약 0으로 나누어 지지 않으면 페이지 1추가
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		System.out.println(lastPage);
	%>
	<!-- 태그 부분 -->
	<div id="page-top"></div>
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:80px">
	<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
		<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
		<div class="scroll-to-top position-fixed ">
			<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a> 
			<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom"> <i class="fa fa-chevron-down"></i></a>
		</div>
		<h1>DeptManagerList</h1>
		<br>
		<div>
			<a href="" class="btn btn-info" role="button">입력</a>
		</div>
		<br>
		<!-- 목록수 제어 Form -->
		<form method="post" action="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp">	
		    <div class="d-flex justify-content-end">
		    <select name="pageOption">
		    	<option value="">보기</option>
				<option value="30">30개씩 보기</option>
				<option value="50">50개씩 보기</option>
				<option value="100">100개씩 보기</option>
			</select>
			<button type="submit">보기</button>
			</div>
		</form>
		<br>
		<table class="table table-dark table-hover table-bordered text-center">
			<thead class="thead-light text-center">
				<tr>
					<th>dept_no</th>
					<th>dept_name</th>
					<th>emp_no</th>
					<th>full_name</th>
					<th>from_date</th>
					<th>to_date</th>
					<th>update</th>
					<th>delete</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(DeptManagerInner d : list) {
				%>
						<tr>
							<td><%=d.deptNo%></td>
							<td><%=d.deptName%></td>
							<td><%=d.empNo%></td>
							<td><%=d.firstName%></td>
							<td><%=d.fromDate%></td>
							<td><%=d.toDate%></td>
							<td><a href=""class="btn btn-primary" role="button">수정</a></td>
							<td><a href=""class="btn btn-danger" role="button">삭제</a>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<form method="post" action="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp" class="d-flex justify-content-end">
			<input type="text" name="searchWord">
			<button type="submit">검색</button>
		</form>
		<ul class="pagination justify-content-center" style="margin:20px 0">
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음으로</a>
			</li>	
			<%
				if(currentPage > 1) {
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/deptManager/deptManagerList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>	</li>
			<%
				}
			%>
			<%
				//1~10page 그룹 시작페이지
				int groupStartPage = 0;    // 0=1~10페이지        1=11~20페이지
			 	//하단 1~10 페이지 출력
	        	//페이지 그룹으로 총 10 * x개의 그룹 확인
	        	//10의 배수일 경우  - 1
	        	if(currentPage % pagePerGroup == 0){
	         	groupStartPage = currentPage / pagePerGroup - 1;
	            //System.out.println(groupStartPage);
	            for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
    		%>
	    		<li class="page-item">
	       		<a class="page-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=i%>"><%=i%></a>
	    		</li>
	    	<%
	        	}
	        }else{
	            groupStartPage = currentPage / pagePerGroup;
	            //System.out.println(groupStartPage);
	            if(lastPage < (groupStartPage*10)+10){
	            for(int i=(groupStartPage*10)+1; i<=lastPage; i=i+1){
	    	%>
	    		<li class="page-item">
	             	<a class="page-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=i%>"><%=i%></a>
	   			</li>
	    	<%                
	        	}
	        }else{
	       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
	    	%>
	    		<li class="page-item">
	            	<a class="page-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=i%>"><%=i%></a>
	   			</li>
	    	<%
	                }    
	            }
	        }        
	        
	    	%>
			<%
				if(currentPage < lastPage) {
			%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/deptManager/deptManagerList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a></li>
			<%
				}
			%>
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막으로</a>
			</li>
		</ul>
		<div class="col-xl-2"></div>
		</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript -->
	  <script src="vendor/jquery/jquery.min.js"></script>
	  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	  <!-- Plugin JavaScript -->
	  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
	
	  <!-- Contact Form JavaScript -->
	  <script src="js/jqBootstrapValidation.js"></script>
	  <script src="js/contact_me.js"></script>
	
	  <!-- Custom scripts for this template -->
	  <script src="js/freelancer.min.js"></script>
	<div id="page-bottom"></div>
</body>
</html>