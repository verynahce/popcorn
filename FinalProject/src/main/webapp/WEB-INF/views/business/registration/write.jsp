<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>팝업스토어 등록</title>
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
 margin-top:23px;
 margin-bottom:26px;
width: 90%;
height: 400px; 
font-size: 16px;
 
 }

 } 
 
 
.cover_layout{
display: flex;
justify-content: center;
} 
.btn2{
width: 157px;
height: 80px;
background: white;
font-size: 24px;
font-weight: 600px;
border: 1px solid #121212;
margin-bottom: 40px;
} 
    
    
    .red{
    color:red;
    }
   
   
   
   input {
font-size:20px;
font-weight: 500; 
border: 1px solid #767676;
border-radius: 5px;
width: 250px;
height: 43px;
padding-left: 10px;	
} 


 .button {
            padding: 10px 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            color: #000;
            background-color: #f9f9f9;
            transition: background-color 0.3s;
        }



 .button.active {
            background-color: #BDFF91; /* 클릭했을 때 배경색 */
        }






    </style>
</head>
<body>
    <main>

      <div class="title">
      <p>수정으로 변경 불가한 사항을 관리자에게 문의하세요</p>
      <p>팝업스토어 관리자요청</p>
      </div>
      

      	
    <span>*입접심사에는 최소2일에서 최대 일주일이 걸릴 수 있습니다. 기간 확인후 등록 부탁드립니다</span>
    <div class="content_body">     
    <h2 class="content_title">기본 정보</h2>  
  	<div class="content_field">
        <p>팝업스토어의 명칭</p>
        <input type="text"  placeholder="팝업스토어의 명칭을 입력해주세요">
      </div>
         <hr> 
      
     <div class="content_field">
 	    <p>카테고리</p>
        <select>
        <option>카테고리1 선택</option>
        </select>
        <select >
        <option>카테고리2선택</option>
        </select>
 	 </div>
    <hr>
    
      <div class="content_field">
         <p>브랜드</p>
         <p>메인<span class="red">*</span></p><input type="text" id="brand" placeholder=" 브랜드명 필수입력"> <p>콜라보브랜드</p><input type="text" id="brand" placeholder="">
      </div>
             <hr>   
    
      <div class="content_field">
 	    <p>주 타겟 연령대</p>
        <select>
        <option>연령대</option>
        </select>
     	<p>맞춤 광고 및 추천을 위한 수집정보입니다</p>
 	 </div>
   </div>

<!-- --------------------------------------------------------------------------- -->


  <div class="content_body">     
    <h2 class="content_title">예약하기</h2>  
  	<div class="content_field">
	<p>예약기능</p>    
	
	<a href="#" class="button" onclick="toggleContent('content1', ['content2', 'content3'], this)">현장문의</a>
    <a href="#" class="button" onclick= "toggleContent('content2', ['content3', 'content1'], this)">사전예약</a>
    <a href="#" class="button" onclick="toggleContent('content3', ['content1', 'content2'], this)">현장대기예약</a>

	</div>
	

	<div class="content" id="content1" style="display: none;">
	
    <hr>
    <p>현장문의란?</p>
    <p>현장문의는 플랫폼에서 예약기능을 사용하지 않음을 의미하며 예약관련 사항을 자체적으로 관리할때  설정합니다.</p>
	</div>
	
<div class="content" id="content2" style="display: none;">
    <hr>
    <p>사전예약이란?</p>
    <p>사전예약은 사전에 정해진 기간과 시간에 적정인원수를 설정해 예약을 받는 시스템을 의미합니다.</p>
      <hr>
      <p>기능사용 여부</p>
      <p>플랫폼 자체 사전예약기능 사용여부를 체크해주세요</p>
	   <br>    
<a href="#" class="button" onclick="toggleSubContent('content4', 'content2', this)">네! 플랫폼 기능을 사용할래요</a>
<a href="#" class="button" onclick="toggleSubContent('content5', 'content2', this)">아니요! 다른 자체적인 사전예약 시스템이 있습니다</a>
    
     	  
     	  
       <div class="content" id="content4" style="display: none;">
       <hr>
        <p>플랜설정하기</p><br><a href="#" class="button" >플랜추가</a>
       </div>
</div>

<div class="content" id="content3" style="display: none;">
    <hr>
    <p>현장대기예약</p>
    <p>현장대기예약은 현장 웨이팅이 발생했을때 고객들의 웨이팅을 플랫폼에서 관리해주는 기능을 의미합니다.
선택 후 운영 페이지에서 현장대기를 관리하세요!</p>
</div>
   </div>            
                

    
   
   <div class="content_body" id="content5" style="display: none;">     
    <h2 class="content_title">예약시스템링크</h2>  
  	<div class="content_field">
	<input type="text" placeholder="예약 홈페이지 링크를 복사해주세요">
	</div>
	</div>
	
		


    </main>
    <script>
    
    function toggleContent(currentId, otherIds, button) {
        const currentDiv = document.getElementById(currentId);
        const isCurrentlyVisible = currentDiv.style.display === 'block';

        // 다른 내용 숨기기
        otherIds.forEach(id => {
            const otherDiv = document.getElementById(id);
            otherDiv.style.display = 'none';
        });

        // 현재 내용 표시/숨기기
        if (isCurrentlyVisible) {
            currentDiv.style.display = 'none'; // 현재 내용 숨기기
            button.classList.remove('active'); // 클릭한 버튼 비활성화
        } else {
            currentDiv.style.display = 'block'; // 현재 내용 표시
            resetButtons(); // 모든 버튼 초기화
            button.classList.add('active'); // 클릭한 버튼 활성화
        }
    }

    // 버튼 초기화 함수 (모든 버튼에서 active 클래스를 제거)
    function resetButtons() {
        const buttons = document.querySelectorAll('.button');
        buttons.forEach(btn => {
            btn.classList.remove('active');
        });
    }

    
    
    
    function toggleSubContent(subContentId, parentContentId, button) {
        const subContentDiv = document.getElementById(subContentId);
        const isCurrentlyVisible = subContentDiv.style.display === 'block';

        // 모든 서브 콘텐츠 숨기기
        const subContents = ['content4', 'content5'];
        subContents.forEach(id => {
            const subDiv = document.getElementById(id);
            subDiv.style.display = 'none';
        });

        // 클릭한 서브 콘텐츠 표시
        if (isCurrentlyVisible) {
            subContentDiv.style.display = 'none'; // 서브 콘텐츠 숨기기
            button.classList.remove('active'); // 서브 버튼 비활성화
        } else {
            subContentDiv.style.display = 'block'; // 서브 콘텐츠 표시
            resetSubButtons(); // 모든 서브 버튼 초기화
            button.classList.add('active'); // 클릭한 서브 버튼 활성화
        }
    }

    // 상위 버튼의 활성화 상태를 초기화하는 함수
    function resetButtons() {
        const buttons = document.querySelectorAll('.button');
        buttons.forEach(btn => {
            btn.classList.remove('active'); // 모든 상위 버튼에서 active 클래스 제거
        });
    }

    // 서브 버튼의 활성화 상태를 초기화하는 함수
    function resetSubButtons() {
        const buttons = document.querySelectorAll('.button');
        buttons.forEach(btn => {
            // 버튼의 onclick 속성이 toggleSubContent인 경우에만 초기화
            if (btn.getAttribute('onclick') && btn.getAttribute('onclick').includes('toggleSubContent')) {
                btn.classList.remove('active'); // 서브 버튼에서 active 클래스 제거
            }
        });
    }
    </script>
    
</body>
</html>
