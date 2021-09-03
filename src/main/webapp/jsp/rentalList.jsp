<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	StringBuffer sb = new StringBuffer();

	sb.append("select m.mbr_id, m.mbr_name, m.mbr_phone, case m.rental_whether when 0 then '대여안함'");
	sb.append(" else '대여중' end rental_whether, nvl(v.video_name, 'none') video_name");
	sb.append(" from mbr_tbl_02 m left outer join video_tbl_02 v");
	sb.append(" on m.rental_list = v.video_code order by mbr_id");

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
		<h2>대여 현황</h2>
		
		<table>
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원명</th>
					<th>전화번호</th>
					<th>대여여부</th>
					<th>대여목록</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString(1)%></td>
					<td><%= rs.getString(2)%></td>
					<td><%= rs.getString(3)%></td>
					<td><%= rs.getString(4)%></td>
					<td><%= rs.getString(5)%></td>
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