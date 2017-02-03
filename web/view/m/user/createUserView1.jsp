<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="KO">
<head>
<meta charset="utf-8" />
    <!-- <meta http-equiv="Content-Language" content="kr" /> -->
    <!-- <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" /> -->
    <!-- <meta http-equiv="Content-Script-Type" content="text/javascript" /> -->

    <!-- <meta name="description" content="사이트 설명" />
    <meta name="keywords" content="사이트,키워드" /> -->

    <meta name="format-detection" content="telephone=no" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, intial-scale=1.0, target-densitydpi=device-dpi">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>EGG-Board 회원가입</title>
    
    <link type="text/css" rel="stylesheet" href="/css/global_m.css" />
    <link type="text/css" rel="stylesheet" href="/css/style_m.css" />
    
   
    <!-- Script -->
    <script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
    
    <script type="text/javascript">
     $(document).ready(function() {
        // all check
        $("#checkAll").change(function () {
            $(".amir:checkbox").prop('checked', $(this).prop("checked"));
        });
        
        $(".amir:checkbox").on("click", function() {
            if ($(".amir:checkbox:checked").length == 3) {
                $("#checkAll").prop("checked", true);
            } else {
                var i = 0;
                $(".amir:checkbox").each(function() {
                    if (!$(this).prop("checked")) {
                        i = i + 1;
                    } 
                 });
                
                if (i < 3) {
                    $("#checkAll").prop("checked", false);
                }
            }
        });
    });
     
     function goNextStep() {
         if (!$("input#check_style").prop("checked")) {
             alert("회원약관에 동의해 주세요.");
             $("input#check_style").focus();
             return;
         }
         
         if (!$("input#check_style1").prop("checked")) {
             alert("개인정보취급방침에 동의해 주세요.");
             $("input#check_style1").focus();
             return;
         }
         
         if (!$("input#check_style2").prop("checked")) {
             alert("개인정보 수집 및 이용에 동의해 주세요.");
             $("input#check_style2").focus();
             return;
         }
         
         $("form[name='agreeForm']").find("input[name='agreeYn']").val("Y");
         $("form[name='agreeForm']").submit();
     }
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
        <div class="content main_contents">
            <form name="agreeForm" method="post" action="/user/createUserView2.do">
                <input type="hidden" name="agreeYn" value=""/>
            </form>
            
            <!-- S: join -->
            <div class="join_wrap">
                <h2>회원가입</h2>
                <div class="step clearfix">
                    <ul>
                        <li class="step01 active"><i></i>약관동의</li>
                        <li class="step02"><i></i>필수정보</li>
                        <li class="step03"><i></i>가입완요</li>
                    </ul>
                </div>
                <div class="terms">
                    <div class="terms_agree">
                        <p class="title">회원약관</p>
                        <form method="post" action="">
                            <fieldset>
                                <legend>회원동의</legend>
                                <div class="check_style">
                                    <input type="checkbox" value="None" id="check_style" name="check_style" class="amir">
                                    <label for="check_style"><span>동의합니다</span></label>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    
                    <div class="terms_txt">
                        <ul>
                            <li><dl><dt>제1조(목적)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제2조(정의)</dt><dd>이 약관은....</dd></dl></li>
                        </ul>
                    </div>
                </div>
                <div class="terms">
                    <div class="terms_agree">
                        <p class="title">개인정보취급방침</p>
                        <form method="post" action="">
                            <fieldset>
                                <legend>개인정보취급방침</legend>
                                <div class="check_style">
                                    <input type="checkbox" value="None" id="check_style1" name="check_style1" class="amir">
                                    <label for="check_style1"><span>동의합니다</span></label>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <div class="terms_txt">
                        <ul>
                            <li><dl><dt>제1조(목적)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제2조(정의)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제1조(목적)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제2조(정의)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제1조(목적)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제2조(정의)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제1조(목적)</dt><dd>이 약관은....</dd></dl></li>
                            <li><dl><dt>제2조(정의)</dt><dd>이 약관은....</dd></dl></li>
                        </ul>
                    </div>
                </div>
                <div class="terms">
                    <div class="terms_agree">
                    <p class="title">개인정보 수집 및 이용</p>
                    <form method="post" action="">
                        <fieldset>
                            <legend>개인정보 수집 및 이용</legend>
                            <div class="check_style">
                                <input type="checkbox" value="None" id="check_style2" name="check_style2" class="amir">
                                <label for="check_style2"><span>동의합니다</span></label>
                            </div>
                        </fieldset>
                    </form>
                    </div>
                    <table summary="개인정보 수집 및 이용">
                        <caption>개인정보 수집 및 이용</caption>
                        <colgroup>
                            <col width="25%"/>
                            <col />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>목&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적</th>
                                <td>회원제 서비스 이용 및 본인확인</td>
                            </tr>
                            <tr>
                                <th>항&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</th>
                                <td>필수:이름, 아이디, 비밀번호, 성별, 이메일, 주소, 연락처 / 선택:생년월일</td>
                            </tr>
                            <tr>
                                <th>보유기간</th>
                                <td>회원탈퇴 후 5일까지</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="agree_all">
                    <form method="post" action="">
                        <fieldset>
                            <legend>개인정보 수집 및 이용</legend>
                            <div class="check_style all">
                                    <input type="checkbox" value="None" id="checkAll" name="checkAll">
                                    <label for="checkAll"><span>위의 회원약관 및 개인정보취급방침, 수집 및 이용에 모두 동의합니다.</span></label>
                                </div>
                        </fieldset>
                    </form>
                </div>
                <div class="btn_big btn_next">
                    <a href="javascript://" onclick="goNextStep();">
                        다음단계
                    </a>
                </div>
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