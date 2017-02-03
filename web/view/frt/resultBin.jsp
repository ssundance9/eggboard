<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="thead clearfix">
    <ul>
        <li>날짜</li>
        <li>잔류량</li>
        <li>추가량</li>
        <li>사용량</li>
    </ul>
</div>

<div class="table_wrap clearfix">
    <table>
        <tbody>
            <c:if test="${empty binList }">
                <tr>
                    <td colspan="4">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach var="bin" items="${binList}">
                <tr>
                    <td>
                        <fmt:parseDate var="workDate" value="${bin.workDate}" pattern="yyyyMMdd"/>
                        <fmt:formatDate value="${workDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${bin.currentWeight}</td>
                    <td>${bin.addWeight}</td>
                    <td>${bin.usedWeight}</td>
                </tr>
            </c:forEach>
            
            <!-- <tr>
                <td>datd</td>
                <td>datd</td>
                <td>datd</td>
                <td>datd</td>
            </tr> -->
           
        </tbody>
    </table>
</div>
<div class="tfoot clearfix">
    <c:forEach var="bin" items="${binList}">
        <c:set var="currentTotal" value="${currentTotal + bin.currentWeight}"/>
        <c:set var="addTotal" value="${addTotal + bin.addWeight}"/>
        <c:set var="usedTotal" value="${usedTotal + bin.usedWeight}"/>
    </c:forEach>
    <ul>
        <c:if test="${empty binList }">
            <li>합계</li>
            <li>-</li>
            <li>-</li>
            <li>-</li>
        </c:if>
        <c:if test="${not empty binList }">
            <li>합계</li>
            <li>${currentTotal}</li>
            <li>${addTotal}</li>
            <li>${usedTotal}</li>
        </c:if>
        
    </ul>
</div>