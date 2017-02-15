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
                                            <th>전송일시</th>
                                            <th>급수량</th>
                                            <!-- <th>에러메시지</th> -->
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty farmWorkList }">
                                            <tr>
                                                <td colspan="3">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="work" items="${farmWorkList}" varStatus="vs">
                                            <tr>
                                                <th>${vs.count }</th>
                                                <td>
                                                    <a href="/adm/farmDetail.do?serialNo=${work.serialNo }&workSeq=${work.workSeq}">
                                                        <fmt:formatDate value="${work.regDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </a>
                                                </td>
                                                <td>
                                                    ${work.waterQntty}
                                                </td>
                                                <%-- <td>
                                                    ${work.errorCode}
                                                </td> --%>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    
                                </table>
                            </div>
                            
                        </div>
                        <!-- E: tab_con01 -->
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