<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>deleteQnaForm</title>
	
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
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo + "  <--qnaNo");
%>
<div>
	<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
</div>
	<div class="container-fluid" style="margin-top:120px">
		<div class="row">
			<div class="col-xl-4"></div>
			<div class="col-xl-4">
		<h1>QnA 삭제</h1>
		<form method="post" action="<%=request.getContextPath()%>/qna/deleteQnaAction.jsp">
			<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
			<div class="form-group">
	   			<label for="qnaPw">비밀번호:</label>
	    		<input type="password" class="form-control" placeholder="Enter password" id="qnaPw" name="qnaPw">
  			</div>
  			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
	<div class="col-xl-4"></div>
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
</body>
</html>