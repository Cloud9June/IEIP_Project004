<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql = "select max(mbr_id)+1 from mbr_tbl_02";
	String sql2 = "select video_code, video_name from video_tbl_02";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	
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
		var mbr = document.mData;
		
		if(!mbr.mbr_name.value) {
			alert("회원 이름을 입력하세요.");
			mbr.mbr_name.focus();
			return false;
		}
		if(!mbr.mbr_phone.value) {
			alert("회원 전화번호를 입력하세요.");
			mbr.mbr_phone.focus();
			return false;
		}
		
		var chkBox = document.getElementsByName("genre");
		var cnt = 0;
		
		for (var i=0; i<chkBox.length; i++) {
			if(chkBox[i].checked) {
				cnt++;
			}
		}
		
		if (cnt <2) {
			alert("선호장르는 2개 이상 체크해야 합니다.");
			return false;
		}
	}
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>회원 추가</h2>
		
		<form action="mbrInsert.jsp" name="mData" method="post" onsubmit="return chkVal()">
			<table class="inputTable">
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="mbr_id" size="40" value="<%= rs.getString(1)%>" readonly></td>
				</tr>
				<tr>
					<th>회원명</th>
					<td><input type="text" name="mbr_name" size="40"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="mbr_phone" size="40"></td>
				</tr>
				<tr>
					<th>대여</th>
					<td>
						<select name="rental">
							<option value="none">대여안함</option>
							<%
								while(rs2.next()) {
							%>
							<option value="<%= rs2.getString("video_code")%>"><%= rs2.getString("video_name")%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>선호장르(2개 이상)</th>
					<td>
						<input type="checkbox" name="genre" value="act"><span>액션</span>
						<input type="checkbox" name="genre" value="fan"><span>판타지</span>
						<input type="checkbox" name="genre" value="com"><span>코메디</span>
						<input type="checkbox" name="genre" value="thr"><span>스릴러</span>
						<input type="checkbox" name="genre" value="hor"><span>공포</span>
						<input type="checkbox" name="genre" value="mel"><span>멜로</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="등록">
						<input type="button" value="취소" onclick="location.href='mbrAdd.jsp'">
					</td>
				</tr>
			</table>
		</form>
		

	</section>	
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>












