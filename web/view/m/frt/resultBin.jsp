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
            <tr>
                <td>2017/01/01</td>
                <td>9999</td>
                <td>9999</td>
                <td>9999</td>
            </tr>
        </tbody>
    </table>
</div>
<div class="tfoot clearfix">
    <ul>
        <li>합계</li>
        <li>999</li>
        <li>999</li>
        <li>999</li>
    </ul>
</div>


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
            <c:forEach var="bin" items="${binList}">
                <tr>
                    <td>
                        <fmt:parseDate var="workDate" value="${bin.workDate}" pattern="yyyyMMdd"/>
                        <fmt:formatDate value="${workDate}" pattern="yyyy년MM월dd일"/>
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
        <li>합계</li>
        <li>${currentTotal}</li>
        <li>${addTotal}</li>
        <li>${usedTotal}</li>
    </ul>
</div>