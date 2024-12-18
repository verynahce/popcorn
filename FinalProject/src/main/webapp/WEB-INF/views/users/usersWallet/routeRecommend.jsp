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

        body {
            padding-top: 94px;
            background-color: #121212;
            color: #fff;
        }

        .container {
            width: 100%;
            max-width: 600px;
            margin: auto;
            text-align: left;
        }
        
		.content-text{       
			text-align:left;
		}
	

        /* 필터 버튼 */
        .filter-select {
            width: 120px;
            height: 50px;
            border: 2px solid #00FF84;
            border-radius: 5px;
            color: white;
            background-color: #121212;
            text-align: center;
            margin-right: 10px; 
        }

        /* 검색하기 버튼 */
        .search-btn {
            background-color: #00FF84;
            border: none;
            color: #000;
            width: 200px;
            height: 50px;
            font-weight: 700;
            font-family: 'Pretendard', sans-serif;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #33ff33;
        }

        .store-name {
            display: flex;
   			justify-content: space-between;
            padding: 10px;
            margin: 10px 0; 
            border: 2px solid #00FF84;
            border-radius: 5px;
            background-color: #121212;
            color: white;
            position: relative; 
        }

        .remove-btn {
            cursor: pointer;
            color: red;
            margin-right:5px;
            font-size: 16px;
        }

        /* 네모칸과 버튼을 수평으로 정렬하기 위한 스타일 */
        .flex-container {
            display: flex;
            align-items: center;
            margin-top: 20px; /
        }

        .store-list {
            flex-grow: 1; 
        }
        
        /* 기본 네모칸(이해 못할까봐)*/
         .default-store-name {
            display: block;
            padding: 10px;
            margin: 10px 0; 
            border: 2px dashed #00FF84; /* 기본 테두리 스타일 */
            border-radius: 5px;
            background-color: #121212;
            color: white;
            text-align: center; /* 중앙 정렬 */
        }
        
    

    </style>
</head>
<body>

<div class="container">
    <h2 class="content-text">원하는 팝업 매장 선택하기</h2>
    <div class="button-group">
        <select class="filter-select" id="region-select">
            <option value="" disabled selected>지역</option>
            <option value="seoul">서울</option>
            <option value="busan">부산</option>
            <option value="incheon">인천</option>
            <option value="daegu">대구</option>
        </select>

        <select class="filter-select" id="popup-select">
            <option value="" disabled selected>팝업</option>
            <option value="메시 X 스페인 팝업">메시 X 스페인 팝업</option>
            <option value="티르티르 성수 팝업">티르티르 성수 팝업</option>
            <option value="노브랜드 팝업">노브랜드 팝업</option>
        </select>
    </div>

	
    <div class="store-list" id="store-list"></div>                 <!-- 여기에 선택한거 들어옵니다! -->  
	<div class="default-store-name" id="default-store">+</div>
	
    <div class="flex-container">
        <div class="store-list" id="store-list"></div>
        <button class="search-btn">검색하기</button>
    </div>
</div>

<script>
    // 팝업 선택 이벤트
    document.getElementById("popup-select").addEventListener("change", function () {
        const selectedValue = this.value; 
        const storeList = document.getElementById("store-list");
        const defaultStore = document.getElementById("default-store");
        
        // 팝업 리스트중 하나를 고르면 ?
        if (selectedValue) {
            // 1.네모칸 생성
            const storeNameBox = document.createElement("div");
            storeNameBox.classList.add("store-name");
            storeNameBox.textContent = selectedValue; // 선택한 팝업 이름을 네모칸에 표시

            // 2. X 버튼 삭제 기능 
            const removeBtn = document.createElement("span");
            removeBtn.textContent = "x";
            removeBtn.classList.add("remove-btn");
            removeBtn.onclick = function() {
                // 잠겼던 팝업 리스트 재선택가능 
                const optionToEnable = Array.from(document.getElementById("popup-select").options).find(option => option.value === selectedValue);
                optionToEnable.disabled = false; 
                
                // 네모칸 제거
                storeList.removeChild(storeNameBox);
                    
                // x 버튼 누르면 "팝업"으로 변경 -> 만약  리스트가 1,2,3 있을때 123 다 선택한뒤 3을 취소하면 아무것도 선택못함
                const popupSelect = document.getElementById("popup-select");
                popupSelect.value = "";
                popupSelect.options[0].selected = true; // 첫 번째 옵션(팝업)을 선택
            };

            // X 버튼을 네모칸에 추가
            storeNameBox.appendChild(removeBtn);
            // 추가된 네모칸 리스트에 표시
            storeList.appendChild(storeNameBox);
            
            // 선택된 팝업리스트 는 비활성화
            const optionToDisable = Array.from(this.options).find(option => option.value === selectedValue);
            optionToDisable.disabled = true; 
        }
    });
</script>

</body>
</html>




