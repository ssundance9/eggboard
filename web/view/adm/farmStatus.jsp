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
연결상태 : ${farm.connectionStatus}

<br/>
---------------
<br/>
계사시설 : ${farm.farmNo}번
<br/>
<br/>

급이정보 :
<c:forEach var="bin" items="${binList}">
    사료빈${bin.binNo}번 - 잔류량 ${bin.currentWeight}, 추가량${bin.addWeight}, 사용량${bin.usedWeight} /
</c:forEach>

<br/>
<br/>

급수정보 : ${farm.waterQntty}

<br/>
<br/>

온도정보 :
<c:forEach var="thermo" items="${thermoList}">
    온도${thermo.thermometerNo} - ${thermo.degree} /
</c:forEach>

<br/>
<br/>

조명정보 :
<c:forEach var="light" items="${lightList}">
    조도${light.lightNo} - ${light.lux} /
</c:forEach>

<br/>
<br/>

환풍기정보 :
<c:forEach var="fan" items="${fanList}">
    ${fan.fanNo} - ${fan.status} /
</c:forEach>


</body>
</html>