<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="gd.emp.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>updateDepartmentsForm</title>
	
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
	//인코딩 통일
	request.setCharacterEncoding("utf-8");
	// deptNo 요청
	String deptNo = request.getParameter("dept_no");
	// 디버깅
	System.out.println(deptNo + "<--deptNo");
	// DB 설정
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	PreparedStatement stmt = conn.prepareStatement("select dept_no, dept_name from employees_departments where dept_no=?");
	stmt.setString(1, deptNo);
	System.out.println(stmt + "<--stmt");
	ResultSet rs = stmt.executeQuery();
	System.out.println(rs + "<--rs");
	// class 사용
	Departments d = new Departments();
	if(rs.next()) {
		d.deptNo = rs.getString("dept_no");
		d.deptName = rs.getString("dept_name");
	}
%>
	<div>
		<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:120px">
	<div class="row">
		<div class="col-xl-4"></div>
		<div class="col-xl-4">
		<h1>부서 수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/departments/updateDepartmentsAction.jsp">
			 <div class="control-group">
              <div class="form-group floating-label-form-group controls mb-0 pb-2">
                <label>deptNo</label>
                <input class="form-control" id="deptNo" name="deptNo" type="text" placeholder="deptNo" readonly="readonly" value="<%=d.deptNo%>">
                <p class="help-block text-danger"></p>
              </div>
              </div>
              <div class="control-group">
              <div class="form-group floating-label-form-group controls mb-0 pb-2">
                <label>deptName</label>
                <input class="form-control" id="deptName" name="deptName" type="text" placeholder="deptName" data-validation-required-message="Please enter deptName." value="<%=d.deptName%>">
                <p class="help-block text-danger"></p>
              </div>
            </div>
	  		<br>
	  		<button class="btn btn-warning" type="submit" >부서 수정</button>
	  		 </form>
			</div>
            </div>
		<div class="col-xl-4"></div>
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
</body>
</html>