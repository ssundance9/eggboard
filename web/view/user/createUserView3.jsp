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
    <title>EGG-Board 회원가입</title>
    <link type="text/css" rel="stylesheet" href="/css/global.css" />    
    <link type="text/css" rel="stylesheet" href="/css/style_pc.css" />
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body>
<div class="wrapper">
    <!-- S: header -->
    <header role="banner">
        <div class="header">
            <h1 class="logo"><a href="/frt/eggStatus.do"><img src="/images/logo.gif" alt="EGG-Board" /></a></h1>
            <a class="btn-mypage" href="http://www.eggtec.com"><img src="/images/sub_logo.gif" alt="eggtec" /></a>
        </div>
    </header>
    <!-- E: header -->

    <!-- S: contents -->
    <article>
        <div class="contents">
        
            <!-- S: join -->
            <div class="join_wrap">
                <h2><img src="/images/join_title.gif" alt="회원가입" /></h2>
                <div class="step clearfix">
                    <ul>
                        <li class="step01"><img src="/images/join_step01_off.gif" alt="약관동의" /></li>
                        <li class="step02"><img src="/images/join_step02_off.gif" alt="필수정보" /></li>
                        <li class="step03 active"><img src="/images/join_step03_on.gif" alt="가입완요" /></li>
                    </ul>
                </div>
                
                <div class="join_complete">
                    <div class="top">
                        <img src="/images/img_join_complete.gif" alt="image" />
                        <span><em>${user.userId}</em><img src="/images/txt_join_complete.gif" alt="님의 EGG-Board 회원가입을 감사드립니다!" /></span>
                    </div>
                    <table class="simpleInfo_table" summary="회원정보 요약 테이블">
                        <caption>회원정보 요약</caption>
                        <tbody>
                            <tr>
                                <th>이름</th>
                                <td>${user.userName}</td>
                                <th>아이디</th>
                                <td>${user.userId}</td>
                            </tr>
                            <tr>
                                <th>휴대전화</th>
                                <td>${user.userMphone }</td>
                                <th>이메일</th>
                                <td>${user.userEmail}</td>
                            </tr>
                            <tr>
                                <th>가입일시</th>
                                <td><fmt:formatDate value="${user.regDtm}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <th></th>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="btn_big join_complete"><a href="/user/loginView.do"><img src="/images/btn_join_complete.gif" alt="확인" /></a></div>
            </div>
            <!-- E: join -->
        </div>

    </article>
    <!-- E: contents -->

            

    <!-- Footer -->
    <footer>
        <!-- S: Site Info -->
        <div class="siteInfo pa">
            <ul>
                <li>
                    <a href="http://eggtec.com/%ED%9A%8C%EC%82%AC%EA%B0%9C%EC%9A%94/" target="blank">회사소개</a>
                </li>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보취급방침</a></li>
                <li>
                    <a href="http://eggtec.com/%EC%A0%9C%ED%92%88%EB%AC%B8%EC%9D%98/" target="blank">문의게시판</a>
                </li>
            </ul>
        </div>
        <!-- E: Site Info -->
        <p class="copyright" role="contentinfo"><small>&copy; EGG-Board.com. All Rights Reserved.</small></p>
    </footer>
    <!-- Footer -->
</div>

</body>
</html>