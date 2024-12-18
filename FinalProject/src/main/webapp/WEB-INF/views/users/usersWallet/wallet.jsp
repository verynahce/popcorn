<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>팝콘</title>
    
    <style>
    * {
 	 	margin: 0;
  		padding: 0;
  		box-sizing: border-box;
  		font-family: "Pretendard", sans-serif;
	  } 

	li {
  		list-style: none;
	  }

	 a {
  		color: inherit;
  		text-decoration: none;
	  }

   body{
   		padding-top : 94px
	  }
    
    
body {
    background-color: #121212;
    color: #fff;
}

.container {
    width: 100%;
    max-width: 600px;
    margin: auto;
    text-align: center;
}

/* 텍스트*/
.content-text{       
	text-align:left;
	line-height:1.8;
}

/* 내 팝콘 1000 옆에 아이콘*/
.icon{
	 vertical-align:bottom ; 
}
    

/*츨첵 시작*/
.daily-check {
    border: 2px solid #00FF84;
    border-radius: 10px;
    padding: 20px;
    margin: 10px auto; 
    text-align: center; 
    background-color: #121212;
}
.daily-check h3{
 color: #00FF84;
 margin: 10px;
}

/*출석아이콘 틀*/
.check-list {
    display: flex;
    justify-content: space-around;
    gap: 10px;
    margin: 10px 0;
}

/*출석 아이콘*/
.check-item {
	width: 70px; 
    height: 100px; 
    border: 2px solid #00FF84; 
    border-radius: 10px;
    display: flex;
    flex-direction: column; 
    align-items: center; 
    justify-content: center; 
    background-color: #333; 
    color: white; 
    font-size: 14px; 
}


.check-item img {
    width: 50px; 
    height: 50px;
    margin-bottom: -10px; 
}

.daily-checkbtn {
    display: inline-block;
    width: 500px;
    height: 40px;
    line-height:40px;
    font-weight:700;
    font-family:'Pretendard', sans-serif;
    border-radius:25px;
    cursor: pointer;
    background: #00FF84;
    color: black;
    text-align: center;
    
}
/*츨첵 끝*/



/*팝콘내역 주위 테두리*/
.popcorn-history{ 
 border: 2px solid #00FF84;
 border-radius: 15px;
 padding: 10px;

}

/*팝콘 내역 안 정렬*/
.popcorn-history p{
text-align: left;

}

/*팝콘 내역 안에 입금 지출 버튼 */
.history-btn{			  
    display: inline-block;
    width: 100px;
    height: 40px;
    line-height:40px;
    font-weight:700;
    font-family:'Pretendard', sans-serif;
    border-radius:25px;
    cursor: pointer;
    background: #00FF84;
    color: black;
    text-align: center;
  }

/* 초기화 버튼*/
.refresh{                     
            color: white;
            font-size: 16px; 
        }
        
 /*팝콘 내역 표 좌 우측 지우기*/

tr td:first-child,  
tr td:last-child {
    border-left: none; 
    border-right: none; 
}       
        
        
/*팝콘 내역 끝*/



/* 피드등록, 코스추천 버튼*/    
 .button-container {
    display: flex; 
    justify-content: center; 
    gap: 20px; 
    margin-top: 20px; 
}
    
.walletbtn {
    display: flex; 
    justify-content: center; 
    align-items: center; 
    padding: 10px 20px; 
    font-weight: 700;
    font-family: 'Pretendard', sans-serif;
    height: 50px;
    border-radius: 5px;
    cursor: pointer;
    background: #00FF84;
    color: black;
    text-align: center;
    text-decoration: none;
    font-size: 16px; 
    min-width: 280px; 
    box-sizing: border-box; 
}




button:hover {
    background-color: #33ff33;
}


table {
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
}

th, td {
    border: 1px solid white;
    padding: 10px;
}

th {
    background-color: #333;
}



    
    </style>
</head>
<body>

    <div class="container">
        <!-- 팝콘 잔액 -->
  			<p class="content-text" style="color:gray; text-decoration:underline;"><a href="javascript:void(0);">팝콘이란?</a></p>
            <h1 class="content-text">내팝콘 <span >1000</span><img src="/img/PopcornCharater 1.png" alt="icon" width="80" height="80" class="icon"></h1>


        <!-- 일일 출석 체크 -->
        <div class="daily-check">
            <h3>일일 출석체크</h3>
            <div class="check-list">
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+20</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+30</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+40</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+50</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+60</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+70</div>
                <div class="check-item"><img src="/img/PopcornCharater 1.png" alt="icon" width="50" height="50"><br>+100</div>
            </div>
            <a class="daily-checkbtn">팝콘 받기</a>
        </div>



        <!-- 팝콘 내역 -->
        <h1 class="content-text">팝콘 내역</h1>
        <div class="popcorn-history">
            
            <table>
                 <p>
                   <a class="history-btn">입금</a>
                   <a class="history-btn">지출</a>
                   <a class="refresh" href="javascript:void(0);" ><span style="font-size: 28px;">↻</span>초기화</a>
                  </p>
                   
                   
                    <tr>
                        <td class="bodleft">2024-12-15</td>
                        <td>최초 가입</td>
                        <td class="bodright">+1000</td>
                    </tr>
                    <tr>
                        <td class="bodleft">2024-12-15</td>
                        <td>피드 쓰기</td>
                        <td class="bodright">+200</td>
                    </tr>
                    <tr>
                        <td class="bodleft">2024-12-15</td>
                        <td>코스 정하기</td>
                        <td class="bodright">-300</td>
                    </tr>
                </tbody>
            </table>
        </div>
     
  	  <div class="button-container">   
	    <a class="walletbtn">피드 등록하러가기</a>
	    <a class="walletbtn" href="/Users/RouteRecommend">코스 정해주기</a>
	  </div>
	
    </div>

    <script>
    
    </script>
</body>
</html>




