<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="KO">
<head>
    <meta charset="utf-8">
    <meta property="og:title" content="EGG-Board">
    <meta property="og:url" content="https://www.???.com/">
    <meta property="og:description" content="" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>EGG-Board</title>
    <link type="text/css" rel="stylesheet" href="/css/global.css" />    
    <link type="text/css" rel="stylesheet" href="/css/style_pc.css" />
    <link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="/css/jquery.jqplot.min.css" />
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/jquery.jqplot.min.js"></script>
    <script src="/js/plugins/jqplot.pointLabels.js"></script>
    <script src="/js/plugins/jqplot.barRenderer.js"></script>
    <script src="/js/plugins/jqplot.categoryAxisRenderer.js"></script>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
    jQuery(document).ready(function(){

    });
    
    </script>
</head>
<body>
<div class="wrapper">
    <!-- S: contents -->
    <article>
        <div class="contents main_contents clearfix" style="background: white;">
            <!-- S: contents_detail -->
            <div>
                <div>
                    <div class="tab_wrap">
                        <div style="margin-top: 20px; margin-left: 50px;">
                            <img src="/images/tab_list01_on.gif" alt="선별현황" />
                            &nbsp;&nbsp;&nbsp;<fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>
                        </div>
                        <span class="btn small">
                            <a href="javascript://" onclick="window.print();">
                                <i></i>인쇄
                            </a>
                        </span>
                        <br/>
                        <br/>
                        <br/>
                        <!-- S: tab_con01 -->
                        <div class="tab_con tab_con01" style="display: block;">
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>등급</th>
                                            <th>무게구간</th>
                                            <th>생산비율</th>
                                            <th>생산수량</th>
                                            <th>생산판수</th>
                                            <th>생산중량</th>
                                            <th>평균중량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty eggList }">
                                            <tr>
                                                <th></th>
                                                <td colspan="6">데이터가 없습니다.</td>
                                                <!-- <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td> -->
                                            </tr>
                                        </c:if>
                                        <c:forEach var="egg" items="${eggList}">
                                            <tr>
                                                <th>${egg.gradeName}</th>
                                                <td></td>
                                                <td>${egg.prodRatio}</td>
                                                <td>${egg.qntty}</td>
                                                <td>${egg.box}</td>
                                                <td>${egg.totalWeight}</td>
                                                <td>${egg.avrgWeight}</td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <th colspan="3" class="sum"><img src="/images/table_th_sum.gif" alt="생산항목 합계" /></th>
                                            <c:forEach var="egg" items="${eggList}">
                                                <c:set var="totalQntty" value="${totalQntty + egg.qntty}"/>
                                            </c:forEach>
                                            <c:forEach var="egg" items="${eggList}">
                                                <c:set var="totalBox" value="${totalBox + egg.box}"/>
                                            </c:forEach>
                                            <td>
                                                ${totalQntty}
                                            </td>
                                            <td>
                                                ${totalBox}
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                    
                                </table>
                            </div>
                        </div>
                        <!-- E: tab_con01 -->
                    </div>
                </div>
            </div>
            <!-- E: contents_detail -->
        </div>

    </article>
    <!-- E: contents -->
</div>

</body>
</html>
