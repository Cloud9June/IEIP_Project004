<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql = "select max(id)+1 from video_tbl_02";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
<script type="text/javascript">
	function chkVal() {
		var video = document.vData;
		
		if(!video.video_name.value) {
			alert("비디오 제목을 입력하세요.");
			video.video_name.focus();
			return false;
		}
		if(!video.rel_date.value) {
			alert("출시일을 입력하세요.");
			video.rel_date.focus();
			return false;
		}
		if(!video.amount.value) {
			alert("비디오 수량을 입력하세요.");
			video.amount.focus();
			return false;
		}
		
		var chk_radio = document.getElementsByName("video_code");
		
		for (var i=0; i < chk_radio.length; i++) {
			if(document.querySelector('input[name="video_code"]')[i].checked!=true) {
				alert("장르를 선택하세요.");
				return false;
			}
		}
		/* 
		var chk_radio = document.getElementsByName("video_code");
		var code_type = null;
		
		for (var i=0; i < chk_radio.length; i++) {
			if (chk_radio[i].checked == true) {
				code_type = chk_radio[i].value;
			}
		}
		
		if (code_type == null) {
			alert("장르를 선택하세요.");
			return false;
		}
		 */
		
		if(!video.rental.value) {
			alert("책정버튼을 눌러 가격을 확인하세요.");
			return false;
		}
		
	}
	
	function chkPrice() {
		
		var today = new Date().getFullYear();
		/*
			Date객체에 대해서
			1. getFullYear() : 연도
			2. getMonth() : 월(달)
			3. getDate() : 일
			4. getDay() : 요일
			5. getHours() : 시간
			6. getMinuts() : 분
			7. getSeconds() : 초
		*/
		var rel_date = document.vData.rel_date.value.substring(0, 4);
		
		var rentalP = 0;
		
		if((today-rel_date) > 5) {
			rentalP = 3000;
		} else {
			rentalP = 15000 - ((today-rel_date)*2000);
		}
		
		document.vData.rental.value = rentalP;
	}
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>비디오 추가</h2>
		
		<form action="videoInsert.jsp" name="vData" method="post" onsubmit="return chkVal()">
			<table class="inputTable">
				<tr>
					<th>등록번호</th>
					<td><input type="text" name="id" size="40" value="<%= rs.getString(1) %>" readonly></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="video_name" size="40" ></td>
				</tr>
				<tr>
					<th>출시일</th>
					<td><input type="text" name="rel_date" size="40" ></td>
				</tr>
				<tr>
					<th>수량</th>
					<td><input type="text" name="amount" size="40" ></td>
				</tr>
				<tr>
					<th>장르</th>
					<td>
						<input type="radio" name="video_code" value="act"><span>액션</span>
						<input type="radio" name="video_code" value="fan"><span>판타지</span>
						<input type="radio" name="video_code" value="com"><span>코메디</span>
						<input type="radio" name="video_code" value="thr"><span>스릴러</span>
						<input type="radio" name="video_code" value="hor"><span>공포</span>
						<input type="radio" name="video_code" value="mel"><span>멜로</span>
					</td>
				</tr>
				<tr>
					<th>대여료</th>
					<td>
						<input type="text" name="rental" size="40" readonly>
						<input type="button" value="책정" onclick="chkPrice()">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록">
						<input type="button" value="취소" onclick="location.href='videoList.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</section>	
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>















