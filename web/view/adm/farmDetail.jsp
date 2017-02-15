<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
    jQuery(document).ready(function(){
        //tab menu
        jQuery(".tab_con").hide();
        jQuery(".tab_con01").show();
        
        jQuery(".tab li a").click(function(){
            
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
        });
        
        $("#selectFarm").on("change", function() {
            var serialNo = $(this).val();
            //if (!isEmpty(serialNo)) {
                document.location.href="/adm/farmStatus.do?serialNo=" + serialNo;
            //}
        });
    });
    
    function confirmSerialNo(userId) {
        var serialNo = $("tr#" + userId).find("input[name='serialNo']").val();
        
        if (!isEmpty(serialNo)) {
            $.ajax({
                url: "/adm/confirmSerialNo.do",
                data: {userId : userId, serialNo : serialNo},
                success: function (data) {
                    alert("승인했습니다.");
                    document.location.reload();
                },
                error: function() {
                    alert("승인실패.");
                }
            });
        }
    }
    
    function reConfirmSerialNo(userId) {
        confirmSerialNo(userId);
    }
    </script>
</head>
<body>
<div class="wrapper">
    <!-- S: header -->
    <header role="banner">
        
        <div class="header">
            <h1 class="logo"><a href="/main.do"><img src="/images/logo.gif" alt="EGG-Board" /></a></h1>
            <a class="btn-mypage"><img src="/images/sub_logo.gif" alt="eggtec" /></a>
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
                    </p>
                    <p>
                        <fmt:formatDate value="${today}" pattern="E"/>요일
                    </p>
                </div>
                <div class="login_info">
                    <p>
                        <!-- <img src="/images/img_farm.gif" width="100%" height="auto" alt="농장이름" /> -->
                        <img src="/images/farm_default.jpg" width="100%" height="auto" alt="농장이름" />
                        <span style="position: static;">${admin.userName }</span>
                    </p>
                    <p><a href="/logout.do">로그아웃</a></p>
                    <!-- <p><a href="javascript://">정보수정</a></p> -->
                </div>
                <div class="data" style="padding-top: 50px;">
                    <ul>
                        <li>
                            <a href="/adm/userStatus.do" style="color: white;">* 회원관리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        </li>
                        <li>
                            <a href="/adm/eggStatus.do" style="color: white;">* 선별현황데이터</a>
                        </li>
                        <li>
                            <a href="/adm/farmStatus.do" style="color: white;">* 시설현황데이터</a>
                        </li>
                    </ul>
                </div>
                <!-- <div class="data">
                    <div class="communication"><p>통신</p><p class="gradient01">정상</p></div>
                    <div class="equipment"><p>장비연결</p><p class="gradient02">정상</p></div>
                    
                </div>
                <div class="now_state">
                    <p><span>현재 상태</span></p>
                    <p class="time">오전 12시 30분<i></i></p>
                    <p class="gradient03">정상 동작중</p>
                </div> -->
                <p class="neonics"><img src="/images/img_neonics.gif" width="100%" height="auto" alt="Solution by NEONICS" /></p>
            </div>
            <!-- E: link_state -->
            
            <!-- S: contents_detail -->
            <div class="contents_detail_wrap">
                <div class="contents_detail">
                    <div class="graph_box clearfix">
                        
                    </div>
                    
                    <div class="tab_wrap">
                        <!-- S: tab_con01 -->
                        <div class="tab_con tab_con01">
                            <div class="select_table">
                                <!-- 회원목록 (회원수 : , 미승인 회원 :)
                                <br/><br/><br/> -->
                                <span>* 시설현황데이터</span>
                                <br/><br/><br/>
                                <span>농장선택</span>
                                <select name="selectFarm" id="selectFarm" style="width: 200px;">
                                    <option value="">선택</option>
                                    <c:forEach var="user" items="${userList }">
                                        <option value="${user.serialNo }" <c:if test="${not empty user.serialNo && user.serialNo == param.serialNo }">selected="selected"</c:if>>
                                            ${user.farmName}
                                        </option>
                                    </c:forEach>
                                </select> 
                            </div>
                            <br/><br/><br/><br/><br/><br/>
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>급이 잔류량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty binList }">
                                            <tr>
                                                <td colspan="4">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="bin" items="${binList}" varStatus="vs">
                                            <tr>
                                                <th>${bin.binNo }</th>
                                                <td>
                                                    ${bin.currentWeight }
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    
                                </table>
                            </div>
                            
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>온도</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty thermoList }">
                                            <tr>
                                                <td colspan="4">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="thermo" items="${thermoList}" varStatus="vs">
                                            <tr>
                                                <th>${thermo.thermometerNo }</th>
                                                <td>
                                                    ${thermo.degree }
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    
                                </table>
                            </div>
                            
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>조도</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty lightList }">
                                            <tr>
                                                <td colspan="4">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="light" items="${lightList}" varStatus="vs">
                                            <tr>
                                                <th>${light.lightNo }</th>
                                                <td>
                                                    ${light.lux }
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    
                                </table>
                            </div>
                            <div class="table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>FAN</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty fanList }">
                                            <tr>
                                                <td colspan="4">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="fan" items="${fanList}" varStatus="vs">
                                            <tr>
                                                <th>${fan.fanNo }</th>
                                                <td>
                                                    <c:if test="${fan.status == '2' }">
                                                        ERR
                                                    </c:if>
                                                    <c:if test="${fan.status == '1' }">
                                                        ON
                                                    </c:if>
                                                    <c:if test="${fan.status == '0' }">
                                                        OFF
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
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
                                    <select>
                                        <option>전체</option>
                                    </select>   
                                    </li>
                                    <li>
                                        <span><img src="/images/select_table_txt04.gif" alt="현재 작업 계사" /></span>
                                         <select>
                                            <option>선택</option>
                                        </select>
                                        
                                        <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>  ~        
                                               
                                        <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>                 
                                        <div class="btn medium"><a href="/">검색</a></div>
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
                                    <li>파란</li>
                                </ul>
                                <div class="graph_scroll">
                                    <div class="scroll_wrap">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                    <th>01월01일</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                </tr>
                                               <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>7</td>
                                                    <td>7</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
                                                    <td>2</td>
                                                    <td>3</td>
                                                    <td>4</td>
                                                    <td>5</td>
                                                    <td>6</td>
                                                    <td>7</td>
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
                                        <span><img src="/images/select_table_txt03.gif" alt="계사현황" /></span>
                                        <select>
                                            <option>전체</option>
                                        </select>   
                                    </li>
                                    <li>
                                        <div class="select_right">
                                            <span><img src="/images/select_table_txt04.gif" alt="기간조회" /></span>
                                            <select>
                                                <option>선택</option>
                                            </select>
                                            <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>  ~  
                                            <a href="#;" class="date"><span>2017.01.01</span><span class="icon_calender"></span></a>                 
                                            <div class="btn medium"><a href="/">검색</a></div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="facility">
                                <ul>
                                    <li>
                                        <span class="title"><span class="title_txt">급이<br>시설</span></span>
                                        <!-- S: 조회전 -->
                                        <div class="data before">
                                            <ul>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:&nbsp;<em>5</em>&nbsp;kg</span>
                                                </li>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:<em>5</em>kg</span>
                                                </li>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:<em>5</em>kg</span>
                                                </li>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:<em>5</em>kg</span>
                                                </li>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:<em>5</em>kg</span>
                                                </li>
                                                <li>
                                                    <img src="/images/img_kg.gif" alt="images" />
                                                    <span class="left">잔량:<em>5</em>kg</span>
                                                </li>
                                            </ul>
                                        </div>
                                        <!-- E: 조회전 -->
                                        
                                        <!-- S: 조회후
                                        <div class="data after">
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
                                         E: 조회후 -->
                                        <div class="btn_big"><a href=""><span class="btn_txt">자료<br/>조회</span></a></div>
                                    </li>
                                    <li>
                                        <span class="title"><span class="title_txt">급수<br>시설</span></span>
                                        <!-- S: 조회전 
                                        <div class="data before">
                                            <table>
                                                <tr>
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
                                            </table>
                                        </div>
                                        E: 조회전 -->
                                        
                                        <!-- S: 조회후 -->
                                        <div class="data after">
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
                                        <div class="btn_big"><a href=""><span class="btn_txt">초기화</span></a></div>
                                    </li>
                                </ul>
                                
                                <!-- S: last -->
                                <ul class="last">
                                    <li>
                                        <span class="title"><span class="title_txt">계사<br>시설</span></span>
                                        <div class="facility_info">
                                            <span class="img"><img src="/images/img_facility.gif" alt="imags" /></span>
                                            <table class="temp">
                                                <tbody>
                                                    <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr>
                                                    <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr>
                                                    <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr>
                                                    <tr>
                                                        <th>온도1</th>
                                                        <td>30°C</td>
                                                        <th>조도1</th>
                                                        <td>125lux</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="fan">
                                                <tbody>
                                                    <tr>
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
                                                    </tr>
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
                <li><a href="#">회사소개</a></li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보취급방침</a></li>
                <li><a href="#">이용안내</a></li>
                <li><a href="#">문의게시판</a></li>
                <!--<li><a href="https://www.twayair.com/main.do?frontYn=Y">PC버전</a></li>-->
            </ul>
        </div>
        <!-- E: Site Info -->
        <p class="copyright" role="contentinfo"><small>Copyright &copy; EGG-Board.com. All Rights Reserved.</small></p>
    </footer>
    <!-- Footer -->
</div>

</body>
</html>