<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	StringBuffer sb = new StringBuffer();

	sb.append("select id, video_name, case substr(video_code,1,3) when 'act' then '액션'");
	sb.append(" when 'fan' then '판타지' when 'com' then '코메디' when 'thr' then '스릴러' when 'hor' then '공포'");
	sb.append(" when 'mel' then '멜로' end video_code, to_char(rel_date, 'YYYY-MM-DD') rel_date, amount,");
	sb.append(" to_char(rental, '99,999') rental from video_tbl_02 order by id");
	
	String sql = sb.toString();
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>비디오 목록</h2>
		
		<table>
			<thead>
				<tr>
					<th>등록번호</th>
					<th>제목</th>
					<th>장르</th>
					<th>출시일</th>
					<th>수량</th>
					<th>대여료</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><a href="videoModify.jsp?id=<%= rs.getString("id")%>"><%= rs.getString("id")%></a></td>
					<td><%= rs.getString("video_name")%></td>
					<td><%= rs.getString("video_code")%></td>
					<td><%= rs.getString("rel_date")%></td>
					<td><%= rs.getString("amount")%></td>
					<td><%= rs.getString("rental")%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>