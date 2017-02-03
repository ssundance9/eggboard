<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>eggboard</title>
<script type="text/javascript">
    var filter = "win16|win32|win64|mac";
    if (navigator.platform) {
        if (0 > filter.indexOf(navigator.platform.toLowerCase())){
            document.location.href = "http://m.eggboard.co.kr/user/loginView.do";
        }else{
            document.location.href = "http://www.eggboard.co.kr/user/loginView.do";
        }
    }
</script>
</head>
<body>
</body>
</html>