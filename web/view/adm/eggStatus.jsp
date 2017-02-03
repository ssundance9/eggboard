<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
전송일시 : <fmt:formatDate value="${farm.regDtm}" pattern="yyyy/MM/dd HH:mm:ss"/>
<br/>
작업계사 : ${farm.farmNo} 번
<br/>
연결상태 : ${farm.connectionStatus}
<br/>
동작상태 : ${farm.status} (0 : 일시정지, 1 : 정상동작, 2 : 에러)

<br/>
---------------
<br/>

<table>
    <tr>
        <td>
                등급
        </td>
        <td>
                무게구간
        </td>
        <td>
                생산비율
        </td>
        <td>
                수량
        </td>
        <td>
                판수
        </td>
        <td>
                중량
        </td>
        <td>
                평균중량
        </td>
    </tr>
    <c:forEach var="egg" items="${eggList}">
	    <tr>
	        <td>
	            ${egg.grade}
	        </td>
	        <td>
	            ${egg.weightRange}
	        </td>
	        <td>
	            ${egg.prodRatio}
	        </td>
	        <td>
	            ${egg.qntty}
	        </td>
	        <td>
	            ${egg.box}
	        </td>
	        <td>
	            ${egg.totalWeight}
	        </td>
	        <td>
	            ${egg.avrgWeight}
	        </td>
	    </tr>
    </c:forEach>
</table>

<br/>
---------------
<br/>

투입량 : ${farm.inputCount}
<br/>
에러메시지 : ${farm.errorCode}
</body>
</html>