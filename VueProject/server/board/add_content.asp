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

Dim chk
Dim boardWriterIdx, boardIdx, content_max_idx, contentSubject, contentText, contentFile
Dim strSQL, strSQL2, Rs

boardWriterIdx = Request("content_writer_idx")
boardIdx = Request("board_idx")

contentSubject = Request("content_subject")
contentText = Request("content_text")
contentFile = Request("content_file")
	

strSQL = "insert into content_table (content_idx, content_subject, content_text, content_file, "
strSQL = strSQL & " content_writer_idx, content_board_idx, content_date) "
strSQL = strSQL & " values ((select max(content_idx)+1 from content_table) , '"&contentSubject&"', '"&contentText&"', '"&contentFile&"', '"&boardWriterIdx&"', '"&boardIdx&"', getdate())"

'Response.write strSQL
'Response.end
	
DB.Execute strSQL

' 새롭게 추가된 글의 번호를 파악한다.
strSQL2 = "select max(content_idx) as content_max_idx from content_table"
Set Rs = DB.Execute(strSQL2)

IF Err.number <> 0 Then
	chk = CBool(false)
	Response.write Err.number
	Response.write "에러"
	DB.Close
	Set DB = Nothing
Else
	IF RS.EOF THEN
		Set Rs = Nothing
		dbClose() 
	Else
		IF RS("content_max_idx") > 0 Then
			content_max_idx = rs("content_max_idx")
			chk = CBool(true)
		Else
			chk = CBool(false)
		End If

		Set Rs = Nothing
	END If
End If
%>
{
	"result" : "<%=chk%>",
	"content_idx" : <%= content_max_idx %>
}