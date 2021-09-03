<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = "select video_code from video_tbl_02";
	String sql2 = "update video_tbl_02 set id=?, video_code=?, video_name=?, rel_date=?,"
			+	  " amount=?, rental=? where id=" + request.getParameter("id");
	String sql3 = "select video_code from video_tbl_02 where id=" + request.getParameter("id");
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	ResultSet rs = pstmt.executeQuery();
	ResultSet rs3 = pstmt3.executeQuery();
	
	rs3.next();
	
	pstmt2.setInt(1, Integer.parseInt(request.getParameter("id")));
	
	if (rs3.getString("video_code").substring(0,3).equals(request.getParameter("video_code"))) {
		pstmt2.setString(2, rs3.getString("video_code"));
	} else {
		int num = 0;
		String codeData = request.getParameter("video_code");
		
		while(rs.next()) {
			if(rs.getString(1).substring(0, 3).equals(codeData)) {
				num = Integer.parseInt(rs.getString(1).substring(4)) + 1;
			}
		}
		
		pstmt2.setString(2, request.getParameter("video_code")+"_"+String.format("%03d", num));
	}
	
	pstmt2.setString(3, request.getParameter("video_name"));
	pstmt2.setString(4, request.getParameter("rel_date"));
	pstmt2.setString(5, request.getParameter("amount"));
	pstmt2.setString(6, request.getParameter("rental"));
	
	pstmt2.executeUpdate();
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