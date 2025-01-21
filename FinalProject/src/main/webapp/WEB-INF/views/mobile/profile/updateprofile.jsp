<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>내 프로필</title>
    <link rel="icon" type="image/png" href="/img/favicon.png" />
    <link rel="stylesheet" href="/css/mobile-common.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body{
            width: 100%;
        }
        main {
            background-color:#121212;
        }


        .inner {
            margin:0 auto;
            max-width:360px;
            display:flex;
            padding-left:40px;
        }


        .pagetitle {
            color:white;
            font-size:25px;
            margin-top:40px;
        }

        .myinfo {
            margin-top:10px;
        }

        .infotitle {
            color:#a2a2a2;
            font-size:20px;
            font-weight:900;
        }

        .infocontent {
            color:black;
            font-size:20px;
            font-weight:800;
            margin-top:10px;
        }

        .liner {
            align-self: stretch;
            height: 0px;
            border: 1px #a2a2a2 solid;
            margin-top:15px;
        }

        .btn {
            display:flex;
            justify-content:center;
            gap:20px;
            margin: 50px 0 20px 0;
        }

        .btn-update {
            width:70px;
            height: 30px;
            border:1px solid white;
            border-radius:40px;
            font-size:16px;
            background-color:#00FF84;
            color:black;
            font-weight:800;

        }

        .btn-quit {
            width:70px;
            height:30px;
            border:1px solid #ff5656;
            border-radius:40px;
            font-size:16px;
            background-color:#ff5656;
            color:black;
            font-weight:800;
            text-align: center;
            padding:5px;

        }

        .btn-block {
            width:100%;
            height:100%;
            display:flex;
            justify-content:center;
            align-items:center;
        }


    </style>
</head>
<body>
<main>
    <div class="inner">
        <div class="container">
            <h2 class="pagetitle">내 정보</h2>
            <form action="/Users/Profile/UpdateProfile" method="POST">
                <div class="myinfo">
                    <h3 class="infotitle">이름</h3>
                    <input type="text" name="name" value="${user.name}" class="infocontent">
                    <div class="liner"></div>
                </div>
                <div class="myinfo">
                    <h3 class="infotitle">닉네임</h3>
                    <input type="text" name="nickname" value="${user.nickname}" class="infocontent">
                    <div class="liner"></div>
                </div>
                <div class="myinfo">
                    <h3 class="infotitle">계정정보</h3>
                    <input type="email" name="email" value="${user.email}" class="infocontent">
                    <div class="liner"></div>
                </div>
                <div class="myinfo">
                    <h3 class="infotitle">연락처</h3>
                    <input type="tel" name="phone" value="${user.phone}" class="infocontent">
                    <div class="liner"></div>
                </div>
                <div class="btn">
                    <button type="submit" class="btn-update">저장</button>
                    <a href="/Mobile/Users/Profile/Home" class="btn-quit">취소</a>
                </div>
            </form>
        </div>
    </div>
</main>
</body>
<%@include file="/WEB-INF/include/app-navbar.jsp" %>
</html>
