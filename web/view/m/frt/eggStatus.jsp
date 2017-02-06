<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, intial-scale=1.0, target-densitydpi=device-dpi">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>EGG-Board main</title>
    
    <link type="text/css" rel="stylesheet" href="/css/global_m.css" />
    <link type="text/css" rel="stylesheet" href="/css/style_m.css" />
    <link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css" />
    <link type="text/css" rel="stylesheet" href="/css/jquery.jqplot.min.css" />
    <!-- Script -->
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/jquery.jqplot.min.js"></script>
    <script src="/js/plugins/jqplot.pointLabels.js"></script>
    <script src="/js/common.js"></script>
    
    <script type="text/javascript">
    jQuery(document).ready(function(){
        
        //tab menu
        jQuery(".tab_con").hide();
        jQuery(".tab li a img").each(function(i){
            var src = jQuery(".tab li a img").eq(i).attr("src");
            jQuery(".tab li a img").eq(i).attr("src", src.replace("_on.png","_off.png"));
        });
        jQuery(".tab li a").removeClass("active");
        
        <c:if test="${fn:contains(uri, 'eggStatus')}">
            var src = jQuery(".tab li a img").eq(0).attr("src");
            jQuery(".tab li a img").eq(0).attr("src", src.replace("_off.png","_on.png"));
            jQuery(".tab li a").eq(0).addClass("active");
            jQuery(".tab_con01").show();
        </c:if>
        <c:if test="${fn:contains(uri, 'eggStatistics')}">
        var src = jQuery(".tab li a img").eq(1).attr("src");
        jQuery(".tab li a img").eq(1).attr("src", src.replace("_off.png","_on.png"));
            jQuery(".tab li a").eq(1).addClass("active");
            jQuery(".tab_con02").show();
        </c:if>
        <c:if test="${fn:contains(uri, 'farmStatus')}">
        var src = jQuery(".tab li a img").eq(2).attr("src");
        jQuery(".tab li a img").eq(2).attr("src", src.replace("_off.png","_on.png"));
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
        
        //퀵메뉴
        $(".btn-mypage").click(function(){
            
            $(".graywrap").fadeIn(200);
            $(".rightNav").stop().animate({
                right : "0"
            },400);
        });
        $(".graywrap").click(function(){
            $(".rightNav").stop().animate({
                right : "-200px"
            },400);
            $(this).fadeOut(400);
        })
        
        var navHeight = jQuery(".wrap").height();
        jQuery(".rightNav").height(navHeight);
        jQuery(".graywrap").height(navHeight);
        
        
        // 검색 날짜에 따른 width 값
        var thLength = jQuery(".scroll_wrap table thead tr th").length;
        var l = 80 * thLength;
        jQuery(".scroll_wrap").css("width", l + "px"); 
        /* if(thLengh == '15'){
            jQuery(".scroll_wrap").css("width","1000px");            
        }
        if(thLengh == '7'){
            jQuery(".scroll_wrap").css("width","500px");             
        }
        if(thLengh == '3'){
            jQuery(".scroll_wrap").css("width","250px");             
        } */
        
        $("#selectFarmNo1").change(function() {
           var val = $(this).val();
           
           $("span.henNumber").hide();
           $("span#hen" + val).show();
        });
        
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
            var tdHtml = "";
            <c:forEach var="data" items="${dataList}" varStatus="vs2">
                line[${vs2.index}] = "${data.prodRatio}";
                label[${vs2.index}] = "${data.prodRatio}%(${data.qntty})";
                
                tdHtml = tdHtml + "<td><p>${data.prodRatio}%</p>(${data.qntty})</td>";
                
            </c:forEach>
            
            plot1 = $.jqplot('chart${vs1.count}', [line], {
                seriesDefaults: { 
                    showMarker:true,
                    pointLabels: {
                        show:false,
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
            
            $("#chart${vs1.count}").parent().parent().next().html(tdHtml);
        </c:forEach>
        
        <c:if test="${not empty waterList}">
            var line2 = new Array();
            var label2 = new Array();
            <c:forEach var="w" items="${waterList}" varStatus="vs">
                <fmt:formatDate var="hr" value="${water.regDtm}" pattern="HH"/>
                <c:if test="${hr >= 0 && hr < 12}">
                    line2[${vs.index}] = "${w.waterQntty}";
                    label2[${vs.index}] = "${w.waterQntty}";
                </c:if>
            </c:forEach>
        
            var plot2 = $.jqplot('waterChart1', [line2], {
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
            
            line2 = new Array();
            label2 = new Array();
            <c:forEach var="w" items="${waterList}" varStatus="vs">
                <fmt:formatDate var="hr" value="${water.regDtm}" pattern="HH"/>
                <c:if test="${hr >= 12 && hr < 24}">
                    line2[${vs.index}] = "${w.waterQntty}";
                    label2[${vs.index}] = "${w.waterQntty}";
                </c:if>
            </c:forEach>
        
            var plot2 = $.jqplot('waterChart2', [line2], {
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
            $("#spanSearchBinTxt").html("자료 조회")
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
            $("#spanSearchWaterTxt").html("자료 조회")
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

<body class="wrapper">
    <div class="wrap">
        <header role="banner">
            
            <!-- S: GNB -->
            <div class="header">
                <h1 class="logo"><a href="/frt/eggStatus.do"><img src="/images_m/logo.gif" alt="Egg-board" /></a></h1>
                
                <span class="mypage_btn _rightMenu" ><a href="javascript://" class="btn-mypage"><img src="/images_m/btn_mywrap.gif" alt="myEgg-board" /></a></span>
            </div>
            <!-- E: GNB -->
    
        </header>
    
        <!-- S: contents -->
        <article>
            <div class="contents main_contents clearfix">
                <!-- S: link_state -->
                <div class="link_state">
                    <div class="data">
                        <div class="communication">
                            <span>통신</span>
                            <c:if test="${empty farm.connectionStatus}">
                                <span>
                                    <img src="/images_m/img_con_off.png" style="height: 25px;width: 50px;"/>
                                </span>
                            </c:if>
                            <c:if test="${farm.connectionStatus == '0'}">
                                <span class="gradient02">에러</span>
                            </c:if>
                            <c:if test="${farm.connectionStatus == '1'}">
                                <span class="gradient01">정상</span>
                            </c:if>
                            
                        </div>
                        <div class="equipment">
                            <span>장비연결</span>
                            <c:if test="${empty farm.status}">
                                <span>
                                    <img src="/images_m/img_con_off.png" style="height: 25px;width: 50px;"/>
                                </span>
                            </c:if>
                            <c:if test="${farm.status == '0'}">
                                <span class="gradient02">에러</span>
                            </c:if>
                            <c:if test="${farm.status == '1'}">
                                <span class="gradient01">정상</span>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="now_state">
                        <div class="state">
                            <span>현재 상태</span>
                            <c:if test="${empty errorCode }">
                                <span class="gradient01">정상 동작중</span>
                            </c:if>
                            <c:if test="${not empty errorCode }">
                                <span class="gradient03">${errorCode }</span>
                            </c:if>
                        </div>
                        <span class="time">
                            <fmt:formatDate value="${today}" pattern="HH시 mm분"/>
                            <i onclick="document.location.reload();"></i>
                        </span>
                    </div>
                </div>
                <!-- E: link_state -->
                
                <!-- S: contents_detail -->
                <div class="contents_detail_wrap">
                    <div class="contents_detail">
                        <div class="graph_box clearfix">
                            <!-- S: 계군계사총수 -->
                            <div class="con_top henhouseNo">
                                <span>계사 총수</span>
                                <span class="count">
                                    ${fn:length(henList)}
                                </span>
                            </div>
                            <!-- E: 계군계사총수 -->
                            
                            <!-- S: 계군개체총수 -->
                            <div class="con_top henNo">
                                <span>개체 총수</span>
                                <c:forEach var="hen" items="${henList}">
                                    <c:set var="henTotalCount" value="${henTotalCount + hen.henCount}"/>
                                </c:forEach>
                                <span class="count">
                                    <fmt:formatNumber value="${henTotalCount}" pattern="#,###"/>
                                </span>
                            </div>
                            <!-- E: 계군개체총수 -->
                            <div class="select">
                                <select id="selectFarmNo1">
                                    <c:forEach var="hen" items="${henList}">
                                        <option value="${hen.farmNo }">${hen.farmNo }</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!-- S: 계사별개체정보 -->
                            <div class="con_top henhouse_graph">
                                <span>계사별 개체 정보</span>
                                <c:forEach var="hen" items="${henList}" varStatus="vs">
                                    <span class="count henNumber" id="hen${hen.farmNo }" <c:if test="${!vs.first}">style="display: none;"</c:if>>
                                        <fmt:formatNumber value="${hen.henCount}" pattern="#,###"/>마리
                                        <em>
                                            <fmt:parseDate var="entDt"  value="${hen.entDt }" pattern="yyyyMMdd"/>
                                            (<fmt:formatDate value="${entDt }" pattern="yy.MM.dd"/>)
                                        </em>
                                    </span>
                                </c:forEach>
                                <!-- <span class="count">50,000마리<em>(17.01.01)</em></span> -->
                            </div>
                            <!-- E: 계사별개체정보 -->
                        </div>
                        
                        <div class="tab_wrap">
                        
                            <!-- S: tab manu -->
                            <ul class="tab">
                                <li><a href="/frt/eggStatus.do?farmNo=1" class="tab_list01 active"><img src="/images_m/icon_tab_list01_on.png" alt="선별현황" />선별현황</a></li>
                                <li><a href="/frt/eggStatistics.do?farmNo=1" class="tab_list02"><img src="/images_m/icon_tab_list02_off.png" alt="선별통계" />선별통계</a></li>
                                <li><a href="/frt/farmStatus.do?farmNo=1" class="tab_list03"><img src="/images_m/icon_tab_list03_off.png" alt="시설현황" />시설현황</a></li>
                                <!-- <li><a href="" class="tab_list04"><img src="/images_m/icon_tab_list04_off.png" alt="산란통계" />산란통계</a></li> -->
                            </ul>
                            <!-- E: tab manu -->
                            
                            <!-- S: tab_con01 -->
                            <div class="tab_con tab_con01">
                                <div class="select_table">
                                    <ul>
                                        <li>
                                            <span>현재 작업 계사</span>
                                            <select id="selectFarmStatus">
                                            <c:forEach var="hen" items="${henList}">
                                                <option value="${hen.farmNo}" <c:if test="${param.farmNo == hen.farmNo}">selected="selected"</c:if>>
                                                    계사 #${hen.farmNo}
                                                </option>
                                            </c:forEach>
                                        </select> 
                                        </li>
                                        <li>
                                            <span>산란 계수</span>
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
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty eggList }">
                                                <tr>
                                                    <th></th>
                                                    <td colspan="3">조회 데이터가 없습니다.</td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="egg" items="${eggList}">
                                                <tr>
                                                    <th>${egg.gradeName}</th>
                                                    <td></td>
                                                    <td>${egg.prodRatio}</td>
                                                </tr>
                                            </c:forEach>
                                            <!-- <tr>
                                                <th>왕란</th>
                                                <td>999</td>
                                                <td>999</td>
                                                
                                            </tr> -->
                                            <tr>
                                                <th colspan="3" class="sum">생산항목 합계</th>
                                                
                                            </tr>
                                        </tbody>
                                        
                                    </table>
                                    <div class="con01_scroll">
                                    <div class="con01_scroll_wrap">
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th>생산수량</th>
                                                        <th>생산판수</th>
                                                        <th>생산중량</th>
                                                        <th>평균중량</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${empty eggList }">
                                                        <tr>
                                                            <td colspan="4">-</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="egg" items="${eggList}">
                                                        <tr>
                                                            <td>${egg.qntty}</td>
                                                            <td>${egg.box}</td>
                                                            <td>${egg.totalWeight}</td>
                                                            <td>${egg.avrgWeight}</td>
                                                        </tr>
                                                    </c:forEach>
                                                    
                                                    <c:forEach var="egg" items="${eggList}">
                                                        <c:set var="totalQntty" value="${totalQntty + egg.qntty}"/>
                                                        <c:set var="totalBox" value="${totalBox + egg.box}"/>
                                                    </c:forEach>
                                                    
                                                    <tr>
                                                        <c:if test="${empty eggList }">
                                                            <td colspan="4">-</td>
                                                        </c:if>
                                                        <c:if test="${not empty eggList }">
                                                            <td>${totalQntty}</td>
                                                            <td>${totalBox}</td>
                                                            <td></td>
                                                            <td></td>
                                                        </c:if>
                                                    </tr>
                                                    
                                                </tbody>
                                            </table>
                                    </div>
                                    <span class="right_arrow"></span>
                                    </div>
                                    
                                </div>
                                <span class="eggtec"><img src="/images_m/img_eggtec.gif" alt="eggtec" /></span>
                            </div>
                            <!-- E: tab_con01 -->
                            
                            <!-- S: tab_con02 -->
                            <div class="tab_con tab_con02">
                                <div class="select_table">
                                    <ul>
                                        <li>
                                            <span>계사 선택</span>
                                            <select id="selectFarmStatistics">
                                                <c:forEach var="hen" items="${henList}">
                                                    <option value="${hen.farmNo}" <c:if test="${param.farmNo == hen.farmNo}">selected="selected"</c:if>>
                                                        계사 #${hen.farmNo}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </li>
                                        <li>
                                            <span>기간 조회</span>
                                            <select id="selectSearchDate">
                                                <option value="3">최근3일</option>
                                                <option value="7">최근7일</option>
                                                <option value="15">최근15일</option>
                                                <option value="30">최근30일</option>
                                            </select>
                                            
                                            
                                        </li>
                                        <li>
                                            <span>시작일</span>
                                            <a href="javascript://" class="date">
                                                <span class="ymd">
                                                    <fmt:parseDate var="fromDate1" value="${fromDate}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="fromDate2" value="${fromDate1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="fromDate" value="${fromDate2}" id="fromDate" style="margin-left: -5px;height: 33px;margin-bottom: 4px;border: 0;width: 100px;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <span>종료일</span>
                                            <a href="javascript://" class="date">
                                                <span class="ymd">
                                                    <fmt:parseDate var="toDate1" value="${toDate}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="toDate2" value="${toDate1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="toDate" value="${toDate2}" id="toDate" style="margin-left: -5px;height: 33px;margin-bottom: 4px;border: 0;width: 100px;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender"></span>
                                            </a>
                                        </li>
                                    </ul>
                                    <div class="btn_big">
                                        <a href="javascript://" onclick="search1();">검&nbsp;&nbsp;색</a>
                                    </div>
                                </div>
                                
                                <c:if test="${empty list}">
                                    <div class="table_graph" style="height:auto;">
                                        <ul class="graph_grade">
                                            <li>등급</li>
                                            <li></li>
                                        </ul>
                                        <div class="graph_scroll">
                                            <div class="scroll_wrap">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th></th>
                                                            <th colspan="3">
                                                                날짜를 선택해 주세요.
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td></td>
                                                            <td colspan="3">
                                                                <div class="chart" id="chart1" style="height:80px;">
                                                                    <c:if test="${empty list}">
                                                                        <br/>
                                                                        데이터가 없습니다.
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                        <tr class="ran ran01">
                                                            <td colspan="5"><p>-</p>-</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty list}">
                                    <div class="table_graph" style="height:auto;">
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
                                                                        <fmt:formatDate value="${workDate}" pattern="MM-dd"/>
                                                                    </th>
                                                                </c:forEach>
                                                                <c:set var="thLength" value="${fn:length(list[0])}"/>
                                                            </c:if>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- <tr>
                                                            <td colspan="30">
                                                                <div class="chart"></div>
                                                            </td>
                                                        </tr> -->
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart1" style="height:80px;">
                                                                    <c:if test="${empty list}">
                                                                        <br/>
                                                                        데이터가 없습니다.
                                                                    </c:if>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart2" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran02">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart3" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran03">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart4" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart5" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart6" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart7" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart8" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="${thLength}">
                                                                <div class="chart" id="chart9" style="height:80px;"></div>
                                                            </td>
                                                        </tr> 
                                                        <tr class="ran ran01">
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                            <td><p>-</p>-</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <c:if test="${thLength > 4}">
                                            <span class="right_arrow"></span>
                                        </c:if>
                                    </div>
                                </c:if>
                                <span class="eggtec"><img src="/images_m/img_eggtec.gif" alt="eggtec" /></span>
                            </div>
                            <!-- E: tab_con02 -->
                            
                            <!-- S: tab_con03 -->
                            <div class="tab_con tab_con03">
                                <div class="select_table">
                                    <ul>
                                        <!-- <li>
                                            <span>계사 현황</span>
                                            <select>
                                                <option>전체</option>
                                            </select>
                                            
                                        </li> -->
                                        <li>
                                            <div class="select_right">
                                                <span>기간 조회</span>
                                                <select id="selectSearchDate1">
                                                    <option value="3">최근3일</option>
                                                    <option value="7">최근7일</option>
                                                    <option value="15">최근15일</option>
                                                    <option value="30">최근30일</option>
                                                </select> 
                                                
                                            </div>
                                        </li>
                                        <li>
                                            <span>시작일</span>
                                            <a href="javascript://" class="date">
                                                <span class="ymd">
                                                    <fmt:parseDate var="fromDateFarm1" value="${fromDateFarm}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="fromDateFarm2" value="${fromDateFarm1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="fromDateFarm" value="${fromDateFarm2}" id="fromDateFarm" style="margin-left: -5px;height: 33px;margin-bottom: 4px;border: 0;width: 100px;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender"></span>
                                            </a>
                                        </li>
                                        <li>
                                            <span>종료일</span>
                                            <a href="javascript://" class="date">
                                                <span class="ymd">
                                                    <fmt:parseDate var="toDateFarm1" value="${toDateFarm}" pattern="yyyyMMdd"/>
                                                    <fmt:formatDate var="toDateFarm2" value="${toDateFarm1}" pattern="yyyy-MM-dd"/>
                                                    <input type="text" name="toDateFarm" value="${toDateFarm2}" id="toDateFarm" style="margin-left: -5px;height: 33px;margin-bottom: 4px;border: 0;width: 100px;" readonly="readonly"/>
                                                </span>
                                                <span class="icon_calender"></span>
                                            </a>
                                        </li>
                                    </ul>
                                    <!-- <div class="btn_big"><a href="#">검&nbsp;&nbsp;색</a></div> -->
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
                                                            <img src="/images_m/img_bin_1_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                        <li>
                                                            <img src="/images_m/img_bin_2_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                        <li>
                                                            <img src="/images_m/img_bin_3_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                        <li>
                                                            <img src="/images_m/img_bin_4_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                        <li>
                                                            <img src="/images_m/img_bin_5_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                        <li>
                                                            <img src="/images_m/img_bin_6_off.gif" alt="images" />
                                                            <span class="left"><em>0</em>kg</span>
                                                        </li>
                                                    </c:if>
                                                    <c:forEach var="bin" items="${binList}">
                                                        <li>
                                                            <c:if test="${bin.currentWeight != -1 }">
                                                                <c:set var="on_off" value="on" />
                                                            </c:if>
                                                            <c:if test="${bin.currentWeight == -1 }">
                                                                <c:set var="on_off" value="off" />
                                                            </c:if>
                                                            <img src="/images_m/img_bin_${bin.binNo }_${on_off }.jpg" alt="images" />
                                                            <span class="left">
                                                                <em>${bin.currentWeight}</em>&nbsp;kg
                                                            </span>
                                                        </li>
                                                    </c:forEach>
                                                    <!-- <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>4,205</em>&nbsp;kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>5</em>&nbsp;kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>5</em>&nbsp;kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>5</em>&nbsp;kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>5</em>&nbsp;kg</span>
                                                    </li>
                                                    <li>
                                                        <img src="/images_m/img_kg.gif" alt="images" />
                                                        <span class="left"><em>5</em>&nbsp;kg</span>
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
                                            </div>
                                            <!-- E: 조회후 -->
                                            <div class="btn_big">
                                                <a href="javascript://" id="spanSearchBinTxt" onclick="searchBin();">
                                                    자료 조회
                                                </a>
                                            </div>
                                        </li>
                                        <li>
                                            <span class="title"><span class="title_txt">급수<br>시설</span></span>
                                            <!-- S: 조회전 -->
                                            <div class="data before" id="beforeSearchWater">
                                                <table>
                                                    <c:if test="${empty waterList}">
                                                        <tr>
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
                                                        </tr>
                                                        <tr>
                                                            <td colspan="12">
                                                                <div style="height: 150px;">
                                                                    <br/>
                                                                    데이터가 없습니다.
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
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
                                                        </tr>
                                                        <tr>
                                                            <td colspan="12">
                                                                <div style="height: 150px;">
                                                                    <br/>
                                                                    데이터가 없습니다.
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach var="water" items="${waterList}" varStatus="vs1">
                                                        <fmt:formatDate var="hr" value="${water.regDtm}" pattern="HH"/>
                                                        <c:if test="${hr >= 0 && hr < 12}">
                                                            <tr>
                                                                <td>
                                                                    ${hr }
                                                                </td>
                                                            </tr>
                                                            <c:set var="vsCnt1" value="${vs1 + 1 }"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <!-- <tr>
                                                        <td>1</td>
                                                        <td>2</td>
                                                        <td>3</td>
                                                        <td>4</td>
                                                        <td>5</td>
                                                        <td>6</td>
                                                        <td>7</td>
                                                        <td>8</td>
                                                        <td>9</td>
                                                        <td>10</td>
                                                        <td>11</td>
                                                        <td>12</td>
                                                        <td>13</td>
                                                        <td>14</td>
                                                        <td>16</td>
                                                    </tr> -->
                                                    <c:if test="${not empty waterList }">
                                                        <tr class="graph_td">
                                                            <td colspan="${vsCnt1 }">
                                                                <div id="waterChart1" style="height: 150px;"></div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                    
                                                    <!-- <tr>
                                                        <td>1</td>
                                                        <td>2</td>
                                                        <td>3</td>
                                                        <td>4</td>
                                                        <td>5</td>
                                                        <td>6</td>
                                                        <td>7</td>
                                                        <td>8</td>
                                                        <td>9</td>
                                                        <td>10</td>
                                                        <td>11</td>
                                                        <td>12</td>
                                                        <td>13</td>
                                                        <td>14</td>
                                                        <td>16</td>
                                                    </tr>
                                                    <tr class="graph_td">
                                                        <tr class="graph_td">
                                                            <td colspan="16">1</td>
                                                        </tr>
                                                    </tr> -->
                                                    <c:forEach var="water" items="${waterList}" varStatus="vs2">
                                                        <fmt:formatDate var="hr" value="${water.regDtm}" pattern="HH"/>
                                                        <c:if test="${hr >= 12 && hr < 24}">
                                                            <tr>
                                                                <td>
                                                                    ${hr }
                                                                </td>
                                                            </tr>
                                                            <c:set var="vsCnt2" value="${vs2 + 1 }"/>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${not empty waterList }">
                                                        <tr class="graph_td">
                                                            <td colspan="${vsCnt2}">
                                                                <div id="waterChart2" style="height: 150px;"></div>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </table>
                                            </div>
                                            <!-- E: 조회전 -->
                                            
                                            <!-- S: 조회후 -->
                                            <div class="data after" id="afterSearchWater" style="display: none;">
                                                <div class="thead clearfix">
                                                    <ul>
                                                        <li>날짜</li>
                                                        <li>잔류량</li>
                                                        <!-- <li>추가량</li>
                                                        <li>사용량</li> -->
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
                                            <!--  E: 조회후 -->
                                            <div class="btn_big">
                                                <a href="javascript://" onclick="searchWater();" id="spanSearchWaterTxt">
                                                    자료 조회
                                                </a>
                                            </div>
                                        </li>
                                    </ul>
                                    
                                    <!-- S: last -->
                                    <ul class="last">
                                        <li>
                                            <span class="title"><span class="title_txt">계사<br>시설</span></span>
                                            <div class="facility_info">
                                                <span class="img"><img src="/images_m/img_facility.gif" alt="imags" /></span>
                                                <table class="temp" style="width: 50%;float: left;">
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
                                                <table class="temp" style="width: 50%;float: right;">
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
                                                <table class="fan">
                                                    <tbody>
                                                        <c:if test="${empty fanList }">
                                                            <tr>
                                                                <td>FAN-1 OFF</td>
                                                                <td>FAN-2 OFF</td>
                                                                <td>FAN-3 OFF</td>
                                                                <td>FAN-4 OFF</td>
                                                            </tr>
                                                            <tr>
                                                                <td>FAN-5 OFF</td>
                                                                <td>FAN-6 OFF</td>
                                                                <td>FAN-7 OFF</td>
                                                                <td>FAN-8 OFF</td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${not empty fanList }">
                                                            <tr>
                                                                <c:forEach var="fan" items="${fanList}" varStatus="fVs">
                                                                    <c:if test="${fVs.index >= 0 && fVs.index < 4}">
                                                                        <c:if test="${fan.status == '2' }">
                                                                            <td>FAN-${fan.fanNo} ERR</td>
                                                                        </c:if>
                                                                        <c:if test="${fan.status == '1' }">
                                                                            <td class="on">FAN-${fan.fanNo} ON</td>
                                                                        </c:if>
                                                                        <c:if test="${fan.status == '0' }">
                                                                            <td>FAN-${fan.fanNo} OFF</td>
                                                                        </c:if>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </tr>
                                                            <tr>
                                                                <c:forEach var="fan" items="${fanList}" varStatus="fVs">
                                                                    <c:if test="${fVs.index >= 4}">
                                                                        <c:if test="${fan.status == '2' }">
                                                                            <td>FAN-${fan.fanNo} ERR</td>
                                                                        </c:if>
                                                                        <c:if test="${fan.status == '1' }">
                                                                            <td class="on">FAN-${fan.fanNo} ON</td>
                                                                        </c:if>
                                                                        <c:if test="${fan.status == '0' }">
                                                                            <td>FAN-${fan.fanNo} OFF</td>
                                                                        </c:if>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </tr>
                                                        </c:if>
                                                        
                                                        <!-- <tr>
                                                            <td class="on">FAN-1 ON</td>
                                                            <td>FAN-1 OFF</td>
                                                            <td>FAN-1 OFF</td>
                                                            <td>FAN-1 OFF</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="on">FAN-1 ON</td>
                                                            <td class="on">FAN-1 ON</td>
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
                                <span class="eggtec"><img src="/images_m/img_eggtec.gif" alt="eggtec" /></span>
                            </div>
                            <!-- E: tab_con03 -->
                            
                            <!--<div class="tab_con tab_con04"></div>
                            -->
                            
                        </div>
                        
                    </div>
                </div>
                <!-- E: contents_detail -->
                <p class="neonics"><img src="/images_m/img_neonics.gif" width="100%" height="auto" alt="Solution by NEONICS"></p>
            </div>
            
        </article>
        <!-- E: contents -->
    
    
                
    
        <!-- Footer -->
        <footer>
            <!-- S: Site Info -->
            <div class="siteInfo pa">
                <ul>
                    <li><a href="http://eggtec.com/%ED%9A%8C%EC%82%AC%EA%B0%9C%EC%9A%94/" target="blank">회사소개</a></li>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">개인정보취급방침</a></li>
                    <li><a href="http://eggtec.com/%EC%A0%9C%ED%92%88%EB%AC%B8%EC%9D%98/" target="blank">문의게시판</a></li>
                </ul>
            </div>
            <!-- E: Site Info -->
            <p class="copyright" role="contentinfo"><small>&copy; EGG-Board.com. All Rights Reserved.</small></p>
        </footer>
        <!-- Footer -->
    </div>
    
    
    
    <div class="rightNav">
        <div class="link_state">
            <div class="today">
                <p>
                    <fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>
                </p>
                <p>
                    <fmt:formatDate value="${today}" pattern="E"/>요일
                </p>
            </div>
            <div class="login_info">
                <p>
                    <c:if test="${empty user.photoInfo}">
                        <img src="/images_m/farm_default.jpg" width="100%" height="auto" alt="농장이름" />
                    </c:if>
                    <c:if test="${not empty user.photoInfo}">
                        <img src="${user.photoInfo }" width="100%" height="auto" alt="농장이름" />
                    </c:if>
                </p>
                <p>${user.farmName}</p>
                <p><a href="/logout.do">로그아웃</a></p>
                <p><a href="/frt/mypageView.do">정보수정</a></p>
            </div>
        </div>
        
        <div class="quickMenu">
            <span class="tabla_title">Quick Menu</span>
            <table>
                <colgroup>
                    <col width="50%">
                    <col width="50%">
                </colgroup>
                <tbody>
                    <tr>
                        <td class="tab01">
                            <a href="/frt/eggStatus.do?farmNo=1">
                                <span class="td_title"><em></em>선별<br/>현황</span>
                            </a>
                        </td>
                        <td class="tab02">
                            <a href="/frt/eggStatistics.do?farmNo=1">
                                <span class="td_title"><em></em>선별<br/>통계</span>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="tab03">
                            <a href="/frt/farmStatus.do?farmNo=1">
                                <span class="td_title"><em></em>시설<br/>현황</span>
                            </a>
                        </td>
                        <td class="tab04">
                            <!-- <a href="#">
                                <span class="td_title"><em></em>선별<br/>현황</span>
                            </a> -->
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="graywrap"></div>
        
</body>
</html>