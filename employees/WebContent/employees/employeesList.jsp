<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="gd.emp.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>EmployeesList</title>
	
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
		// searchWord 설정
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
	 	// 1. 페이지
	 	// 현재 페이지 값 저장 변수
	 	int currentPage = 1;
		// currentPage가 null 값을 받지 않으면 숫자형으로 변환
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// 목록수 변수 설정
		String pageOption="";
		if(request.getParameter("pageOption") != null) {
			pageOption = request.getParameter("pageOption");
		}
		System.out.println(pageOption + "<--pageOption");
		// 페이징 수
		int pagePerGroup = 10;
		// 한페이지에 볼수있는 행의 갯수
		int rowPerPage = 20;
		// 목록수 설정
		if(pageOption.equals("30")) {
			rowPerPage = 30;
		} else if(pageOption.equals("50")) {
			rowPerPage = 50;
		} else if(pageOption.equals("100")) {
			rowPerPage = 100;
		} else {
			rowPerPage = 20;
		}
		// 0부터 시작해야되기 때문에 1을 빼준다
		int beginRow = (currentPage-1)*rowPerPage;
		// 2.0 DB 연결
		Class.forName("org.mariadb.jdbc.Driver");
		// DB 연결 변수
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		// 쿼리를 저장할 변수
		PreparedStatement stmt1 = null;
		if(searchWord.equals("")) {
			// 쿼리 결과 저장 변수
			stmt1 = conn.prepareStatement("select emp_no, birth_date, concat(first_name,' ',last_name)as full_name, gender, hire_date from employees_employees order by emp_no asc limit ?,?");
			stmt1.setInt(1, beginRow);
			stmt1.setInt(2, rowPerPage);
		} else {
			// 쿼리 결과 저장 변수
			stmt1 = conn.prepareStatement("select emp_no, birth_date, concat(first_name,' ',last_name)as full_name, hire_date from employees_employees where first_name like? or last_name like ? order by emp_no asc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setString(2, "%"+searchWord+"%");
			stmt1.setInt(3, beginRow);
			stmt1.setInt(4, rowPerPage);
		}
		// 쿼리 저장
		ResultSet rs1 = null;
		// 쿼리를 결과를 rs1에 저장
		rs1 = stmt1.executeQuery(); // -> ArrayList<Departments> list 을 넘긴다
		// 2. 현재페이지의 employees 테이블 행
		// 현재페이지의 employees를 저장
		ArrayList<Employees> list = new ArrayList<Employees>();
		// rs1을 list로 옯기는 과정
		while(rs1.next()) {
			Employees e = new Employees();
			// 오른쪽의 값을 왼쪽에 저장
			e.empNo = rs1.getInt("emp_no");
			e.birthDate = rs1.getString("birth_date");
			e.firstName = rs1.getString("full_name");
			e.lastName = rs1.getString("full_name");
			e.gender = rs1.getString("gender");
			e.hireDate = rs1.getString("hire_date");
			// e를 list에 추가
			list.add(e);
		}
		// list의 사이즈 확인
		// System.out.println(list.size());
		// 3. employees 테이블 전체의 행
		// 마지막 페이지 저장 변수
		int lastPage = 0;
		// 전체 테이블 행 저장 변수
		int totalRow = 0;
		// 쿼리 저장 변수
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")) {
			// 행의 전체를 알려주는 쿼리
			stmt2 = conn.prepareStatement("select count(*) from employees_employees");
		} else {
			stmt2 = conn.prepareStatement("select count(*) from employees_employees where first_name like ? or last_name like ?");
			stmt2.setString(1, "%"+searchWord+"%");
			stmt2.setString(2, "%"+searchWord+"%");
		}
		// 쿼리 실행 저장 변수
		ResultSet rs2 = null;
		// 쿼리 실행후 변수에 저장
		rs2 = stmt2.executeQuery();
		// rs2 값을 totalRow에 저장
		if(rs2.next()) {
			// totalRow에는 전체 행수가 저장
			totalRow = rs2.getInt("count(*)");
		}
		// totalRow 를 rowPerPage 를 나눈값을 lastPage 에 저장
		lastPage = totalRow / rowPerPage;
		// 만약 나머지가 0이 아니면
		if(totalRow % rowPerPage != 0) {
			// lastPage에 1씩 추가
			lastPage += 1;
		}
		// 마지막 페이지확인
	
		// System.out.println(lastPage);
	%>
		<!-- 여기부터 태그부분 -->
		<div id="page-top"></div>
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
		<div class="container-fluid">
		<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
			<h1>EmployeesList</h1>
			<br>
			
			<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
			<div class="scroll-to-top position-fixed ">
				<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a> 
				<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom"> <i class="fa fa-chevron-down"></i></a>
			</div>
			<br>
			<!-- 부서 입력 -->
			<div>
				<a href="<%=request.getContextPath()%>/employees/insertEmployeesForm.jsp" class="btn btn-info" role="button">사원입력</a>
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
			<table class="table table-hover table-bordered text-center">
				<thead class="thead table-warning text-center">
					<tr>
						<th>emp_no</th>
						<th>birth_date</th>
						<th>full_name</th>
						<th>gender</th>
						<th>hire_date</th>
						<th>update</th>
						<th>delete</th>
					</tr>
				</thead>
				<tbody class="table-info">
					<%
						// list값을 e로 호출
						for(Employees e :list) {
					%>
						<tr>
							<td><%=e.empNo %></td>
							<td><%=e.birthDate %></td>
							<td><%=e.firstName%></td>
							<td><%=e.gender %></td>
							<td><%=e.hireDate %></td>
							<td><a href=""class="btn btn-primary" role="button" type="submit">수정</a></td>
							<td><a href="" class="btn btn-danger" role="button" type="submit">삭제</a></td>
						</tr>
					<%
						} // for문 종료
					%>
				</tbody>
			</table>
			<form method="post" action="<%=request.getContextPath()%>/employees.employees.jsp" class="d-flex justify-content-end">
					<input type="text" name="searchWord">
					<button type="submit">검색</button>
				</form>
			<ul class="pagination justify-content-center" style="margin:20px 0">
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음으로</a>
			</li>
			<%
				// currentPage가 1보다 크면 이전버튼이 나온다
				if(currentPage > 1) {
			%>
					<!-- 절대 주소 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
					</li>
			<%
				} // if문 종료
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
			       		<a class="page-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>"><%=i%></a>
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
			             	<a class="page-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%                
			        	}
			        }else{
			       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
			    	%>
			    		<li class="page-item">
			            	<a class="page-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%
			                }    
			            }
			        }        
			        
			    	%>
			<%
				// 총페이지수가 currentPage보다 크면 다음이 안나온다
				if(currentPage < lastPage) {
			%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/employees/employeesList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
					</li>
			<%
				} // if문 종료
			%>
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막으로</a>
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