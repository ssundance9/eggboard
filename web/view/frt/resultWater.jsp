<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="thead clearfix">
    <ul>
        <li>날짜</li>
        <li>잔류량</li>
    </ul>
</div>

<div class="table_wrap clearfix">
    <table>
        <tbody>
            <c:if test="${empty waterList }">
                <tr>
                    <td colspan="2">데이터가 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach var="water" items="${waterList}">
                <tr>
                    <td>
                        <fmt:parseDate var="workDate" value="${water.workDate}" pattern="yyyyMMdd"/>
                        <fmt:formatDate value="${workDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${water.waterQntty}</td>
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
    <c:forEach var="water" items="${waterList}">
        <c:set var="currentTotal" value="${currentTotal + water.waterQntty}"/>
    </c:forEach>
    <ul>
        <li>합계</li>
        <li>${currentTotal}</li>
    </ul>
</div>