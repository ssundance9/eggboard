<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="utf-8" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, intial-scale=1.0, target-densitydpi=device-dpi">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>EGG-Board 회원가입</title>
    <link type="text/css" rel="stylesheet" href="/css/global_m.css" />
    <link type="text/css" rel="stylesheet" href="/css/style_m.css" />
    <!-- Script -->
    <script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
    </script>
</head>
<body class="wrapper">
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
        <div class="contents">
        
            <!-- S: join -->
            <div class="join_wrap">
                <h2>회원가입</h2>
                <div class="step clearfix">
                    <ul>
                        <li class="step01"><i></i>약관동의</li>
                        <li class="step02"><i></i>필수정보</li>
                        <li class="step03 active"><i></i>가입완료</li>
                    </ul>
                </div>
                
                <div class="join_complete">
                    <div class="top">
                        <img src="/images_m/img_join_complete.gif" alt="image" />
                        <span><em>${user.userId}</em>님의<br/><em class="egg">EGG-Board</em> 회원가입을 감사드립니다!</span>
                    </div>
                    <table class="simpleInfo_table" summary="회원정보 요약 테이블">
                        <caption>회원정보 요약</caption>
                        <tbody>
                            <tr>
                                <th>이름</th>
                                <td>${user.userName}</td>
                                
                            </tr>
                            <tr>
                                <th>아이디</th>
                                <td>${user.userId}</td>
                            </tr>
                            <tr>
                                <th>휴대전화</th>
                                <td>${user.userMphone}</td>
                                
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>${user.userEmail}</td>
                            </tr>
                            <tr>
                                <th>가입일시</th>
                                <td><fmt:formatDate value="${user.regDtm}" pattern="yyyy-MM-dd HH:mm"/></td>
                                
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="btn_big join_complete"><a href="/user/loginView.do">확인</a></div>
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


</body>
</html>