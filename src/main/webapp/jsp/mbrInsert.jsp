<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = "insert into mbr_tbl_02 values (?,?,?,?,?)";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(request.getParameter("mbr_id")));
	pstmt.setString(2, request.getParameter("mbr_name"));
	pstmt.setString(3, request.getParameter("mbr_phone"));
	
	if (request.getParameter("rental").equals("none")) {
		pstmt.setInt(4, 0);
	} else {
		pstmt.setInt(4, 1);
	}
	/* 
	if (request.getParameter("rental").equals("none")) pstmt.setInt(4, 0);
	else pstmt.setInt(4, 1);
	 */
	pstmt.setString(5, request.getParameter("rental"));
	
	pstmt.executeUpdate();
			
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="mbrAdd.jsp"></jsp:forward>
</body>
</html>