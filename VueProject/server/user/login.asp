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

Dim chk, userIdx, userName, userId, userPw
Dim strSQL, Rs

userId = Request("user_id")
userPw = Request("user_pw")

strSQL = "select user_idx, user_name, user_id from user_table where user_id = '" & userId & "' and user_pw = '" & userPw & "'" 
Set Rs = DB.Execute(strSQL)

IF RS.EOF Then
	chk = CBool(false)
Else
	chk = CBool(true)
	userIdx = CInt(rs("user_idx"))
	userName = Trim(rs("user_name"))
	userId = Trim(rs("user_id"))
END IF
'Response.write chk
'Response.End
%>
{
"result" : "<%=chk%>",
"user_idx" : "<%=userIdx%>",
"user_name" : "<%=userName%>",
"user_id" : "<%=userId%>"
}
<%
Set Rs = Nothing
dbClose() 
%>