<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
    <meta charset="utf-8">
    <meta property="og:title" content="EGG-Board">
    <meta property="og:url" content="https://www.???.com/">
    <meta property="og:description" content="" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>EGG-Board 회원가입</title>
    <link type="text/css" rel="stylesheet" href="/css/global.css" />
    <link type="text/css" rel="stylesheet" href="/css/style_pc.css" />
    <link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css" />
    <script src="/js/jquery-1.9.1.min.js"></script>
    <script src="/js/jquery-ui.min.js"></script>
    <script src="/js/common.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript">
    var checkedId = false;
    var checkedEmail = false;
    jQuery(document).ready(function(){
        //tab menu
        /* jQuery(".tab_con").hide();
        jQuery(".tab_con01").show();
        
        jQuery(".tab li a").click(function(){

            jQuery(".tab li a").removeClass("active");
            jQuery(this).addClass("active");
            
            var idx = jQuery(this).index(".tab li a");      
            jQuery(".tab_con").hide();
            jQuery(".tab_con0"+(idx+1)).show();
            
            return false; 
        }); */
        
        // 주소검색
        /* jQuery(".btn_search_address a").click(function(){
            jQuery(".gray_wrap").show();    
        });
        jQuery(".btn_close").click(function(){
            jQuery(".gray_wrap").hide();    
        }); */
        
        $(".entDt").datepicker();
        
        // 아이디
        $("input#userId").on("click", function() {
            $("#spanUserIdNotice").hide();
        }).on("blur", function() {
            if (!validateId($(this).val())) {
                $("#spanUserIdNotice").show();
            } else {
                $("#spanUserIdNotice").hide();
            }
        }).on("keydown", function() {
           checkedId = false;
        });
        
        // 비밀번호
        $("input#userPw").on("click", function() {
            $("#spanUserPwNotice").hide();
        }).on("blur", function() {
            if (!validatePw($(this).val())) {
                $("#spanUserPwNotice").show();
            } else {
                $("#spanUserPwNotice").hide();
            }
        });
        
        // 비밀번호 재입력
        $("input#userPwChk").on("click", function() {
            $("#spanUserPwChkNotice").hide();
        }).on("blur", function() {
            if (!validatePwChk($(this).val())) {
                $("#spanUserPwChkNotice").show();
            } else {
                $("#spanUserPwChkNotice").hide();
            }
        });
        
        // 이메일
        $("input#userEmail").on("click", function() {
            $("#spanUserEmailNotice").hide();
        }).on("blur", function() {
            if (!validateEmail($(this).val())) {
                $("#spanUserEmailNotice").show();
            } else {
                $("#spanUserEmailNotice").hide();
            }
        }).on("keydown", function() {
           checkedEmail = false;
        });
        
        $("input.henCount").on("keyup", function() {
            var val = $(this).val();
            var lastInput = val.substring(val.length - 1, val.length);
            var pattern = /[0-9/b]/gi;
            if (pattern.test(lastInput)) {
                var tot = 0;
                $(".henCount").each(function() {
                    var num = 0;
                    if ($(this).val() != "") {
                        num = parseInt($(this).val());
                    }
                    tot = tot + num;
                });
                $("input#allhenNo").val(tot);
            } else {
                var oldVal = val.substring(0, val.length - 1);
                $(this).val(oldVal);
            }
        });
        
        $("select#farmNo").on("change", function() {
           var totCnt = $(this).val();
           var m = parseInt(totCnt / 2);
           var n = totCnt % 2;
           $("#tbodyOdd").html("");
           $("#tbodyEven").html("");
           
           for (i = 0; i < m; i++) {
               var htmlStr1 = "<tr>"
                                + "<td>" + (i*2+1) + "</td>"
                                + "<td><input type=\"text\" class=\"henCount\" name=\"henCount\" placeholder=\"0\"></td>"
                                + "<td class=\"last\"><input type=\"text\" class=\"entDt\" name=\"entDt\" placeholder=\"\" ></td>"
                            + "</tr>";
               $("#tbodyOdd").append(htmlStr1);
               var htmlStr2 = "<tr>"
                                + "<td>" + (i*2+2) + "</td>"
                                + "<td><input type=\"text\" class=\"henCount\" name=\"henCount\" placeholder=\"0\"></td>"
                                + "<td class=\"last\"><input type=\"text\" class=\"entDt\" name=\"entDt\" placeholder=\"\" ></td>"
                            + "</tr>";
               $("#tbodyEven").append(htmlStr2);
           }
           
           if (n == 1) {
               var htmlStr3 = "<tr>"
                                + "<td>" + totCnt + "</td>"
                                + "<td><input type=\"text\" class=\"henCount\" name=\"henCount\" placeholder=\"0\"></td>"
                                + "<td class=\"last\"><input type=\"text\" class=\"entDt\" name=\"entDt\" placeholder=\"\" ></td>"
                            + "</tr>";
               $("#tbodyOdd").append(htmlStr3);
           }
           
           $("input#allhenNo").val(0);
           $(".entDt").datepicker();
           //.datepicker("option", "dateFormat", "yy.mm.dd");
           $("input.henCount").on("keyup", function() {
               var val = $(this).val();
               var lastInput = val.substring(val.length - 1, val.length);
               var pattern = /[0-9/b]/gi;
               if (pattern.test(lastInput)) {
                   var tot = 0;
                   $(".henCount").each(function() {
                       var num = 0;
                       if ($(this).val() != "") {
                           num = parseInt($(this).val());
                       }
                       tot = tot + num;
                   });
                   $("input#allhenNo").val(tot);
               } else {
                   var oldVal = val.substring(0, val.length - 1);
                   $(this).val(oldVal);
               }
           });
        });
    });
    
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                $("input#userAddress1").val(fullAddr);

                // 커서를 상세주소 필드로 이동한다.
                $("input#userAddress2").focus();
            }
        }).open();
    }
    
    // 아이디 유효성
    function validateId(id) {
        if (isEmpty(id)) {
            return false;
        }

        if (id.length > 12) {
            return false;
        }
        
        var pattern = /[^A-Z0-9]/gi;
        if (pattern.test(id)) {
            return false;
        }
        
        return true;
    }
    
    function checkId() {
        var id = $("input#userId").val();
        
        if (!isEmpty(id) && validateId(id)) {
            $.ajax({
                url: "/user/checkId.do",
                data: {id: id},
                success: function (data) {
                    if (data.result) {
                        checkedId = false;
                        alert("사용할 수 없는 아이디입니다. 다른 아이디를 사용해주세요.");
                    } else {
                        checkedId = true;
                        alert("사용가능한 아이디입니다.");
                    }
                }
            });
        }
    }
    
    function checkEmail() {
        var email = $("input#userEmail").val();
        
        if (!isEmpty(email) && validateEmail(email)) {
            $.ajax({
                url: "/user/checkEmail.do",
                data: {email: email},
                success: function (data) {
                    if (data.result) {
                        checkedEmail = false;
                        alert("사용할 수 없는 이메일입니다. 다른 이메일을 사용해주세요.");
                    } else {
                        checkedEmail = true;
                        alert("사용가능한 이메일입니다.");
                    }
                }
            });
        }
    }
    
    // 비밀번호 유효성
    function validatePw(pw) {
        if (isEmpty(pw)) {
            return false;
        }

        if (pw.length > 12) {
            return false;
        }
        
        var pattern1 = /[A-Z]/gi;
        var pattern2 = /[0-9]/gi;
        var pattern3 = /[~!@#$%^&*|\\\'\";:\/?]/gi;
        if (!pattern1.test(pw) || !pattern2.test(pw) || !pattern3.test(pw)) {
            return false;
        }
        
        return true;
    }
    
    // 비밀번호 재입력
    function validatePwChk(str) {
        if (isEmpty(str)) {
            return false;
        }
        
        if (str.length > 12) {
            return false;
        }
        
        var pw = $("input#userPw").val();
        
        if (str != pw) {
            return false;
        }
        
        return true;
    }
    
    // 이메일 유효성
    function validateEmail(email) {
        if (isEmpty(email)) {
            return false;
        }

        if (email.length > 30) {
            return false;
        }
        
        var pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        if (!pattern.test(email)) {
            return false;
        }
        
        return true;
    }

    function registUser() {
        var form = $("form[name='registForm']");
        //var userId = form.find("input[name='userId']");

        if (!validateParam(form.find("input[name='userId']"), "아이디를 입력해 주세요.")) {
            return false;
        }
        if (!checkedId) {
            alert("아이디 중복 확인을 해주세요.");
            return false;
        }
        if (!validateParam(form.find("input[name='userPw']"), "비밀번호를 입력해 주세요.")) {
            return false;
        }
        if (!validateParam(form.find("input[name='userName']"), "이름을 입력해 주세요.")) {
            return false;
        }
        if (!validateParam(form.find("input[name='userMphone']"), "휴대전화를 입력해 주세요.")) {
            return false;
        }
        if (!validateParam(form.find("input[name='userEmail']"), "이메일을 입력해 주세요.")) {
            return false;
        }
        if (!checkedEmail) {
            alert("이메일 중복 확인을 해주세요.");
            return false;
        }
        if (!validateParam(form.find("input[name='userAddress1']"), "주소를 입력해 주세요.")) {
            return false;
        }
        if (!validateParam(form.find("input[name='userAddress2']"), "주소를 입력해 주세요.")) {
            return false;
        }
        if (!validateParam(form.find("input[name='farmName']"), "농장명칭을 입력해 주세요.")) {
            return false;
        }
        
        var valid = true;
        $(".henCount").each(function() {
            if($(this).val() == "") {
                alert("개체수를 입력해 주세요.");
                $(this).focus();
                valid = false;
                return false;
            }
        });
        
        if (!valid) {
            return false;
        }
        
        $(".entDt").each(function() {
            if($(this).val() == "") {
                alert("입추일을 입력해 주세요.");
                $(this).focus();
                valid = false;
                return false;
            }
        });
        
        if (!valid) {
            return false;
        }
        
        form.submit();
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
        <div class="contents">
        
            <!-- S: join -->
            <div class="join_wrap">
                <h2><img src="/images/join_title.gif" alt="회원가입" /></h2>
                <div class="step clearfix">
                    <ul>
                        <li class="step01"><img src="/images/join_step01_off.gif" alt="약관동의" /></li>
                        <li class="step02 active"><img src="/images/join_step02_on.gif" alt="필수정보" /></li>
                        <li class="step03"><img src="/images/join_step03_off.gif" alt="가입완요" /></li>
                    </ul>
                </div>
                
                <form name="registForm" method="post" action="/user/registUser.do" enctype="multipart/form-data">
                    <div class="join_info">
                        <ul class="info_table">
                            <li>
                                <span class="th">아이디</span>
                                <div>
                                    <input type="text" id="userId" class="" name="userId" placeholder="영문 또는 숫자 4~12자" maxlength="12">
                                    <span class="notice" id="spanUserIdNotice" style="display:none;">올바른 아이디를 입력해주세요.</span>
                                    <span class="btn medium"><a href="javascript://" onclick="checkId();">중복 확인</a></span>
                                </div>
                            </li>
                            <li>
                                <span class="th">비밀번호</span>
                                <div>
                                    <input type="password" id="userPw" class="" name="userPw" placeholder="영문/숫자/특수문자 조합 6~12자" maxlength="12">
                                    <span class="notice" id="spanUserPwNotice" style="display:none;">올바른 비밀번호를 입력해주세요.</span>
                                </div>
                            </li>
                            <li>
                                <span class="th">비밀번호 확인</span>
                                <div>
                                    <input type="password" id="userPwChk" class="" name="userPwChk" placeholder="영문/숫자/특수문자 조합 6~12자" maxlength="12">
                                    <span class="notice" id="spanUserPwChkNotice" style="display:none;">비밀번호가 다릅니다.</span>
                                </div>
                            </li>
                            <li>
                                <span class="th">이름</span>
                                <div>
                                    <input type="text" id="userName" class="" name="userName" placeholder="" maxlength="10">
                                </div>
                            </li>
                            <li>
                                <span class="th">휴대전화</span>
                                <div class="phone_area">
                                    <input type="tel" id="userMphone" class="" name="userMphone" maxlength="11" placeholder="'-'제외하고 숫자만 입력" >                                       
                                    <!-- <span class="btn small"><a href="/">인증</a></span> -->
                                    <!-- <input type="tel" id="confirmNo" class="" name="confirmNo" maxlength="" placeholder="인증번호를 입력하세요" > -->
                                    <!-- <span class="btn small"><a href="/">확인</a></span> -->
                                </div>
                            </li>
                            <li>
                                <span class="th">이메일</span>
                                <div>
                                    <input type="text" id="userEmail" class="" name="userEmail" placeholder="" maxlength="30">
                                    <span class="notice" id="spanUserEmailNotice" style="display:none;">올바른 메일형식으로 입력해 주세요.</span>
                                    <span class="btn medium"><a href="javascript://" onclick="checkEmail();">중복확인</a></span>
                                </div>
                            </li>
                            <li>
                                <span class="th">주소</span>
                                <div>
                                    <input type="text" id="userAddress1" class="" name="userAddress1" placeholder="" >
                                    <span class="btn medium btn_search_address"><a href="javascript://" onclick="execDaumPostcode();">주소검색</a></span>
                                    <input type="text" id="userAddress2" class="" name="userAddress2" placeholder="" >
                                </div>
                            </li>
                            <li>
                                <span class="th">농장명칭</span>
                                <div>
                                    <input type="text" id="farmName" class="" name="farmName" placeholder="" maxlength="10">
                                </div>
                            </li>
                            <li>
                                <span class="th">사진</span>
                                <div>
                                    <input type="file" id="uploadFile" class="" name="uploadFile" placeholder="" >
                                </div>
                                
                            </li>
                            <li class="select_li">
                                <div class="left">
                                    <span class="th">계사총수</span>
                                    <div>
                                        <select name="farmNo" id="farmNo">
                                            <!-- <option value="선택하세요"> 선택하세요 </option> -->
                                            <option value="1"> 1 </option>
                                            <option value="2" selected="selected"> 2 </option>
                                            <option value="3"> 3 </option>
                                            <option value="4"> 4 </option>
                                            <option value="5"> 5 </option>
                                            <option value="6"> 6 </option>
                                            <option value="7"> 7 </option>
                                            <option value="8"> 8 </option>
                                            <option value="9"> 9 </option>
                                            <option value="10"> 10 </option>
                                            <option value="11"> 11 </option>
                                            <option value="12"> 12 </option>
                                            <option value="13"> 13 </option>
                                            <option value="14"> 14 </option>
                                            <option value="15"> 15 </option>
                                            <option value="16"> 16 </option>
                                            <option value="17"> 17 </option>
                                            <option value="18"> 18 </option>
                                            <option value="19"> 19 </option>
                                            <option value="20"> 20 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="right">
                                    <span class="th">개체총수</span>
                                    <div>
                                        <input type="text" id="allhenNo" class="" name="allhenNo" placeholder="" value="0" readonly="readonly">
                                    </div>
                                </div>
                            </li>
                        </ul>
                        
                        <div class="tabal_wrap">
                            <table class="henhouse_table henhouse01">
                                <colgroup>
                                    <col width="90px">
                                    <col width="80px">
                                    <col width="160px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>계사번호</th>
                                        <th>개체수</th>
                                        <th>입추일</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyOdd">
                                    <tr>
                                        <td>1</td>
                                        <td><input type="text" class="henCount" name="henCount" placeholder="0"></td>
                                        <td class="last"><input type="text" class="entDt" name="entDt" readonly="readonly"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="henhouse_table henhouse02">
                                <colgroup>
                                    <col width="90px">
                                    <col width="80px">
                                    <col width="160px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>계사번호</th>
                                        <th>개체수</th>
                                        <th>입추일</th>
                                    </tr>
                                </thead>
        
                                <tbody id="tbodyEven">
                                    <tr>
                                        <td>2</td>
                                        <td><input type="text" class="henCount" name="henCount" placeholder="0"></td>
                                        <td class="last"><input type="text" class="entDt" name="entDt" placeholder="" readonly="readonly"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>
                </form>
                
                <div class="btn_big btn_join_member"><a href="javascript://" onclick="registUser();"><img src="/images/btn_join_member.gif" alt="회원가입" /></a></div>
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
    
    <!-- S: gray layer -->
    <div class="gray_wrap">
        <div class="gray"></div>
    
        <div class="overlayer">
    
            <!-- S: 주소검색 -->
            <div class="find_address">
                <div class="head">
                    <span class="title"><img src="/images/title_find_address.gif" alt="주소검색" /></span>
                    <span>
                        <a href="javascript:void(0);" class="btn_close"><img src="/images/btn_close.gif" alt="닫기"></a>
                    </span>
                </div>
                <div class="body">
                    <ul class="tab">
                        <li><a href="#" class="active">도로명</a></li>
                        <li><a href="#">지번</a></li>
                    </ul>
    
                    <div class="tab_con tab_con01">
                        <div class="address_fome">
                            <ul>
                                <li>
                                    <select>
                                        <option>시/도 선택</option>
                                        <option></option>
                                    </select>    
                                </li>
                                <li>
                                    <select>
                                        <option>시/군/구 선택</option>
                                        <option></option>
                                    </select>    
                                </li>
                            </ul>
                            
                            <div class="road_name">
                                <input type="text" id="" name="roadName" placeholder="도로명" />
                                <input type="text" id="" name="bdNo" placeholder="건물번호" />
                            </div>
                            
                            <span class="btn_big search"><a href="#"><img src="/images/btn_address_search.gif" alt="조회" /></a></span>
                        </div>
                        <div class="address_table">
                            <span>검색결과 중 해당 주소를 클릭하시면 자동 입력됩니다.</span>
                            <table>
                                <thead>
                                    <tr>
                                        <th><img src="/images/title_post_no.gif" alt="우편번호" /></th>
                                        <th><img src="/images/title_address.gif" alt="주소" /></th>
                                    </tr>
                                    
                                </thead>
                            </table>
                            <div class="address_scroll">
                                <table>
                                
                                <tbody>
                                    <tr>
                                        <td colspan="2" class="search_none">검색결과가 없습니다.</td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>
                            
                        </div>
    
                    </div>
                    <div class="tab_con tab_con02">
                        <div class="address_fome">
                            <ul>
                                <li>
                                    <select>
                                        <option>시/도 선택</option>
                                        <option></option>
                                    </select>    
                                </li>
                                <li>
                                    <select>
                                        <option>시/군/구 선택</option>
                                        <option></option>
                                    </select>    
                                </li>
                            </ul>
                            
                            <div class="road_name">
                                
                            </div>
                            
                            <span class="btn_big search"><a href="#"><img src="/images/btn_address_search.gif" alt="조회" /></a></span>
                        </div>
                        <div class="address_table">
                            <span>검색결과 중 해당 주소를 클릭하시면 자동 입력됩니다.</span>
                            <table>
                                <thead>
                                    <tr>
                                        <th><img src="/images/title_post_no.gif" alt="우편번호" /></th>
                                        <th><img src="/images/title_address.gif" alt="주소" /></th>
                                    </tr>
                                    
                                </thead>
                            </table>
                            <div class="address_scroll">
                                <table>
                                
                                <tbody>
                                    <tr>
                                        <td colspan="2" class="search_none">검색결과가 없습니다.</td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>00000</td>
                                        <td>
                                            <strong>서울시특별시 강남구 논현로30길 14</strong>
                                            <em>[서울특별시 강남구 도곡동 12-3]</em>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>
                            
                        </div>
    
                    </div>
                </div>
                
    
            </div>
            <!-- E: 주소검색 -->
    
            <!-- S: 달력 
            <div class="calender">
                <div class="head">
                    <span class="title">날짜검색</span>
                    <span>
                        <a href="javascript:void(0);" class="btn_close"><img src="//images/btn_close.gif" alt="닫기"></a>
                    </span>
                </div>
                
            </div>
             <!--E: 달력 -->
        </div>
    
    </div>
     <!--E: gray layer -->
    
</div>
</body>
</html>