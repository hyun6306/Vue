<%@Language="VBScript" CODEPAGE="65001" %>

<%Option Explicit%>

<!--#include file="JSON_2.0.4.asp"-->

<%

Response.CharSet = "UTF-8"

Response.ContentType = "application/json"




Dim oJsa

Dim ItemCode, ItemName, ItemDepth

Dim arrItemList(2, 5)

Dim nIndex

Dim param : param = request("param")

'Response.write param
If param = 1 Then '앞단에서 Param값으로 제어 테스트
arrItemList(0, 0) = "12001"

arrItemList(1, 0) = "아이템 1"

arrItemList(2, 0) = "영구제"

Else

arrItemList(0, 0) = "12001"

arrItemList(1, 0) = "아이템 1"

arrItemList(2, 0) = "영구제"




arrItemList(0, 1) = "12002"

arrItemList(1, 1) = "아이템 2"

arrItemList(2, 1) = "기간제"




arrItemList(0, 2) = "12003"

arrItemList(1, 2) = "아이템 3"

arrItemList(2, 2) = "기간제"




arrItemList(0, 3) = "12004"

arrItemList(1, 3) = "아이템 4"

arrItemList(2, 3) = "영구제"




arrItemList(0, 4) = "12005"

arrItemList(1, 4) = "아이템 5"

arrItemList(2, 4) = "영구제"




arrItemList(0, 5) = "12006"

arrItemList(1, 5) = "아이템 6"

arrItemList(2, 5) = "기간제"


End IF

If IsArray(arrItemList) Then

    Set oJsa = jsArray()




    nIndex = 0

    Do Until nIndex > Ubound(arrItemList, 2)

        Set oJsa(Null) = jsObject()




        ItemCode = arrItemList(0, nIndex)

        ItemName = arrItemList(1, nIndex)

        ItemDepth = arrItemList(2, nIndex)




        oJsa(Null)("ItemCode") = ItemCode

        oJsa(Null)("ItemName") = ItemName

        oJsa(Null)("ItemDepth") = ItemDepth




        nIndex = nIndex + 1

    Loop

End If




oJsa.Flush

%>
