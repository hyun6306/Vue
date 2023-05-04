<!--METADATA type="typelib" file="c:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%@Language="VBScript" CODEPAGE="65001" %>
<%Option Explicit%>

<%
Response.CharSet = "UTF-8"

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
%>

<% 
Dim intUserIdx
Dim strUserName
Dim strUserId
Dim strUserPw
Dim strSQL
Dim result

'intUserIdx = Request("user_name")
strUserName = Request("user_name")
strUserId = Request("user_id")
strUserPw = Request("user_pw")

'strUserName = "홍길동"
'strUserId = "abcd"
'strUserPw = "1234"

'On Error Resume Next
DB.BeginTrans

strSQL="INSERT INTO user_table (user_name,user_id,user_pw) "
strSQL = strSQL & "  values('" & strUserName & "','" & strUserId & "','" & strUserPw & "')"
DB.Execute strSQL

IF Err.number <> 0 Then
	Response.write Err.number
	Response.write "에러"
	'Response.write "result:false"
	DB.RollbackTrans	
	DB.Close
	Set DB = Nothing
Else
	'Response.write True
	'Response.write "result:true"
	DB.CommitTrans
	DB.Close
	Set DB = Nothing
End If	
%>
{
	"result" : "True"
}