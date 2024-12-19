<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="/img/favicon.png" />
<link rel="stylesheet"  href="/css/common.css" />
<link rel="stylesheet"  href="/css/company_m.css" />
<style>
 .content_field{
 display: flex;
 justify-content: flex-start;
 align-items:center;
 gap:80px;

 p{
 font-size:22px;
 font-weight: 700;
 padding-left: 20px;
 }
 select{
font-size:20px;
 font-weight: 500; 
border: 1px solid #767676;
border-radius: 5px;
width: 156px;
height: 43px;
padding-left: 10px;
 }
 }
 .content_cover{
 p{
 font-size:22px;
 font-weight: 700;
 padding-left: 20px;
 }
 textarea{
width: 90%;
height: 90px; 
 
 }
 }  
</style>
</head>
<body>
<div class="container">
  <main>
    <div class="title">
   <p>수정으로 변경 불가한 사항을 관리자에게 문의하세요</p>
   <p>팝업스토어 관리자요청</p>
   </div>
   
   <h2 class="content_title">요청 팝업스토어</h2>
  <div class="content_body">
  <div class="content_header">
  <p>2024.12.14 ~ 2014.12.30</p>
  </div>
  <p class="content_store">메시X스텐리 1942 콜라보 팝업스토어</p>
  <div class ="content_bottom">
  <p>사전예약&nbsp;&nbsp;|&nbsp;&nbsp;잡화&nbsp;&nbsp;|&nbsp;&nbsp;스포츠</p>
  </div>
   </div>
 
    <h2 class="content_title">요청 내용</h2>
  <div class="content_body">
 <div class="content_field">
 <p>요청분야</p>
 <select>
 <option>요청분야</option>
 <option>팝업삭제</option>
 <option>팝업명 변경</option>
 <option>승인결과 변경</option>
 <option>기타 </option>
 </select>
 </div>
 <hr>
 <div class="content_cover">
 <p>요청 상세내용</p>
 <textarea rows="" cols="">상세 내용을 입력하시오</textarea>
 
 </div>

   </div>
 
  
  </main>
 </div>	
</body>
</html>






