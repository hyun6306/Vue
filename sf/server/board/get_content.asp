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

Dim contentIdx
Dim strSQL

contentIdx = Request("content_idx")
'intBoardIdx = 1

strSQL = "select a1.content_idx, a1.content_subject, a1.content_text, a1.content_file, "
strSQL = strSQL & " a1.content_writer_idx, a2.user_name, a1.content_date "
strSQL = strSQL & " from content_table a1, user_table a2 "
strSQL = strSQL & " where a1.content_writer_idx = a2.user_idx "
strSQL = strSQL & " and a1.content_idx="&contentIdx

'Response.write strSQL
'Response.end
QueryToJSON(DB, strSQL).Flush
dbClose()
%> 
