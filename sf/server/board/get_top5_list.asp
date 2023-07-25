<!--METADATA type="typelib" file="c:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@Language="VBScript" CODEPAGE="65001" %>
<%Option Explicit%>

<!--#include file="../../include/JSON_2.0.4.asp"-->
<!--#include file="../../include/JSON_UTIL_0.1.1.asp"-->

<%
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

	Dim strDbName
	Dim strDbUserId
	Dim strDbUserPwd
	Dim strDbIp
	Dim DB
	Dim strConnection	
	Dim col

	strDbName = "MuticampusVue"	'데이터베이스 이름
	strDbUserId = "sa"	'데이터베이스 ID
	strDbUserPwd = "P@4002732!"	'데이터베이스 PW
	'strDbIp = "127.0.0.1"	'데이터베이스 IP
	strDbIp = "KOHLAIT2302041\SQLEXPRESS"	'데이터베이스 IP	

	strConnection = "Provider=SQLOLEDB;Data Source="& strDbIp &";Initial Catalog="& strDbName &";User ID="&strDbUserId&";Password="&strDbUserPwd&";Persist Security Info=True;"
	Set DB = Server.CreateObject("ADODB.Connection")
	DB.Open strConnection

' ------------------------------
' 사용자정의함수
' ------------------------------
' DB 연결 사용안함

Function dbCon(host, name, user, pass)
	Set DB = Server.CreateObject("ADODB.Connection")

	strCon = "Provider=SQLOLEDB;Data Source=" & host & ";Initial Catalog=" & name & ";User ID=" & user & ";Password=" & pass & ";Persist Security Info=True;"

	DB.Open strCon
End Function

' DB 닫기
Function dbClose() 
	DB.Close 
	Set DB = Nothing 
End Function

Dim strSQL
Dim intBoardIdx
intBoardIdx = Request("board_idx")
'intBoardIdx = 1

strSQL = "SELECT *  FROM "
strSQL = strSQL & " (  "
strSQL = strSQL & " 	select "
strSQL = strSQL & " 		Row_Number() Over (Order By a1.content_date desc ) AS RowNum, "
strSQL = strSQL & "			a1.content_idx, a1.content_subject, convert(varchar(10),a1.content_date,120) as content_date, a2.user_name  "
strSQL = strSQL & "		from content_table a1, user_table a2 "
strSQL = strSQL & "		where a1.content_writer_idx = a2.user_idx "
strSQL = strSQL & "		and a1.content_board_idx="&intBoardIdx
strSQL = strSQL & ") TB "
strSQL = strSQL & "where RowNum >= 1 and RowNum <= 5  "

'Response.write strSQL
'Response.end

'QueryToJSON(DB, "select board_info_name from board_info_table where board_info_idx =" & intBoardIdx).Flush 
QueryToJSON(DB, strSQL).Flush
dbClose()
%> 
