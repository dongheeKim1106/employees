<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Index</title>

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
	<div id="page-top"></div>
	 <!-- Scroll to Up&Down Button (Only visible on small and extra-small screen sizes) --> 
  	<div class="scroll-to-top position-fixed ">
    <a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-top">
      <i class="fa fa-chevron-up"></i>
    </a>
    <a class="js-scroll-trigger d-block text-center text-write rounded" href="#page-bottom">
      <i class="fa fa-chevron-down"></i>
    </a>
  </div>
	<div>
	<!-- 다른 페이지를 현재페이지에 포함실킬수 있는 액션 -->
	<jsp:include page="/inc/mainmenu2.jsp"></jsp:include>
	</div>
	<div class="container-fluid" style="margin-top:200px">
		<div class="row">
		<div class="col-xl-2"></div>
		<div class="col-xl-8">
		<h1>이력서</h1>
		<!-- 기본정보  -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td rowspan="3" width="200">
						<img src="<%=request.getContextPath()%>/imgs/kim.jpg" width="200" height="200">
					</td>
					<th rowspan="2" class="bg-secondary text-center"><br>성명</th>
					<td class="text-center">(한글) 김동희</td>
					<th class="bg-secondary text-center">생년월일</th>
					<td class="text-center">951106</td>
				</tr>
				<tr>
					<!-- <td>사진</td> -->
					<!-- <td>성명</td> -->
					<td class="text-center">(영어) Kim donghee</td>
					<th class="bg-secondary text-center">휴대폰</th>
					<td class="text-center">010-1234-5678</td>
				</tr>
				<tr>
					<!-- <td>사진</td> -->
					<th class="bg-secondary text-center"><br>현주소</th>
					<td class="text-center"><br>경기도 고양시 일산서구 일산동 <br> 일청로 75</td>
					<th class="bg-secondary text-center"><br>이메일</th>
					<td class="text-center"><br>ehdgmldk@naver.com</td>
				</tr>
			</tbody>
		</table>
		<!-- 학력사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr class="bg-secondary text-center">
					<th rowspan="5"><br><br>학<br>력<br>사<br>항</th>
					<th>졸업일</th>
					<th>학교명</th>
					<th>전공</th>
					<th>졸엽여부</th>
					<th>소재지</th>
					<th>성적</th>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td class="text-right">2014년 2월</td>
					<td class="text-right">중산 고등학교</td>
					<td class="text-right">이과</td>
					<td class="text-center">O</td>
					<td class="text-center">고양시</td>
					<td class="text-center">좋지 / 않음</td>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td class="text-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;월</td>
					<td class="text-right">&emsp;&emsp;&emsp;&emsp;&emsp;대학</td>
					<td class="text-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="text-center">&nbsp;</td>
					<td class="text-center">&nbsp;&nbsp;&nbsp;</td>
					<td class="text-center">&nbsp;&nbsp; / &nbsp;&nbsp;</td>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td class="text-right">2020년 2월</td>
					<td class="text-right">두원 공과 대학교</td>
					<td class="text-right">스마트 IT</td>
					<td class="text-center">O</td>
					<td class="text-center">파주시</td>
					<td class="text-center">평균 / 정도</td>
				</tr>
				<tr>
					<!-- <td>학력사항</td> -->
					<td class="text-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;월</td>
					<td class="text-right">&emsp;&emsp;&emsp;&emsp;&emsp;대학원</td>
					<td class="text-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="text-center">&nbsp;</td>
					<td class="text-center">&nbsp;&nbsp;&nbsp;</td>
					<td class="text-center">&nbsp;&nbsp; / &nbsp;&nbsp;</td>
				</tr>
			</tbody>
		</table>
		<!-- 경력사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr class="bg-secondary text-center">
					<th rowspan="4"><br>경<br>력<br>사<br>항</th>
					<th>근무 기간</th>
					<th>회사명</th>
					<th>직위</th>
					<th>담당업무</th>
					<th>퇴사사유</th>
				</tr>
				<tr>
					<!-- <td>경력사항</td> -->
					<td class="text-center">2017.08 - 2018.02</td>
					<td class="text-center">파주 LG디스플레이</td>
					<td class="text-center">사원</td>
					<td class="text-center">판넬 외관검사</td>
					<td class="text-center">학업</td>
				</tr>
				<tr>
					<!-- <td>경력사항</td> -->
					<td class="text-center">2018.12 - 2019.2</td>
					<td class="text-center">(주)레딕스</td>
					<td class="text-center">사원</td>
					<td class="text-center">보안</td>
					<td class="text-center">학업</td>
				</tr>
				<tr>
					<!-- <td>경력사항</td> -->
					<td class="text-center">&emsp;&emsp;&emsp;&emsp;-&emsp;&emsp;&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
				</tr>
			</tbody>
		</table>
		<!-- 기타사항 -->
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th rowspan="6" class="bg-secondary text-center"><br><br><br>기<br>타<br>사<br>항</th>
					<th class="bg-secondary text-center">신장</th>
					<td class="text-center">174 cm</td>
					<th class="bg-secondary text-center">체중</th>
					<td class="text-center">70 kg</td>
					<th class="bg-secondary text-center">시력</th>
					<td class="text-center">0.7 / 0.9</td>
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<th class="bg-secondary text-center">취미</th>
					<td class="text-center">축구</td>
					<th class="bg-secondary text-center">특기</th>
					<td class="text-center">야구보기</td>
					<th class="bg-secondary text-center">종교</th>
					<td class="text-center">무교</td>
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<th rowspan="4" class="bg-secondary text-center"><br><br><br>전산능력</th>
					<th class="bg-secondary text-center">프로그램명</th>
					<th class="bg-secondary text-center">활용도</th>
					<th colspan="3" class="bg-secondary text-center">자격증 보유 현황</th>
					<!-- <td>자격증 보유 현황</td> -->
					<!-- <td>자격증 보유 현황</td> -->
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td colspan="3" class="text-center">&emsp;&emsp;</td>
					<!-- <td>자격증 보유 현황</td> -->
					<!-- <td>자격증 보유 현황</td> -->
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td colspan="3" class="text-center">&emsp;&emsp;</td>
					<!-- <td>자격증 보유 현황</td> -->
					<!-- <td>자격증 보유 현황</td> -->
				</tr>
				<tr>
					<!-- <td>기타사항</td> -->
					<!-- <td>전산능력</td> -->
					<td class="text-center">&emsp;&emsp;</td>
					<td class="text-center">&emsp;&emsp;</td>
					<td colspan="3" class="text-center">&emsp;&emsp;</td>
					<!-- <td>자격증 보유 현황</td> -->
					<!-- <td>자격증 보유 현황</td> -->
				</tr>
			</tbody>
		</table>
  
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
  
<div class="col-xl-2"></div>
		</div>
	</div>
</div>
<div id="page-bottom"></div>
</body>
</html>