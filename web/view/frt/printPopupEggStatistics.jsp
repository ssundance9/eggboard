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
                            <img src="/images/tab_list02_on.gif" alt="선별현황" />
                        </div>
                        <span class="btn small">
                            <a href="javascript://" onclick="window.print();">
                                <i></i>인쇄
                            </a>
                        </span>
                        <br/>
                        <br/>
                        <br/>
                        <!-- S: tab_con02 -->
                        <div class="tab_con tab_con02" style="display: block;">
                            <div class="table_graph">
                                <ul class="graph_grade">
                                    <li>등급</li>
                                    <li>왕란</li>
                                    <li>특란</li>
                                    <li>대란</li>
                                    <li>중란</li>
                                    <li>소란</li>
                                    <li>경란</li>
                                    <li>오란</li>
                                    <li>파란</li>
                                    <li>등외</li>
                                </ul>
                                <div class="graph_scroll">
                                    <div class="scroll_wrap">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <c:if test="${not empty list}">
                                                        <c:forEach var="data" items="${list[0]}">
                                                            <th>
                                                                <fmt:parseDate var="workDate" value="${data.workDate}" pattern="yyyyMMdd"/>
                                                                <fmt:formatDate value="${workDate}" pattern="MM월dd일"/>
                                                            </th>
                                                        </c:forEach>
                                                        <c:set var="thLength" value="${fn:length(list[0])}"/>
                                                    </c:if>
                                                    <c:if test="${empty list}">
                                                        <%-- <th>
                                                            <fmt:parseDate var="workDate" value="${fromDate}" pattern="yyyyMMdd"/>
                                                            <fmt:formatDate value="${workDate}" pattern="MM월dd일"/>
                                                        </th>
                                                        <th>~</th>
                                                        <th>
                                                            <fmt:parseDate var="workDate" value="${toDate}" pattern="yyyyMMdd"/>
                                                            <fmt:formatDate value="${workDate}" pattern="MM월dd일"/>
                                                        </th> --%>
                                                        <th colspan="3">
                                                            날짜를 선택해 주세요.
                                                        </th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                        <c:set var="thLength" value="7"/>
                                                    </c:if>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart1" style="height:56px;">
                                                            <c:if test="${empty list}">
                                                                <br/>
                                                                데이터가 없습니다.
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart2" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart3" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart4" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart5" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart6" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart7" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart8" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="${thLength}">
                                                        <div id="chart9" style="height:56px;"></div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- E: tab_con02 -->
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
