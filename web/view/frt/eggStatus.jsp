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
        //tab menu
        jQuery(".tab_con").hide();
        //jQuery(".tab_con01").show();
        
        jQuery(".tab li a img").each(function(i){
            var src = jQuery(".tab li a img").eq(i).attr("src");
            jQuery(".tab li a img").eq(i).attr("src", src.replace("_on.gif","_off.gif"));
        });
        jQuery(".tab li a").removeClass("active");
        
        <c:if test="${fn:contains(uri, 'eggStatus')}">
            var src = jQuery(".tab li a img").eq(0).attr("src");
            jQuery(".tab li a img").eq(0).attr("src", src.replace("_off.gif","_on.gif"));
            jQuery(".tab li a").eq(0).addClass("active");
            jQuery(".tab_con01").show();
        </c:if>
        <c:if test="${fn:contains(uri, 'eggStatistics')}">
        var src = jQuery(".tab li a img").eq(1).attr("src");
        jQuery(".tab li a img").eq(1).attr("src", src.replace("_off.gif","_on.gif"));
            jQuery(".tab li a").eq(1).addClass("active");
            jQuery(".tab_con02").show();
        </c:if>
        <c:if test="${fn:contains(uri, 'farmStatus')}">
        var src = jQuery(".tab li a img").eq(2).attr("src");
        jQuery(".tab li a img").eq(2).attr("src", src.replace("_off.gif","_on.gif"));
            jQuery(".tab li a").eq(2).addClass("active");
            jQuery(".tab_con03").show();
        </c:if>
        
        $("#fromDate, #toDate, #fromDateFarm, #toDateFarm").datepicker();
        $("#selectSearchDate, #selectSearchDate1").change(function() {
            var val = $(this).val();
            var today = new Date();
            var tYear = today.getFullYear();
            var tMonth = today.getMonth()+1 + "";
            var tDay = today.getDate();
            if (tMonth.length < 2) {
                tMonth = "0" + tMonth;
            }
                        
            if (val == "3") {
                $("#fromDate").datepicker("setDate", "-2d");
                $("#fromDateFarm").datepicker("setDate", "-2d");
            } else if (val == "7") {
                $("#fromDate").datepicker("setDate", "-6d");
                $("#fromDateFarm").datepicker("setDate", "-6d");
                
            } else if (val == "15") {
                $("#fromDate").datepicker("setDate", "-14d");
                $("#fromDateFarm").datepicker("setDate", "-2d");
                
            } else if (val == "30") {
                $("#fromDate").datepicker("setDate", "-29d");
                $("#fromDateFarm").datepicker("setDate", "-29d");
            }
            
            var p = $("#fromDate").datepicker("getDate");
            var month = (p.getMonth() + 1) + "";
            if (month.length < 2) {
                month = "0" + month;
            }
            
            $("input#fromDate").val(p.getFullYear() + "-" + month + "-" + p.getDate());
            $("input#fromDateFarm").val(p.getFullYear() + "-" + month + "-" + p.getDate());
            $("input#toDate").val(tYear + "-" + tMonth + "-" + tDay);
            $("input#toDateFarm").val(tYear + "-" + tMonth + "-" + tDay);
        });
        
        /* jQuery(".tab li a").click(function(){
            
            jQuery(".tab li a img").each(function(i){
                var src = jQuery(".tab li a img").eq(i).attr("src");
                jQuery(".tab li a img").eq(i).attr("src", src.replace("_on.gif","_off.gif"));
            });
            
            var img_src = jQuery(this).find("img").attr("src");
            jQuery(this).find("img").attr("src", img_src.replace("_off.gif","_on.gif"));
            
            jQuery(".tab li a").removeClass("active");
            jQuery(this).addClass("active");
            
            var idx = jQuery(this).index(".tab li a");
            jQuery(".tab_con").hide();
            jQuery(".tab_con0"+(idx+1)).show();
            
            return false; 
        }); */
        
        // 검색 날짜에 따른 width 값
        var thLength = jQuery(".scroll_wrap table thead tr th").length;
        var l = 125 * thLength;
        
        //if(thLengh == '15'){
            //jQuery(".scroll_wrap").css("width","1600px");            
        //}
        //if(thLengh == '7'){
            //jQuery(".scroll_wrap").css("width","880px");
            jQuery(".scroll_wrap").css("width", l + "px");
            //jQuery(".scroll_wrap table tbody td").attr("colspan", thLength);
        //}
        
        $("#selectFarmStatus").change(function() {
            document.location.href = "/frt/eggStatus.do?farmNo=" + $(this).val();
        });
        
        $("#selectFarmStatistics").change(function() {
            document.location.href = "/frt/eggStatistics.do?farmNo=" + $(this).val();
        });
        
        
        var line = new Array();
        var label = new Array();
        var plot1;
        <c:forEach var="dataList" items="${list}" varStatus="vs1">
            <c:forEach var="data" items="${dataList}" varStatus="vs2">
                line[${vs2.index}] = "${data.prodRatio}";
                label[${vs2.index}] = "${data.prodRatio}%(${data.qntty})";
            </c:forEach>
            
            plot1 = $.jqplot('chart${vs1.count}', [line], {
                seriesDefaults: { 
                    showMarker:true,
                    pointLabels: {
                        show:true,
                        labels:label
                    }
                },
                axesDefaults: {
                    showTicks: false,
                    drawMajorGridlines: false,
                    borderWidth: 0,
                    rendererOptions: {
                        drawBaseline: false
                    }
                },
                axes: {
                    xaxis: {
                        pad: 1.1
                    },
                    yaxis: {
                        <c:if test="${not empty maxVal}">
                            max: ${maxVal} + 10,
                        </c:if>
                        min: -10
                    }
                },
                grid: {
                    shadow: false
                }
            });
        </c:forEach>
        
        
        <c:if test="${not empty waterList}">
            var line2 = new Array();
            var label2 = new Array();
            <c:forEach var="w" items="${waterList}" varStatus="vs">
                line2[${vs.index}] = "${w.waterQntty}";
                label2[${vs.index}] = "${w.waterQntty}";
            </c:forEach>
        
            var plot2 = $.jqplot('waterChart', [line2], {
                seriesDefaults: { 
                    showMarker:true,
                    pointLabels: {
                        show:true,
                        labels:label2
                    }
                },
                axesDefaults: {
                    showTicks: false,
                    drawMajorGridlines: false,
                    borderWidth: 0,
                    rendererOptions: {
                        drawBaseline: false
                    }
                },
                axes: {
                    xaxis: {
                        pad: 1.1
                    },
                    yaxis: {
                        max: 2000,
                        min: 0
                    }
                },
                grid: {
                    shadow: false
                }
            });
        </c:if>
        

        <c:if test="${not empty henList}">
            var line3 = new Array();
            var ticks3 = new Array();
            //var s1 = [2, 6, 7, 10];
            //var ticks = ['a', 'b', 'c', 'd'];
            
            <c:forEach var="hen" items="${henList}" varStatus="vs">
                line3[${vs.index}] = ${hen.henCount};
                ticks3[${vs.index}] = "${hen.farmNo}";
            </c:forEach>
            
            //$.jqplot.config.enablePlugins = true;
            var plot3 = $.jqplot('henChart', [line3], {
                // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
                //animate: !$.jqplot.use_excanvas,
                seriesDefaults:{
                    renderer:$.jqplot.BarRenderer,
                    rendererOptions:{ 
                        barWidth: 30
                    },
                    pointLabels: { show: true }
                    
                },
                axesDefaults: {
                    showTicks: false,
                    drawMajorGridlines: false,
                    borderWidth: 0,
                    rendererOptions: {
                        drawBaseline: false
                    }
                },
                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer,
                        rendererOptions: {
                            drawBaseline: true
                        },
                        ticks: ticks3,
                        showTicks:true
                    }
                },
                grid: {
                    shadow: false
                },
                highlighter: { show: false }
            });
        </c:if>
    });
    
    function search1() {
        var farmNo = $("#selectFarmStatistics").val();
        var fromDate = $("#fromDate").val();
        var toDate = $("#toDate").val();
        
        document.location.href = "/frt/eggStatistics.do?farmNo=" + farmNo + "&fromDate=" + fromDate + "&toDate=" + toDate;
    }
    
    function searchBin() {
        var d1 = $("#beforeSearchBin");
        var d2 = $("#afterSearchBin");
        
        if (d1.css("display") == "none") {
            d1.show();
            d2.hide();
            $("#spanSearchBinTxt").html("자료<br/>조회")
        } else {
            $.ajax({
                url: "/frt/searchBin.do",
                data: {fromDateFarm: $("#fromDateFarm").val(), toDateFarm: $("#toDateFarm").val()},
                success: function (data) {
                    d1.hide();
                    d2.html(data);
                    d2.show();
                    $("#spanSearchBinTxt").html("초기화")
                }
            });
        }
    }
    
    function searchWater() {
        var d1 = $("#beforeSearchWater");
        var d2 = $("#afterSearchWater");
        
        if (d1.css("display") == "none") {
            d1.show();
            d2.hide();
            $("#spanSearchWaterTxt").html("자료<br/>조회")
        } else {
            $.ajax({
                url: "/frt/searchWater.do",
                data: {fromDateFarm: $("#fromDateFarm").val(), toDateFarm: $("#toDateFarm").val()},
                success: function (data) {
                    d1.hide();
                    d2.html(data);
                    d2.show();
                    $("#spanSearchWaterTxt").html("초기화")
                }
            });
        }
    }
    </script>
</head>
<body>
<div class="wrapper">
    <!-- S: header -->
    <header role="banner">
        <div class="header">
            <h1 class="logo"><a href="/frt/eggStatus.do"><img src="/images/logo.gif" alt="EGG-Board" /></a></h1>
            <a href="http://www.eggtec.com" class="btn-mypage">
                <img src="/images/sub_logo.gif" alt="eggtec" />
            </a>
        </div>
    </header>
    <!-- E: header -->

    <!-- S: contents -->
    <article>
        <div class="contents main_contents clearfix">
            <!-- S: link_state -->
            <div class="link_state">
                <div class="today">
                    <p>
                        <fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>
                    </>
                    <p>
                        <fmt:formatDate value="${today}" pattern="E"/>요일
                    </p>
                </div>
                <div class="login_info">
                    <p>
                        <c:if test="${empty user.photoInfo}">
                            <img src="/images/img_farm.gif" width="100%" height="auto" alt="농장이름" />
                        </c:if>
                        <c:if test="${not empty user.photoInfo}">
                            <img src="${user.photoInfo }" width="100%" height="auto" alt="농장이름" />
                        </c:if>
                        <span style="position: static;">${user.farmName}</span>
                    </p>
                    
                    <p><a href="/logout.do">로그아웃</a></p>
                    <p><a href="/frt/mypageView.do">정보수정</a></p>
                </div>
                <div class="data">
                    <div class="communication">
                        <p>통신</p>
                        <c:if test="${empty farm.connectionStatus}">
                            <!-- <p>연결안됨</p> -->
                            <p>
                                <img src="/images/img_con_off.png" style="height: 100%;width: 100%;"/>
                            </p>
                        </c:if>
                        <c:if test="${farm.connectionStatus == '0'}">
                            <p class="gradient02">에러</p>
                        </c:if>
                        <c:if test="${farm.connectionStatus == '1'}">
                            <p class="gradient01">정상</p>
                        </c:if>
                    </div>
                    <div class="equipment">
                        <p>장비연결</p>
                        <c:if test="${empty farm.status}">
                            <!-- <p>연결안됨</p> -->
                            <p>
                                <img src="/images/img_con_off.png" style="height: 100%;width: 100%;"/>
                            </p>
                        </c:if>
                        <c:if test="${farm.status == '0'}">
                            <p class="gradient02">에러</p>
                        </c:if>
                        <c:if test="${farm.status == '1'}">
                            <p class="gradient01">정상</p>
                        </c:if>
                    </div>
                </div>
                <div class="now_state">
                    <p>
                        <c:if test="${empty errorCode }">
                            <span class="gradient03">정상 동작중</span>
                        </c:if>
                    </p>
                    <p class="time">
                        <fmt:formatDate value="${today}" pattern="HH시 mm분"/>
                    </p>
                    <p>현재 상태는
                        <br/>
                        <c:if test="${empty errorCode }">
                            정상 동작중입니다.
                        </c:if>
                    </p>
                    <p class="refresh"><a href="javascript://" onclick="document.location.reload();">새로고침<i></i></a></p>
                </div>
                <p class="neonics"><img src="/images/img_neonics.gif" width="100%" height="auto" alt="Solution by NEONICS" /></p>
            </div>
            <!-- E: link_state -->
            
            <!-- S: contents_detail -->
            <div class="contents_detail_wrap">
                <div class="contents_detail">
                    <div class="graph_box clearfix">
                    
                        <div class="con_top_left">
                        
                            <!-- S: 계군계사총수 -->
                            <div class="con_top henhouseNo">
                                <span><img src="/images/con_title01.gif" alt="계군계사총수" /></span>
                                <div class="graph">
                                    <p>${fn:length(henList)}</p>
                                    <div></div>
                                </div>
                            </div>
                            <!-- E: 계군계사총수 -->
                            
                            <!-- S: 계군개체총수 -->
                            <div class="con_top henNo">
                                <span><img src="/images/con_title02.gif" alt="계군개체총수" /></span>
                                <div class="graph">
                                    <c:forEach var="hen" items="${henList}">
                                        <c:set var="henTotalCount" value="${henTotalCount + hen.henCount}"/>
                                    </c:forEach>
                                    <p>
                                        <fmt:formatNumber value="${henTotalCount}" pattern="#,###"/>
                                    </p>
                                    <div></div>
                                </div>
                            </div>
                            <!-- E: 계군개체총수 -->
                        
                        </div>
                    
                        <!-- S: 계사별개체정보 -->
                        <div class="con_top henhouse_graph">
                            <span><img src="/images/con_title03.gif" alt="계사별개체정보" /></span>
                            <div class="graph" id="henChart">
                            </div>
                        </div>
                        <!-- E: 계사별개체정보 -->
                    </div>
                    
                    <div class="tab_wrap">
                        <span class="btn small"><a href=""><i></i>인쇄</a></span>
                        
                        <!-- S: tab manu -->
                        <ul class="tab">
                            <li><a href="/frt/eggStatus.do?farmNo=1" class="tab_list01 active"><img src="/images/tab_list01_on.gif" alt="선별현황" /></a></li>
                            <li><a href="/frt/eggStatistics.do?farmNo=1" class="tab_list02"><img src="/images/tab_list02_off.gif" alt="선별통계" /></a></li>
                            <li><a href="/frt/farmStatus.do?farmNo=1" class="tab_list03"><img src="/images/tab_list03_off.gif" alt="시설현황" /></a></li>
                            <li><a href="javascript://" class="tab_list04" onclick="alert('서비스 준비중 입니다.');">
                                    <img src="/images/tab_list04_off.gif" alt="산란통계" />
                                </a>
                            </li>
                        </ul>
                        <!-- E: tab manu -->
                        
                        <!-- S: tab_con01 -->
                        <div class="tab_con tab_con01">
                            <div class="select_table">
                                <ul>
                                    <li>
                                        <span><img src="/images/select_table_txt01.gif" alt="현재 작업 계사" /></span>
                                        <select id="selectFarmStatus">
                                            <c:forEach var="hen" items="${henList}">
                                                <option value="${hen.farmNo}" <c:if test="${param.farmNo == hen.farmNo}">selected="selected"</c:if>>
                                                    계사 #${hen.farmNo}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </li>
                                    <li>
                                        <span><img src="/images/select_table_txt02.gif" alt="산란계수" /></span>
                                        <input type="text" id="" name="" value="${farm.inputCount}" readonly="readonly"/>
                                    </li>
                                </ul>
                            </div>
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
                        
                        <!-- S: tab_con02 -->
                        <div class="tab_con tab_con02">
                            <div class="select_table">
                                <ul>
                                    <li>
                                        <span><img src="/images/select_table_txt03.gif" alt="현재 작업 계사" /></span>
                                        <select id="selectFarmStatistics">
                                            <c:forEach var="hen" items="${henList}">
                                                <option value="${hen.farmNo}" <c:if test="${param.farmNo == hen.farmNo}">selected="selected"</c:if>>
                                                    계사 #${hen.farmNo}
                                                </option>
                                            </c:forEach>
                                        </select>  
                                    </li>
                                    <li>
                                        <span><img src="/images/select_table_txt04.gif" alt="기간지정" /></span>
                                        <select id="selectSearchDate">
                                            <option value="0">선택</option>
                                            <option value="3">최근3일</option>
                                            <option value="7">최근7일</option>
                                            <option value="15">최근15일</option>
                                            <option value="30">최근30일</option>
                                        </select>
                                        
                                        <a href="javascript://" class="date">
                                            <span>
                                                <fmt:parseDate var="fromDate1" value="${fromDate}" pattern="yyyyMMdd"/>
                                                <fmt:formatDate var="fromDate2" value="${fromDate1}" pattern="yyyy-MM-dd"/>
                                                <input type="text" name="fromDate" value="${fromDate2}" id="fromDate" style="height: 43px;margin-bottom: 2px;border: 0;" readonly="readonly"/>
                                            </span>
                                            <span class="icon_calender" style="right: -6px;"></span>
                                        </a>
                                        ~
                                        <a href="javascript://" class="date">
                                            <span>
                                                <fmt:parseDate var="toDate1" value="${toDate}" pattern="yyyyMMdd"/>
                                                <fmt:formatDate var="toDate2" value="${toDate1}" pattern="yyyy-MM-dd"/>
                                                <input type="text" name="toDate" value="${toDate2}" id="toDate" style="height: 43px;margin-bottom: 2px;border: 0;" readonly="readonly"/>
                                            </span>
                                            <span class="icon_calender" style="right: -6px;"></span>
                                        </a>                 
                                        <div class="btn medium">
                                            <a href="javascript://" onclick="search1();">검색</a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            
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
                        
                        <!-- S: tab_con03 -->
                        <div class="tab_con tab_con03">
                            <div class="select_table">
                                <ul>
                                    <li>
                                        <span><img src="/images/img_white.gif" alt="흰색이미지" /></span>
                                        <!-- <span><img src="/images/select_table_txt03.gif" alt="계사현황" /></span> -->
                                        <!-- <select>
                                            <option>전체</option>
                                        </select> -->
                                    </li>
                                    <li>
                                        <div class="select_right">
                                            <span><img src="/images/select_table_txt04.gif" alt="기간조회" /></span>
                                            <select id="selectSearchDate1">
                                                <option value="3">최근3일</option>
                                                <option value="7">최근7일</option>
                                                <option value="15">최근15일</option>
                                                <option value="30">최근30일</option>
                                            </select>
                                            
                                            <!-- <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>  ~  
                                            <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>                 
                                            <div class="btn medium"><a href="/">검색</a></div> -->
                                            
                                            <a href="javascript://" class="date">
                                                <span>
                                                    <fmt:parseDate var="fromDateFarm1" value="${fromDateFarm}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="fromDateFarm2" value="${fromDateFarm1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="fromDateFarm" value="${fromDateFarm2}" id="fromDateFarm" style="height: 43px;margin-bottom: 2px;border: 0;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender" style="right: -6px;"></span>
                                            </a>
                                            ~
                                            <a href="javascript://" class="date">
                                                <span>
                                                    <fmt:parseDate var="toDateFarm1" value="${toDateFarm}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="toDateFarm2" value="${toDateFarm1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="toDateFarm" value="${toDateFarm2}" id="toDateFarm" style="height: 43px;margin-bottom: 2px;border: 0;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender" style="right: -6px;"></span>
                                            </a>                 
                                            <!-- <div class="btn medium">
                                                <a href="javascript://" onclick="search2();">검색</a>
                                            </div> -->
                                            
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="facility">
                                <ul>
                                    <li>
                                        <span class="title"><span class="title_txt">급이<br>시설</span></span>
                                        <!-- S: 조회전 -->
                                        <div class="data before" id="beforeSearchBin">
                                            <ul>
                                                <c:if test="${empty binList}">
                                                    <li>
                                                        <img src="/images/img_bin_1_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images/img_bin_2_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images/img_bin_3_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images/img_bin_4_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images/img_bin_5_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images/img_bin_6_off.gif" alt="images" />
                                                        <span class="left">잔량:&nbsp;<em>0</em>kg</span>
                                                    </li>
                                                </c:if>
                                                <c:forEach var="bin" items="${binList}" varStatus="vs">
                                                    
                                                
                                                
                                                    <li>
                                                        <c:if test="${bin.binNo == 1 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_1_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 1 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_1_off.gif" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 2 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_2_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 2 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_2_off.gif" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 3 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_3_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 3 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_3_off.gif" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 4 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_4_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 4 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_4_off.gif" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 5 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_5_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 5 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_5_off.gif" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 6 && bin.currentWeight != -1}">
                                                            <img src="/images/img_bin_6_on.jpg" alt="images" />
                                                        </c:if>
                                                        <c:if test="${bin.binNo == 6 && bin.currentWeight == -1}">
                                                            <img src="/images/img_bin_6_off.gif" alt="images" />
                                                        </c:if>
                                                        <span class="left">
                                                            잔량:&nbsp;<em>${bin.currentWeight}</em>&nbsp;kg
                                                        </span>
                                                    </li>
                                                </c:forEach>
                                                <!-- <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:&nbsp;<em>5</em>&nbsp;kg</span>
                                                </li> -->
                                            </ul>
                                        </div>
                                        <!-- E: 조회전 -->
                                        
                                        <!-- S: 조회후 -->
                                        <div class="data after" id="afterSearchBin" style="display: none;">
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
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                        </tr>
                                                        <tr>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                        </tr>
                                                        <tr>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
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
                                        </div>
                                        <!-- E: 조회후 -->
                                        <div class="btn_big">
                                            <a href="javascript://" onclick="searchBin();">
                                                <span class="btn_txt" id="spanSearchBinTxt">자료<br/>조회</span>
                                            </a>
                                        </div>
                                    </li>
                                    <li>
                                        <span class="title"><span class="title_txt">급수<br>시설</span></span>
                                        <!-- S: 조회전 -->
                                        <div class="data before" id="beforeSearchWater">
                                            <table>
                                                <tr>
                                                    <c:if test="${empty waterList}">
                                                        <td>00</td>
                                                        <td>01</td>
                                                        <td>02</td>
                                                        <td>03</td>
                                                        <td>04</td>
                                                        <td>05</td>
                                                        <td>06</td>
                                                        <td>07</td>
                                                        <td>08</td>
                                                        <td>09</td>
                                                        <td>10</td>
                                                        <td>11</td>
                                                        <td>12</td>
                                                        <td>13</td>
                                                        <td>14</td>
                                                        <td>15</td>
                                                        <td>16</td>
                                                        <td>17</td>
                                                        <td>18</td>
                                                        <td>19</td>
                                                        <td>20</td>
                                                        <td>21</td>
                                                        <td>22</td>
                                                        <td>23</td>
                                                    </c:if>
                                                    <c:forEach var="water" items="${waterList}">
                                                        <td>
                                                            <fmt:formatDate value="${water.regDtm}" pattern="HH"/>
                                                        </td>
                                                    </c:forEach>
                                                    <!-- <td>1</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td> -->
                                                </tr>
                                                <tr class="graph_td">
                                                    <c:if test="${empty waterList}">
                                                        <td colspan="24">
                                                            데이터가 없습니다.
                                                        </td>
                                                    </c:if>
                                                    <td colspan="${fn:length(waterList)}">
                                                        <div id="waterChart" style="height: 150px;"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <!-- E: 조회전 -->
                                        
                                        <!-- S: 조회후 -->
                                        <div class="data after" id="afterSearchWater" style="display: none;">
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
                                                            <td>datd</td>
                                                            <td>datd</td>
                                                            <td>datd</td>
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
                                        </div>
                                        <!-- E: 조회후 -->
                                        <div class="btn_big">
                                            <a href="javascript://" onclick="searchWater();">
                                                <span class="btn_txt" id="spanSearchWaterTxt">자료<br/>조회</span>
                                            </a>
                                        </div>
                                        <!-- <div class="btn_big"><a href=""><span class="btn_txt">초기화</span></a></div> -->
                                    </li>
                                </ul>
                                
                                <!-- S: last -->
                                <ul class="last">
                                    <li>
                                        <span class="title"><span class="title_txt">계사<br>시설</span></span>
                                        <div class="facility_info">
                                            <span class="img"><img src="/images/img_facility.gif" alt="imags" /></span>
                                            <table class="temp" style="width: 15%;">
                                                <tbody>
                                                    <c:if test="${empty thermoList }">
                                                        <tr>
                                                            <th>T1</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>T2</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>T3</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>T4</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="thermo" items="${thermoList}">
                                                        <tr>
                                                            <th>T${thermo.thermometerNo}</th>
                                                            <td>${thermo.degree}°C</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <!-- <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr> -->
                                                </tbody>
                                            </table>
                                            <table class="temp" style="width: 15%;">
                                                <tbody>
                                                    <c:if test="${empty lightList }">
                                                        <tr>
                                                            <th>조도1</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>조도2</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>조도3</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <th>조도4</th>
                                                            <td>N/A</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="light" items="${lightList}">
                                                        <tr>
                                                            <th>조도${light.lightNo}</th>
                                                            <td>${light.lux}lux</td>
                                                        </tr>
                                                    </c:forEach>
                                                    <!-- <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr> -->
                                                </tbody>
                                            </table>
                                            <table class="fan" style="width: 15%;float: left;">
                                                <tbody>
                                                    <c:if test="${empty fanList }">
                                                        <tr>
                                                            <td>FAN-1 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-2 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-3 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-4 N/A</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="fan" items="${fanList}" varStatus="fVs">
                                                        <c:if test="${fVs.index >= 0 && fVs.index < 4}">
                                                            <tr>
                                                                <c:if test="${fan.status == '2' }">
                                                                    <td style="background-color: Red">FAN-${fan.fanNo} ERR</td>
                                                                </c:if>
                                                                <c:if test="${fan.status == '1' }">
                                                                    <td class="on" style="background-color: LimeGreen">FAN-${fan.fanNo} ON</td>
                                                                </c:if>
                                                                <c:if test="${fan.status == '0' }">
                                                                    <td style="background-color: Grey">FAN-${fan.fanNo} OFF</td>
                                                                </c:if>
                                                                
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    <!-- <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr>
                                                    <tr>
                                                        <td>FAN-1 OFF</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td class="on">FAN-1 ON</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr> -->
                                                </tbody>
                                            </table>
                                            <table class="fan" style="width: 15%;">
                                                <tbody>
                                                    <c:if test="${empty fanList }">
                                                        <tr>
                                                            <td>FAN-5 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-6 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-7 N/A</td>
                                                        </tr>
                                                        <tr>
                                                            <td>FAN-8 N/A</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="fan" items="${fanList}" varStatus="fVs">
                                                        <c:if test="${fVs.index >= 4}">
                                                            <tr>
                                                                <c:if test="${fan.status == '2' }">
                                                                    <td style="background-color: Red">FAN-${fan.fanNo} ERR</td>
                                                                </c:if>
                                                                <c:if test="${fan.status == '1' }">
                                                                    <td class="on" style="background-color: LimeGreen">FAN-${fan.fanNo} ON</td>
                                                                </c:if>
                                                                <c:if test="${fan.status == '0' }">
                                                                    <td style="background-color: Grey">FAN-${fan.fanNo} OFF</td>
                                                                </c:if>
                                                                
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <!-- <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr>
                                                    <tr>
                                                        <td>FAN-1 OFF</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td class="on">FAN-1 ON</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="on">FAN-1 ON</td>
                                                        <td>FAN-1 OFF</td>
                                                    </tr> -->
                                                </tbody>
                                            </table>
                                        </div>
                                    </li>
                                </ul>
                                <!-- E: last -->
                            </div>
                        </div>
                        <!-- E: tab_con03 -->
                        
                        <!--<div class="tab_con tab_con04"></div>
                        -->
                    </div>
                </div>
            </div>
            <!-- E: contents_detail -->
        </div>

    </article>
    <!-- E: contents -->

            

    <!-- Footer -->
    <footer>
        <!-- S: Site Info -->
        <div class="siteInfo clearfix">
            <ul>
                <li>
                    <a href="http://eggtec.com/%ED%9A%8C%EC%82%AC%EA%B0%9C%EC%9A%94/" target="blank">회사소개</a>
                </li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보취급방침</a></li>
                <!-- <li><a href="#">이용안내</a></li> -->
                <li>
                    <a href="http://eggtec.com/%EC%A0%9C%ED%92%88%EB%AC%B8%EC%9D%98/" target="blank">문의게시판</a>
                </li>
                <!--<li><a href="https://www.twayair.com/main.do?frontYn=Y">PC버전</a></li>-->
            </ul>
        </div>
        <!-- E: Site Info -->
        <p class="copyright" role="contentinfo"><small>Copyright &copy; EGGBoard.co.kr All Rights Reserved.</small></p>
    </footer>
    <!-- Footer -->
</div>

</body>
</html>