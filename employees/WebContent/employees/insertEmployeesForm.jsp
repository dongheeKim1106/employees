<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>insertDepartmentsForm</title>
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
	<!-- mainmenu2 -->
	<div>
		<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<!-- 사원입력 -->
	<div class="container-fluid" style="margin-top:120px">
		<div class="row">
			<div class="col-xl-4"></div>
			<div class="col-xl-4">
				<h1>사원 입력</h1>
				<form method="post" action="<%=request.getContextPath()%>/employees/insertEmployeesAction.jsp">
					<div class="control-group">
						<div class="form-group floating-label-form-group controls mb-0 pb-2">
							<label>birth_date</label>
                			<input class="form-control" id="birthDate" name="birthDate" type="text" placeholder="YYYY-MM-DD">
							<p class="help-block text-danger"></p>
						</div>
					</div>
					<div class="control-group">
						<div class="form-group floating-label-form-group controls mb-0 pb-2">
							<label>First_name</label>
                			<input class="form-control" id="firstName" name="firstName" type="text" placeholder="firstName">
							<p class="help-block text-danger"></p>
						</div>
					</div>
					<div class="control-group">
						<div class="form-group floating-label-form-group controls mb-0 pb-2">
							<label>Last_name</label>
                			<input class="form-control" id="lastName" name="lastName" type="text" placeholder="lastName">
							<p class="help-block text-danger"></p>
						</div>
					</div>
					<!-- 성별 라디오 버튼 -->
					<div class="control-group custom-control custom-radio">
						 <div class="custom-control custom-radio custom-control-inline">
						    <input type="radio" class="custom-control-input" id="customRadio" name="gender" value="M">
						    <label class="custom-control-label" for="customRadio">남자</label>
						  </div>
						  <div class="custom-control custom-radio custom-control-inline">
						    <input type="radio" class="custom-control-input" id="customRadio2" name="gender" value="F">
						    <label class="custom-control-label" for="customRadio2">여자</label>
						  </div>
					</div>
					<div class="control-group">
						<div class="form-group floating-label-form-group controls mb-0 pb-2">
							<label>Hire_date</label>
                			<input class="form-control" id="hireDate" name="hireDate" type="text" placeholder="YYYY-MM-DD">
							<p class="help-block text-danger"></p>
						</div>
					</div>
					<br>
	  				<button class="btn btn-success" type="submit" >사원 입력</button>
				</form>
			</div>
			<div class="col-xl-4"></div>
		</div>
	</div>
</body>
</html>