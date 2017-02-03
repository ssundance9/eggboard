<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="KO">
<head>
    <meta charset="utf-8">
    <meta property="og:title" content="EGG-Board">
    <meta property="og:url" content="https://www.???.com/">
    <meta property="og:description" content="" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>EGG-Board 로그인</title>
    <link type="text/css" rel="stylesheet" href="/css/global.css" />    
    <link type="text/css" rel="stylesheet" href="/css/style_pc.css" />
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
    jQuery(document).ready(function(){
        
        //tab menu
        jQuery(".tab_con").hide();
        jQuery(".tab_con01").show();
        
        jQuery(".tab li a").click(function(){

            jQuery(".tab li a").removeClass("active");
            jQuery(this).addClass("active");
            
            var idx = jQuery(this).index(".tab li a");      
            jQuery(".tab_con").hide();
            jQuery(".tab_con0"+(idx+1)).show();
            
            return false; 
        });
        
        //아이디 비번 찾기
        jQuery(".btn_find").click(function(){
            jQuery(".gray_wrap").show();    
        });
        jQuery(".btn_close").click(function(){
            jQuery(".gray_wrap").hide();    
        });
        
        <c:if test="${not empty errorMsg}">
            alert("${errorMsg}");
        </c:if>
        
    });
    
    function login() {
        $("form[name='loginForm']").submit();
    }
    </script>
</head>
<body>

<div class="wrapper">
    <!-- S: header -->
    <header role="banner">
        
        <div class="header">
            <h1 class="logo"><a href="/frt/eggStatus.do"><img src="/images/logo.gif" alt="EGG-Board" /></a></h1>
            <a class="btn_mypage">eggtec</a>
        </div>
        
    </header>
    <!-- E: header -->

    <!-- S: contents -->
    <article>
        <div class="contents main_contents">
            <div class="login_top">
                <img src="/images/login_top.gif" alt="login_top" />
            </div>
            <div class="login_form">
                <form name="loginForm" method="post" action="/user/login.do">
                    <fieldset>
                        <legend>회원 로그인</legend>
                        <label for="user_id"><img src="/images/login_id.gif" alt="아이디" /></label>
                        <input type="text" id="user_id" name="userId" maxlength="12"/>
                        <label for="user_pw"><img src="/images/login_pw.gif" alt="비밀번호"/></label>
                        <input type="password" id="user_pw" name="userPw" maxlength="12"/>
                    </fieldset>
                </form>
                <div class="btn_login">
                    <a href="javascript://" onclick="login();">
                        <img src="/images/btn_login.gif" alt="로그인" />
                    </a>
                </div>
                <ul class="member_btns clearfix">
                    <li><a href="/user/createUserView1.do"><img src="/images/btn_join.gif" alt="회원가입" /></a></li>
                    <li><a href="javascript://" class="btn_find"><img src="/images/btn_findIDPW.gif" alt="ID/PW찾기" /></a></li>
                </ul>
            </div>
        </div>

    </article>
    <!-- E: contents -->

            

    <!-- Footer -->
    <footer>
        <!-- S: Site Info -->
        <div class="siteInfo clearfix">
            <ul>
                <li><a href="http://eggtec.com/%ED%9A%8C%EC%82%AC%EA%B0%9C%EC%9A%94/">회사소개</a></li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보취급방침</a></li>
                <li><a href="http://eggtec.com/%EC%A0%9C%ED%92%88%EB%AC%B8%EC%9D%98/">문의게시판</a></li>
                <!--<li><a href="https://www.twayair.com/main.do?frontYn=Y">PC버전</a></li>-->
            </ul>
        </div>
        <!-- E: Site Info -->
        <p class="copyright" role="contentinfo"><small>Copyright &copy; EGG-Board.com. All Rights Reserved.</small></p>
    </footer>
    <!-- Footer -->




    <!-- S: gray layer -->
    <div class="gray_wrap">
        <div class="gray"></div>
        
        <div class="overlayer">
        
            <!-- S: id/pw 찾기 -->
            <div class="find_IDPW">
                <div class="head">
                    <span class="title"><img src="/images/title_find_idpw.gif" alt="ID/PW 찾기" /></span>
                    <span>
                        <a href="javascript:void(0);" class="btn_close"><img src="/images/btn_close.gif" alt="닫기"></a>
                    </span>
                </div>
                <div class="body">
                    <ul class="tab">
                        <li><a href="#" class="active">아이디 찾기</a></li>
                        <li><a href="#">비밀번호 찾기</a></li>
                    </ul>
        
                    <div class="tab_con tab_con01">
                        <ul class="info_table">
                            
                            <li>
                                <span class="th">이름</span>
                                <div>
                                    <input type="text" id="mbName" class="" name="mbName" placeholder="" >
                                </div>
                            </li>
                            <li>
                                <span class="th">휴대전화</span>
                                <div class="phone_area">
                                    <input type="tel" id="phoneNo" class="" name="phoneNo" maxlength="" placeholder="'-'제외하고 숫자만 입력" >             
                                </div>
                            </li>
                        </ul>
                        <span class="btn_big check"><a href="/"><img src="/images/btn_join_complete.gif" alt="확인" /></a></span>
                    </div>
                   
                    
                    <div class="tab_con tab_con02">
                        <ul class="info_table">
                            <li>
                                <span class="th">아이디</span>
                                <div>
                                    <input type="text" id="mbId" class="" name="mbId" placeholder="영문 또는 숫자 4~10자" maxlength="10">
                                </div>
                            </li>
                            <li>
                                <span class="th">이름</span>
                                <div>
                                    <input type="text" id="mbName" class="" name="mbName" placeholder="" >
                                </div>
                            </li>
                            <li>
                                <span class="th">휴대전화</span>
                                <div class="phone_area">
                                    <input type="tel" id="phoneNo" class="" name="phoneNo" maxlength="" placeholder="'-'제외하고 숫자만 입력" >                                       
                                    <span class="btn small"><a href="/">인증</a></span>
                                    <input type="tel" id="confirmNo" class="" name="confirmNo" maxlength="" placeholder="인증번호를 입력하세요" >
                                </div>
                            </li>
                         </ul>
                         <span class="btn_big check"><a href="/"><img src="/images/btn_join_complete.gif" alt="확인" /></a></span>
                    </div>
                </div>
                
        
            </div>
            <!-- E: id/pw 찾기 -->
        
            
        </div>
    
    </div>
    <!-- E: gray layer -->
</div>

</body>
</html>