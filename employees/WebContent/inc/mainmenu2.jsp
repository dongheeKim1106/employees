<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Mainmenu</title>

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

  <!-- Navigation -->
  <nav class="navbar bg-secondary text-uppercase fixed-top" id="mainNav">
    <div class="container-fluid">
      <a class="navbar-brand js-scroll-trigger" href="<%=request.getContextPath()%>/index.jsp">Home</a>
      <button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fas fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        <li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/about.jsp"><i class='far fa-smile'></i>이력서</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/departments/departmentsList.jsp"><i class='fas fa-fax'></i>departments</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/employees/employeesList.jsp"><i class='fas fa-sitemap'></i>employees</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp"><i class='far fa-address-book'></i>deptEmp</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp"><i class='fas fa-address-card'></i>deptManager</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/titles/titlesList.jsp"><i class='far fa-id-badge'></i>titles</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/salaries/salariesList.jsp"><i class='fas fa-calculator'></i>salaries</a></li>
		<li class="nav-item"><a class="nav-link py-3 px-0 px-lg-3" href="<%=request.getContextPath()%>/qna/qnaList.jsp"><i class='fas fa-comment-dots'></i>Q&A게시판</a></li>
          <li class="nav-item">
            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#portfolio"></a>
          </li>
        </ul>
        
      </div>
    </div>
  </nav>
 
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
