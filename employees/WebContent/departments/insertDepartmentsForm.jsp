<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div>
		<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:120px">
	<div class="row">
		<div class="col-xl-4"></div>
		<div class="col-xl-4">
		<h1>부서 입력</h1>
		<form method="post" action="<%=request.getContextPath()%>/departments/insertDepartmentsAction.jsp">
			 <div class="control-group">
              <div class="form-group floating-label-form-group controls mb-0 pb-2">
                <label>deptName</label>
                <input class="form-control" id="deptName" name="deptName" type="text" placeholder="부서" data-validation-required-message="부서 이름을 입력하세요.">
                <p class="help-block text-danger"></p>
              </div>
              </div>
	  		<br>
	  		<button class="btn btn-success" type="submit" >부서 입력</button>
	  		 </form>
			</div>
            </div>
		<div class="col-xl-4"></div>
	</div>
</body>
</html>