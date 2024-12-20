<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="/img/favicon.png" />
<link rel="stylesheet" href="/css/common.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

body{
background: #F1F1F1;
}
 .container {

display:flex;
justify-content: center;
position: relative;

} 
main{
width: 1400px;
padding: 46px;
background: #E8EEE7;

}
.content_box{
width: 100%;
background: #ffffff;
padding: 46px 0 ;
border-radius: 30px;
}
.box_layout{
display: flex;
}
.box_circle{
width: 120px;
height: 120px;
border-radius: 50px;
background: #D3FFE7;
display: flex;
justify-content: center;
align-items: center;
}
.box_info{
margin: 0 0 0 25px;
p:first-child {
font-size: 14px;
font-weight: 400;
color: 	#ACACAC;
} 
p:nth-child(2) {
font-size: 32px;
font-weight: 800;	
margin: 15px 0;
}
}
.box_updown{
display: flex;
justify-content: flex-start;
font-size: 16px;
font-weight: 500;
}
.green{
color: #00AC4F;
}
.red{
color: #D0004B;
}
#box_table{
width: 100%;
td{
border-right: 1px solid #F0F0F0;
width: 33%;
padding-left: 46px;
}

}

.content_box2{
width: 100%;
background: #ffffff;
padding: 46px;
border-radius: 30px;
}
#box_title{
font-size: 22px;
font-weight: 700;
}
hr{
margin: 95px 0;
border: none; 
height: 2px; 
background-color: white; 
}
.box_filter{
display: flex;
}
</style>
</head>
<body>
  
  <div class="container">
  <main>
  <div class="content_box">
     <table id ="box_table">
     <tr>
       <td>  
       <div class="box_layout">
         <div class="box_circle"><img src="/images/icon/store3.png"></div>
         <div class="box_info">
          <p>총 스토어 수</p>
          <p>5,423</p>
          <div class="box_updown">
            <img src="/images/icon/arrowdown.png">
            <div><span class="green">16%</span>이번 달</div>
          </div>
          
         </div>
       </div>
       </td>
       
              <td>  
       <div class="box_layout">
         <div class="box_circle"><img src="/images/icon/profilecheck.png"></div>
         <div class="box_info">
          <p>담당자 계정</p>
          <p>1,893</p>
          <div class="box_updown">
            <img src="/images/icon/arrowup.png">
            <div><span class="red">1%</span>이번 달</div>
          </div>
          
         </div>
       </div>
       </td>
       
        <td>  
       <div class="box_layout">
         <div class="box_circle"><img src="/images/icon/storemarker.png"></div>
         <div class="box_info">
          <p>현재 운영중인 스토어</p>
          <p>192</p>

          
         </div>
       </div>
       </td>

     </tr>
     </table>
  </div>
   <hr>
   <div class="content_box2">
    <p id ="box_title">모든 스토어 입점 요청 내역</p>
    
   <div class="box_filter">
   <p id="box_full">Active Members</p>
   <input id="box_search"type="text">
   <select id="box_sort">
   <option>최신순</option>
   <option>미승인</option>
   <option>승인</option>
   <option>담당자 요청</option>
   </select>
   </div>
   <table></table>
   </div>

  </main>	
  </div>
</body>
</html>
  

  

