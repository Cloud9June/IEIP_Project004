<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = "insert into video_tbl_02 values (?, ?, ?, ?, ?, ?)";
	String sql2 = "select video_code from video_tbl_02";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs = pstmt2.executeQuery();
	
	int num = 0;
	String codeData = request.getParameter("video_code");
	
	while(rs.next()) {
		if(rs.getString(1).substring(0, 3).equals(codeData)) {
			num = Integer.parseInt(rs.getString(1).substring(4)) + 1;
		}
	}
	
	pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
	pstmt.setString(2, request.getParameter("video_code")+"_"+String.format("%03d", num));
	pstmt.setString(3, request.getParameter("video_name"));
	pstmt.setString(4, request.getParameter("rel_date"));
	pstmt.setInt(5, Integer.parseInt(request.getParameter("amount")));
	pstmt.setInt(6, Integer.parseInt(request.getParameter("rental")));
	
	pstmt.executeUpdate();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="videoList.jsp"></jsp:forward>
</body>
</html>