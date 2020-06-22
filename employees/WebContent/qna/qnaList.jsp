<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="gd.emp.*" %>
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
		// encoding 맞춤
		request.setCharacterEncoding("UTF-8");
		// searchWord 설정
		String searchWord = "";
		if(request.getParameter("searchWord") != null) {
			searchWord = request.getParameter("searchWord");
		}
		System.out.println(searchWord + "<--searchWord");
		// 목록수 변수 설정
		String pageOption="";
		if(request.getParameter("pageOption") != null) {
			pageOption = request.getParameter("pageOption");
		}
		System.out.println(pageOption + "<--pageOption");
		// searchMenu 설정
		String searchMenu = "";
		if(request.getParameter("searchMenu") != null) {
			searchMenu = request.getParameter("searchMenu");
		}
		System.out.println(searchMenu + "<--searchMenu");
		// currentPage 설정
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		System.out.println(currentPage + "<--currentPage");
		// 한화면당 페이지 목록 수
		int pagePerGroup = 10;
		// 페이지당 목록 수
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
		int beginRow = (currentPage-1)*rowPerPage;
		System.out.println(beginRow + "<--beginRow");
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/ehdgmlcm","ehdgmlcm","java1004");
		System.out.println(conn + "<--conn");
		
		PreparedStatement stmt1 = null;
		// 검색어 유무에 따른 동적 쿼리
		if(searchWord.equals("")) {
			stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_user, qna_date from employees_qna order by qna_no desc limit ?,?");
			stmt1.setInt(1, beginRow);
			stmt1.setInt(2, rowPerPage);
		} else if(searchMenu.equals("title")) {
			stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_title like ? order by qna_no desc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		} else if(searchMenu.equals("content")) {
			stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_content like ? order by qna_no desc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setInt(2, beginRow);
			stmt1.setInt(3, rowPerPage);
		} else {
			/* 
				select qna_no, qna_title, qna_uesr, qna_date
				from qna
				where qna_title like ?
				order by qna_no desc
				limit ?,?
			*/
			stmt1 = conn.prepareStatement("select qna_no, qna_title, qna_user, qna_date from employees_qna where qna_title like ? or qna_content like ? order by qna_no desc limit ?,?");
			stmt1.setString(1, "%"+searchWord+"%");
			stmt1.setString(2, "%"+searchWord+"%");
			stmt1.setInt(3, beginRow);
			stmt1.setInt(4, rowPerPage);
		}
		System.out.println(stmt1+"<--stmt1");
		ResultSet rs1 = stmt1.executeQuery();
		System.out.println(rs1 + "<--rs1");
		ArrayList<QnA> list= new ArrayList<QnA>();
		while(rs1.next()) {
			QnA qna = new QnA();
			qna.qnaNo = rs1.getInt("qna_no");
			qna.qnaTitle = rs1.getString("qna_title");
			qna.qnaUser = rs1.getString("qna_user");
			qna.qnaDate = rs1.getString("qna_date");
			list.add(qna);
		}
		System.out.println(list.size() + "<-- list.size()");
		int lastPage = 0;
		int totalRow = 0;
		// 0=1~10페이지        1=11~20페이지
		int gropStartPage = 0;
		PreparedStatement stmt2 = null;
		if(searchWord.equals("")) {
			stmt2 = conn.prepareStatement("select count(*) from employees_qna");
		} else if(searchMenu.equals("title")) {
			stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_title like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		} else if(searchMenu.equals("content")) {
			stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_content like ?");
			stmt2.setString(1, "%"+searchWord+"%");
		} else {
			stmt2 = conn.prepareStatement("select count(*) from employees_qna where qna_title like ? or qna_content like ?");
			stmt2.setString(1, "%"+searchWord+"%");
			stmt2.setString(2, "%"+searchWord+"%");
		}
		int totalCount = 0;
		ResultSet rs2 = stmt2.executeQuery();
		System.out.println(stmt2 + "<--stmt2");
		System.out.println(rs2 + "<--rs2");
		if(rs2.next()) {
			totalRow = rs2.getInt("count(*)");
		}
		lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		totalCount = totalRow;
		System.out.println(lastPage + "<--lastPage");
		System.out.println(totalRow + "<--totalRow");
		System.out.println(totalCount + "<--totalCount");
	%>
	<!-- 태그 -->
	<div id="page-top"></div>
	<div>
		<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:120px">
	<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
				<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
				<div class="scroll-to-top position-fixed ">
					<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a> 
					<a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom"> <i class="fa fa-chevron-down"></i></a>
				</div>
				<h1>QnA List &emsp;<small>전체 글수 : <%=totalCount %></small></h1>
				<br>
				<!-- 목록수 제어 Form -->
				<form method="post" action="<%=request.getContextPath()%>/qna/qnaList.jsp">	
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
							<th>qna_no</th>
							<th>qna_title</th>
							<th>qna_user</th>
						</tr>
					</thead>
					<tbody>
						<%
							for(QnA q : list) {
							// db의 문자열 날짜값중 일부를 추출해 문자열로 변경
							// jsp에서 오늘 날짜값중 일부를 추출해 분자열로 변경
							// 두 날짜 문자열을 비교해서 같으면 badge표시
							String qnaDateSub = q.qnaDate.substring(0, 10);
							System.out.println(qnaDateSub+ "<-- qnaDate.substring");
							Calendar today = Calendar.getInstance();
							/* System.out.println(today.get(Calendar.YEAR));
							System.out.println(today.get(Calendar.MONTH)+1);
							System.out.println(today.get(Calendar.DATE));
							String strToday = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH)+1) + "-" + today.get(Calendar.DATE);
							System.out.println(strToday); */
							int year = today.get(Calendar.YEAR);
							int month = today.get(Calendar.MONTH)+1;
							String month2 = ""+month;
							if(month<10) {
								month2 = "0"+month;
							}
							int day = today.get(Calendar.DATE);
							String day2 = ""+day;
							if(day<10) {
								day2 = "0"+day;
							}
							String strToday = year + "-" + month2 + "-" + day;
		                    System.out.println(strToday+ " <-- strToday");
						%>
							<tr>
								<td><%=q.qnaNo %></td>
								<td>
									<a href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=q.qnaNo%>"><%=q.qnaTitle%></a>
									<%
										if(strToday.equals(qnaDateSub)) {
									%>
										<span class="badge badge-warning">new</span>
									<%
										}
									%>
								</td>
								<td><%=q.qnaUser %></td>
							</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<a href="<%=request.getContextPath() %>/qna/insertQnaForm.jsp" class="btn btn-info" role="button">QnA 입력</a>
				<form method="post" action="<%=request.getContextPath()%>/qna/qnaList.jsp" class="d-flex justify-content-end">
					<select name="searchMenu">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="searchAll">제목 + 내용</option>
					</select>
					<input type="text" name="searchWord">
					<button type="submit">검색</button>
				</form>
				<ul class="pagination justify-content-center" style="margin:20px 0">
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음으로</a>
					</li>
					<%
						// currentPage가 1보다 크면 이전버튼이 나온다
						if(currentPage > 1) {
					%>
						<!-- 절대 주소 사용 -->
						<li class="page-item">
							<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
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
			       		<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>"><%=i%></a>
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
			             	<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>"><%=i%></a>
			   			</li>
			    	<%                
			        	}
			        }else{
			       		for(int i=(groupStartPage*10)+1; i<=(groupStartPage*10)+10; i=i+1){
			    	%>
			    		<li class="page-item">
			            	<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=i%>"><%=i%></a>
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
							<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
						</li>
					<%
						}
					%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막으로</a>
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