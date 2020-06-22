<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="gd.emp.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>updateQnaForm</title>
	
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
		System.out.println(qnaNo + " <--qnaNo");
		// DB 연결 준비 및 연결
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		System.out.println(conn + "<--conn");
		// 쿼리문 준비 후 저장
		PreparedStatement stmt = conn.prepareStatement("select qna_no, qna_title, qna_content, qna_user, qna_date from employees_qna where qna_no=?");
		// ?값 입력
		stmt.setInt(1, qnaNo);
		System.out.println(stmt + "<--stmt");
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs + "<--rs");
		// class 사용
		QnA qna = new QnA();
		if(rs.next()) {
			qna.qnaNo = rs.getInt("qna_no");
			qna.qnaTitle = rs.getString("qna_title");
			qna.qnaContent = rs.getString("qna_content");
			qna.qnaUser = rs.getString("qna_user");
			qna.qnaDate = rs.getString("qna_date");
		}
	%>
	<div>
		<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:120px">
		<div class="row">
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
		<h1>QnA 수정</h1>
		<form method="post" action="<%=request.getContextPath()%>/qna/updateQnaAction.jsp">
			<input type="hidden" name="qnaNo" value="<%=qnaNo %>">
			<div class="form-group">
   				<label for="qnaNo">qna_no</label>
   				<input type="text" class="form-control" id="qnaNo" name="qnaNo" readonly="readonly" value="<%=qna.qnaNo%>">
  			</div>
  			<div class="form-group">
	   			<label for="qnaTitle">qna_title</label>
	    		<input type="text" class="form-control" id="qnaTitle" name="qnaTitle" value="<%=qna.qnaTitle%>">
  			</div>
  			<div class="form-group">
	   			<label for="qnaContent">qna_content</label>
	    		<textarea class="form-control" rows="3" id="qnaContent" name="qnaContent"><%=qna.qnaContent%></textarea>
  			</div>
  			<div class="form-group">
	   			<label for="qnaUser">qna_user</label>
	    		<input type="text" class="form-control" id="qnaUser" name="qnaUser" value="<%=qna.qnaUser%>">
  			</div>
			<div class="form-group">
	   			<label for="qnaPw">비밀번호</label>
	    		<input type="password" class="form-control" placeholder="Enter password" id="qnaPw" name="qnaPw">
  			</div>
  			<button type="submit" class="btn btn-primary">수정하기</button>
		</form>
	</div>
	<div class="col-xl-3"></div>
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