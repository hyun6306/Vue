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
	
	// 글 번호를 받는다.
	String str1 = request.getParameter("content_idx");
	int content_idx = Integer.parseInt(str1);
	
	String sql = "select a1.content_idx, a1.content_subject, a1.content_text, a1.content_file, "
    		   + "a1.content_writer_idx, a2.user_name, to_char(a1.content_date, 'YYYY-MM-DD') as content_date "
			   + "from content_table a1, user_table a2 "
			   + "where a1.content_writer_idx = a2.user_idx "
  			   + "and a1.content_idx=?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, content_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	JSONObject root = new JSONObject();
	
	root.put("content_idx", rs.getInt("content_idx"));
	root.put("content_subject", rs.getString("content_subject"));
	root.put("content_text", rs.getString("content_text"));
	root.put("content_file", rs.getString("content_file"));
	root.put("content_writer_idx", rs.getInt("content_writer_idx"));
	root.put("content_writer_name", rs.getString("user_name"));
	root.put("content_date", rs.getString("content_date"));
	
	db.close();
%>
<%= root.toJSONString() %>




















