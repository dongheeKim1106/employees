<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="gd.emp.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>selectQna</title>
	
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
	// 요청 응답 페이지 인코딩 통일
	request.setCharacterEncoding("UTF-8");
	// qnaNo를 문자열로 받아와 숫자로 변환
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	System.out.println(qnaNo + "  <--qnaNo");
	// DB 연결 준비 및 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
	System.out.println(conn + "<--conn");
	// 쿼리문 준비 후 저장
	PreparedStatement stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_content, qna_user, qna_date from employees_qna where qna_no=?");
	// ?값 입력
	stmt1.setInt(1, qnaNo);
	System.out.println(stmt1 + "  <--stmt1");
	// 쿼리 결과 저장
	ResultSet rs = stmt1.executeQuery();
	System.out.println(rs + "  <--rs");
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
<div id="page-top"></div>
<div>
	<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
</div>
<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
<div class="scroll-to-top position-fixed ">
	<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a> 
	<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom"> <i class="fa fa-chevron-down"></i></a>
</div>
<div class="container-fluid" style="margin-top:120px">
<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
	<h1>QnA 상세보기</h1>
	<table class="table">
		<tr>
			<td>qna_no</td>
			<td><%=qna.qnaNo%></td>
		</tr>
		<tr>
			<td>qna_title</td>
			<td><%=qna.qnaTitle%></td>
		</tr>
		<tr>
			<td>qna_content</td>
			<td><%=qna.qnaContent%></td>
		</tr>
		<tr>
			<td>qna_user</td>
			<td><%=qna.qnaUser%></td>
		</tr>
		<tr>
			<td>qna_date</td>
			<td><%=qna.qnaDate.substring(0,10)%></td>
		</tr>
	</table>
	<!-- 수정 / 삭제 -->
	<div class="btn-group">
		<a href="<%=request.getContextPath()%>/qna/qnaList.jsp" class="btn btn-warning" role="button">목록</a>
		<a href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?qnaNo=<%=qna.qnaNo%>" class="btn btn-info" role="button">수정</a>
		<a href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qna.qnaNo%>" class="btn btn-danger" role="button">삭제</a>
	</div>
	<!-- 링크  1. 목록-->
	<!-- 댓글 목록 / 댓글 입력 -->
	<br>
	<form method="post" action="<%=request.getContextPath()%>/qna/insertCommentAction.jsp">
		<input type="hidden" name ="qnaNo" value="<%=qna.qnaNo%>">
		<div class="form-group">
			<label for="comment"><br>comment :</label>
			<textarea class="form-control" rows="2" id="comment" name="comment"></textarea>
		</div>
		<div class="form-group">
			<label for="pwd">comment password :</label>
			<input type="password" class="form-control" id="commentPw" name="commentPw">
		</div>
		<button type="submit" class="btn btn-primary">댓글입력</button>
		<br>
	</form>      
	<!-- 댓글목록 -->
	<%
		// select comment_no, comment from qna_comment
		// where qna_no = ?
		// limit ?,?
		// currentPage 설정 페이지 초기
		int currentPage = 1;
		// 값을 받으면 숫자로 면환
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println(currentPage + "<-- currentPage");
		int rowPerPage = 5;
		int beginRow = (currentPage-1)*rowPerPage;
		System.out.println(beginRow + "<-- beginRow");
		// 쿼리 생성
		PreparedStatement stmt2 = conn.prepareStatement("select comment_no, comment, comment_date from employees_qna_comment where qna_no=? limit ?,?");
		// ? 값
		stmt2.setInt(1, qnaNo);
		stmt2.setInt(2, beginRow);
		stmt2.setInt(3, rowPerPage);
		System.out.println(stmt2 + "<-- stmt2");
		// 쿼리 결과 저장
		ResultSet rs2 = stmt2.executeQuery();
		System.out.println(rs2 + "<-- rsComment");
		// rs 를 list로
		ArrayList<QnaComment> list = new ArrayList<QnaComment>();
	    while(rs2.next()){
	        QnaComment q = new QnaComment();
	        q.commentNo = rs2.getInt("comment_no");
	        q.commentDate = rs2.getString("comment_date");
	        q.comment = rs2.getString("comment");
			list.add(q);
	    }
	    System.out.println(list.size() +"<--list");
	 	// 페이징 수
 		int pagePerGroup = 10;
	    // 마지막 페이지 
		int lastPage = 0;
	    // 총 행
		int totalRow = 0;
	    // 총 갯수
	    int totalCount = 0;
	    // 쿼리 생성
	    PreparedStatement stmt3 = conn.prepareStatement("select count(*) from employees_qna_comment where qna_no=?");
	    // ? 값
	    stmt3.setInt(1, qnaNo);
	    System.out.println(stmt3 + "<-- stmt3");
	    // 쿼리 결과저장
	    ResultSet rs3 = stmt3.executeQuery();
	    System.out.println(rs3 + "<-- rs3");
	    // 총 행의 수 구하기
	    if(rs3.next()) {
	    	totalRow = rs3.getInt("count(*)");
	    }
	    // 마지막 페이지 구하기
	    lastPage = totalRow / rowPerPage;
	    // 나눠서 나머지가 0이 아니면 마지막 페이지에 1 추가
	    if(totalRow % rowPerPage != 0) {
	    	lastPage += 1;
	    }
	    // 총행의 갯수는 총 갯수
	    totalCount = totalRow;
	    System.out.println(lastPage + "<--lastPage");
		System.out.println(totalRow + "<--totalRow");
		System.out.println(totalCount + "<--totalCount");
	%>
		<br>
		<h4>댓글 &emsp;<small>댓글 수 : <%=totalCount %></small></h4>
		<table class="table table-hover table-bordered text-center">
			<thead>
				<tr>
					<th>comment_no</th>
					<th>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;comment&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;</th>
					<th>comment_date</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(QnaComment q : list) {
				%>
					<tr>
						<td><%=q.commentNo %></td>
						<td><%=q.comment %></td>
						<td><%=q.commentDate.substring(0,10) %></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
			<ul class="pagination justify-content-center" style="margin:20px 0">
			<% 
				if(currentPage > 1) {
			%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=1&qnaNo=<%=qnaNo%>">처음으로</a>
				</li>
			<%
				}
			%>	
			<%
				if(currentPage > 1) {
			%>
				<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=currentPage-1%>&qnaNo=<%=qnaNo%>">이전</a>
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
			       		<a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=i%>&qnaNo=<%=qnaNo%>"><%=i%></a>
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
			             	<a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=i%>&qnaNo=<%=qnaNo%>"><%=i%></a>
			   			</li>
			    	<%                
			        	}
			        }else{
			       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
			    	%>
			    		<li class="page-item">
			            	<a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=i%>&qnaNo=<%=qnaNo%>"><%=i%></a>
			   			</li>
			    	<%
			                }    
			            }
			        }        
			        
			    	%>
			<%
				if(currentPage < lastPage) {
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=currentPage+1%>&qnaNo=<%=qnaNo%>">다음</a></li>
			<%
				}
			
			if(currentPage > 1) {
			%>
			<li class="page-item">
				<a class="page-link" href="<%=request.getContextPath()%>/qna/selectQna.jsp?currentPage=<%=lastPage%>&qnaNo=<%=qnaNo%>">마지막으로</a>
			</li>
			<%
			}
			%>
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