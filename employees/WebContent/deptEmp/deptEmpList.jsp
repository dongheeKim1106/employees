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
		// 자바 코드부분
		// encoding 통일
		request.setCharacterEncoding("UTF-8");
		// searchWord 설정
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
		// 1. 페이지
		// 현재 페이지 값 저장 변수
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// currentPage 확인
		// System.out.println(currentPage);
		// 한페이지의 목록수
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
		// 0부터 시작하기 때문에 1을 빼준다
		int beginRow = (currentPage-1)*rowPerPage;
		// beginRow 확인
		// System.out.println(beginRow);
		// DB연결
		
		Class.forName("org.mariadb.jdbc.Driver");
		// DB연결 변수선언
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		// conn 값 확인
		System.out.println(conn);
		// 쿼리를 저장할 변수
		PreparedStatement stmt1 = null;
		if(searchWord.equals("")) {
			// 쿼리 저장
			/*
			SELECT
			de.dept_no,
			d.dept_name,
			de.emp_no,
			CONCAT (e.first_name,' ',e.last_name) AS fullname,
			de.from_date,
			de.to_date
			FROM dept_emp de INNER JOIN departments d INNER JOIN employees e
			ON de.dept_no = d.dept_no AND de.emp_no = e.emp_no
			ORDER BY de.emp_no ASC;
			*/
			stmt1 = conn.prepareStatement("select de.dept_no, d.dept_name, de.emp_no, concat(e.first_name,' ',e.last_name) as full_name, de.from_date, de.to_date from employees_dept_emp de inner join employees_departments d inner join employees_employees e on de.dept_no = d.dept_no and de.emp_no = e.emp_no order by de.emp_no asc limit ?,?");
			// ? 값에 저장
			stmt1.setInt(1, beginRow);
			stmt1.setInt(2, rowPerPage);
		} else {
			// 쿼리 저장
			stmt1 = conn.prepareStatement("select de.dept_no, d.dept_name, de.emp_no, concat(e.first_name,' ',e.last_name) as full_name, de.from_date, de.to_date from employees_dept_emp de inner join employees_departments d inner join employees_employees e on de.dept_no = d.dept_no and de.emp_no = e.emp_no where de.dept_no like ? order by emp_no asc limit ?,?");
			// ? 값에 저장
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		}
		// 쿼리문 확인
		System.out.println(stmt1);
		// 쿼리 결과 저장 변수
		ResultSet rs1 = null;
		// 쿼리 실행후 저장
		rs1 = stmt1.executeQuery();
		// rs1값 확인
		System.out.println(rs1);
		// 2. 현재페이지의 dept_emp 테이블 행들
		// rs1을 list로 옮기는 과정
		// 현재페이지의 dept_emp 테이블 행들 저장하기 위헤
		ArrayList<DeptEmpInner> list = new ArrayList<DeptEmpInner>();
		while(rs1.next()) {
			DeptEmpInner d = new DeptEmpInner();
			// 오른쪽 값을 왼쪽에 저장
			d.deptNo = rs1.getString("de.dept_no");
			d.deptName = rs1.getString("d.dept_name");
			d.empNo = rs1.getInt("de.emp_no");
			d.firstName = rs1.getString("full_name");
			d.lastName = rs1.getString("full_name");
			d.fromDate = rs1.getString("de.from_date");
			d.toDate = rs1.getString("de.to_date");
			// d를 list에 추가
			list.add(d);
		}
		// list size 확인
		// System.out.println(list.size());
		// 3. dept_emp 테이블의 전체 행
		// 페이징 수
		int pagePerGroup = 10;
		// 마지막 페이지 저장변수
		int lastPage = 0;
		// 전체 테이블 행 저장 변수
		int totalRow = 0;
		// 쿼리 저장 변수
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")) {
			// 행의 전체를 알려주는 쿼리
			stmt2 = conn.prepareStatement("select count(*) from employees_dept_emp");
		} else {
			// 행의 전체를 알려주는 쿼리
			stmt2 = conn.prepareStatement("select count(*) from employees_dept_emp where dept_no like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		}
		// 쿼리 실행 저장변수
		ResultSet rs2 = null;
		// 쿼리 실행후 rs2에 저장
		rs2 = stmt2.executeQuery();
		// stmt2, rs2 확인
		// System.out.println(stmt2);
		// System.out.println(rs2);
		// rs2 값을 totalRow에 저장
		if(rs2.next()) {
			// totalRow에는 전체 행수가 저장
			totalRow = rs2.getInt("count(*)");
		}
		// totalRow를 rowPerPage를 나눈값을 lastPage에 저장
		lastPage = totalRow / rowPerPage;
		// 만약 나머지가 0이 아닐시
		if(totalRow % rowPerPage != 0) {
			// lastPage에 1씩추가
			lastPage += 1;
		}
		// last Page 확인
		// System.out.println(lastPage);
	%>
	<!-- 여기서 부터 태그 -->
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
				<h1>DeptEmpList</h1>
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
							// list값을 d로 호출
							for(DeptEmpInner d : list) {
						%>
							<tr>
								<td><%=d.deptNo %></td>
								<td><%=d.deptName%></td>
								<td><%=d.empNo %></td>
								<td><%=d.firstName%></td>
								<td><%=d.fromDate %></td>
								<td><%=d.toDate %></td>
								<td><a href=""class="btn btn-primary" role="button">수정</a></td>
								<td><a href=""class="btn btn-danger" role="button" type="submit">삭제</a></td>
							</tr>
						<%
							} // for문 종료
						%>
					</tbody>
				</table>
				<form method="post" action="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp" class="d-flex justify-content-end">
					<input type="text" name="searchWord">
					<button type="submit">검색</button>
				</form>
				<ul class="pagination justify-content-center" style="margin:20px 0">
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음으로</a>
					</li>	
					<%
						// curremtpage가 1보다 크면 이전버튼 활성화
						if(currentPage > 1) {
					%>
						<li class="page-item">
							<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
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
			       		<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=i%>"><%=i%></a>
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
			             	<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%                
			        	}
			        }else{
			       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
			    	%>
			    		<li class="page-item">
			            	<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%
			                }    
			            }
			        }        
			        
			    	%>
					<%
						// 총페이지수가 currentPage보다 크면 다음버튼 비활성화
						if(currentPage < lastPage) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
							</li>
					<%
						}
					%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막으로</a>
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