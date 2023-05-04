<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
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
	
	// 업로드 파일 최대 용량
	int maxSize = 1024 * 1024 * 100;		// 100mb
	// 이름 변경 정책(중복된 파일명이 올라왔을 경우 뒤에 숫자를 붙힌다)
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	// 저장될 서버상의 경로
	String path = getServletContext().getRealPath("/upload");
	// 업로드 처리
	MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", policy);
	
	String str1 = mr.getParameter("board_writer_idx");
	int board_writer_idx = Integer.parseInt(str1);
	
	String str2 = mr.getParameter("content_board_idx");
	int content_board_idx = Integer.parseInt(str2);
	
	String board_subject = mr.getParameter("board_subject");
	String board_content = mr.getParameter("board_content");
	String board_file = mr.getFilesystemName("board_file");
	
	String sql = "insert into content_table (content_idx, content_subject, content_text, content_file, "
			+ "content_writer_idx, content_board_idx, content_date) "
			+ "values (content_seq.nextval, ?, ?, ?, ?, ?, sysdate)";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, board_subject);
	pstmt.setString(2, board_content);
	pstmt.setString(3, board_file);
	pstmt.setInt(4, board_writer_idx);
	pstmt.setInt(5, content_board_idx);
	
	pstmt.execute();
	
	// 새롭게 추가된 글의 번호를 파악한다.
	String sql2 = "select content_seq.currval as content_idx from dual";
	PreparedStatement pstmt2 = db.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();
	
	int content_idx = rs2.getInt("content_idx");
	
	db.close();
%>
{
	"result" : true,
	"content_idx" : <%= content_idx %>
}














