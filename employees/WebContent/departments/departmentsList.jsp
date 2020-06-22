<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="gd.emp.*" %>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>DepartmentsList</title>
	
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
	// 자바 코드부분
	// encoding 통일
	request.setCharacterEncoding("UTF-8");
	// 1. 페이지
	// searchWord 설정
	String searchWord = "";
	if(request.getParameter("searchWord") != null) {
		searchWord = request.getParameter("searchWord");
	}
	System.out.println(searchWord+"<--searchWord");
	// 목록수 변수 설정
	String pageOption="";
	if(request.getParameter("pageOption") != null) {
		pageOption = request.getParameter("pageOption");
	}
	System.out.println(pageOption + "<--pageOption");
	// 현재 페이지 값 저장 변수
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 페이징 수
	int pagePerGroup = 10;
	// 한 페이지에 몇행씩 볼것인지
	int rowPerPage = 5;
	// 목록수 설정
	if(pageOption.equals("30")) {
		rowPerPage = 30;
	} else if(pageOption.equals("50")) {
		rowPerPage = 50;
	} else if(pageOption.equals("100")) {
		rowPerPage = 100;
	} else {
		rowPerPage = 5;
	}
	// 0부터 시작해야되기 때문에 1을 빼준다
	int beginRow = (currentPage-1)*rowPerPage;
	// 2.0 DB 연결
	Class.forName("org.mariadb.jdbc.Driver");
	// DB연결 변수선언
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	// 쿼리를 저장할 변수
	PreparedStatement stmt1 = null;
	if(searchWord.equals("")) {
		stmt1 = conn.prepareStatement("select dept_no, dept_name from employees_departments order by dept_no asc limit ?,?");
		// ?에 들어갈 값들
		stmt1.setInt(1, beginRow);
		stmt1.setInt(2, rowPerPage);
	} else {
		stmt1 = conn.prepareStatement("select dept_no, dept_name from employees_departments where dept_name like ? order by dept_no asc limit ?,?");
		// ?에 들어갈 값들
		stmt1.setString(1, "%"+searchWord+"%");
		stmt1.setInt(2, beginRow);
		stmt1.setInt(3, rowPerPage);
	}
	// 쿼리를 실행하여 결과값을 저장할 변수
	ResultSet rs1 = null;
	// 쿼리를 결과를 rs1에 저장
	rs1 = stmt1.executeQuery(); // -> ArrayList<Departments> list 을 넘긴다
	// 2. 현재페이지의 departments 테이블 행들
	// 현재페이지의 Departsments의 행들을 저장하기 위해
	ArrayList<Departments> list = new ArrayList<Departments>();
	// rs1에 있는 값을 list로 옮겨가는 알고리즘
	while(rs1.next()) {
		Departments d = new Departments();
		// dept_no 을 d.deptNo 에 저장 
		d.deptNo = rs1.getString("dept_no");
		// dept_name 을 d.deptName에 저장
		d.deptName = rs1.getString("dept_name");
		// d를 list에 추가한다
		list.add(d);
	}
	// list의 사이즈를 확인하는 디버깅
	System.out.println(list.size() + "<--list.size()");
	// 3. departments 테이블 전체행 수
	// 마지막 페이지 저장 변수
	int lastPage = 0;
	// 테이블 전체 행수를 저장하는 변수
	int totalRow = 0;
	// 쿼리를 저장할 변수
	PreparedStatement stmt2 = null;
	if(searchWord.equals("")) {
		// 행의 전체를 알려주는 쿼리
		stmt2 = conn.prepareStatement("select count(*) from employees_departments");
	} else {
		stmt2 = conn.prepareStatement("select count(*) from employees_departments where dept_name like ?");
		stmt2.setString(1, "%"+searchWord+"%");
	}
	// 쿼리를 실행하여 결과값을 저장할 변수
	ResultSet rs2 = null;
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
	System.out.println(lastPage);
%>
	<div id="page-top"></div>
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	<div class="container-fluid">
	<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
		<h1>departmentsList</h1>
		<br>

		<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
		<div class="scroll-to-top position-fixed ">
			<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a> 
			<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom"> <i class="fa fa-chevron-down"></i></a>
		</div>
		<div>
			<!-- 부서 입력 -->
			<a href="<%=request.getContextPath()%>/departments/insertDepartmentsForm.jsp" class="btn btn-info" role="button">부서입력</a>
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
		<!-- 부서 리스트 -->
		<table class="table table-dark table-hover table-bordered text-center">
			<thead class="thead-light text-center">
				<tr>
					<th>dept_no</th>
					<th>dept_name</th>
					<th>update</th>
					<th>delete</th>
				</tr>
			</thead>
			<tbody>
				<%
					// list에 있던값을 d로 호출
					for(Departments d : list) {
				%>
						<tr>
							<td><%=d.deptNo%></td>
							<td><%=d.deptName%></td>
							<td><a href="<%=request.getContextPath()%>/departments/updateDepartmentsForm.jsp?dept_no=<%=d.deptNo%>"class="btn btn-primary" role="button" type="submit">수정</a></td>
							<td><a href="<%=request.getContextPath()%>/departments/deleteDepartmentsAction.jsp?dept_no=<%=d.deptNo%>"class="btn btn-danger" role="button" type="submit">삭제</a></td>
						</tr>
				<% 		
					}
				%>
			</tbody>
		</table>
		<form method="post" action="<%=request.getContextPath()%>/departments/departmentsList.jsp" class="d-flex justify-content-end">
			<input type="text" name="searchWord">
			<button type="submit">부서 검색</button>
		</form>
		<ul class="pagination justify-content-center" style="margin:20px 0">
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음으로</a>
		</li>
			<%
				// currentPage가 1보다 크면 이전버튼이 나온다
				if(currentPage > 1) {
			%>
					<!-- 절대 주소 사용 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
					</li>
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
			       		<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>"><%=i%></a>
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
			             	<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%                
			        	}
			        }else{
			       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
			    	%>
			    		<li class="page-item">
			            	<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%
			                }    
			            }
			        }        
			        
			    	%>
			<%
				// 총 페이지수가 currentPage보다 크면 다음이 안나온다
				if(currentPage < lastPage) {
			%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
					</li>
			<%
				}
			%>
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/departments/departmentsList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막으로</a>
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