<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%
	// 데이터 베이스 접속 정보
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "scott";
	String pw = "1234";
	
	// 접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, id, pw);
	
	request.setCharacterEncoding("utf-8");
	
	String user_id = request.getParameter("user_id");
	
	String sql = "select * from user_table where user_id = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next();
	
	db.close();
%>
{
	"check_result" : <%= chk %>
}
















