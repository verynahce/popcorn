<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>pop corn</title>
<link rel="icon" type="image/png" href="/img/favicon.png" />
<link rel="stylesheet" href="/css/mobile-common.css" />
<link rel="stylesheet" href="/css/preview-popup.css" />
<!-- <script src="https://developers.kakao.com/sdk/js/kakao.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/npm/browser-scss@1.0.3/dist/browser-scss.min.js"></script>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=a9gjf918ri"></script>
	<script type="text/javascript" src="/js/MarkerClustering.js"></script>
<style>
main{
margin-bottom: 100px;
}
#map {
	width: 100%;
	height: 500px;
}

#gpsButton {
    position: absolute; /* 절대 위치 지정 */
    z-index: 1000;
    cursor: pointer;
}

/* 기본 위치 */
#gpsButton {
    bottom: 15%; /* 기본 위치 */
    right: 5%;
}

.gps {
	height: 50px;
	width: 50px;
}
body{
   background-color: #121212 !important;
    color: white;
}
.search-container {
    position: absolute;
    margin: 10px 0 10px 0; /* 중앙 정렬 */
    z-index:2000;
    width: 100%;
}

.search-input {
    width: 100%;
    padding: 5px 10px 5px 10px; /* 패딩 */
    border: 2px solid #00ff84; /* 테두리 색상 */
    border-radius: 15px; /* 둥근 모서리 */
    background-color: #121212; /* 배경색 */
    color: white; /* 글자색 */
    font-size: 20px;
}


.search-button {
    position: absolute;
    right: 10px; /* 오른쪽 여백 조정 */
    top: 50%;
    transform: translateY(-50%);
    background: transparent; /* 투명 배경 */
    border: none; /* 테두리 없음 */
    cursor: pointer; /* 포인터 커서 */
}

.search-button img {
    height: 30px; /* 아이콘 크기 */
    width: auto;
}
/* 카드 리스트 */
   .container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
    padding: 10px;
    background-color: #181818; /* Dark background like the example */
    width: 360px;
    height: auto;

}

.card {
    display: flex;
    position: relative;
    background-color: #000;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
    overflow: hidden;
    text-decoration: none;
    color: white;
    width: 360px;
}
.popup-like {
    position: absolute;
    top: 10px; /* Adjust to control vertical position */
    right: 5px; /* Adjust to control horizontal position */
    background-color: rgba(0, 0, 0, 0.7); /* Optional background for better visibility */
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 10px;
    color: red;
    display: flex;
    align-items: center;
    gap: 5px;
    z-index: 10; /* Ensure it stays on top */
}

  .popup-image {
  width:100px;
    height: auto;
}

.popup-content {
    padding: 5px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    flex: 1;
}

.popup-title {
    font-size: 17px;
    font-weight: bold;
    margin-bottom: 10px;
    width: 200px;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.popup-info {
    font-size: 14px;
    line-height: 1;
    width: 200px;
}

.popup-location,
.popup-date {
    overflow: hidden; /* 넘치는 내용 숨김 */
    white-space: nowrap; /* 줄 바꿈 방지 */
    text-overflow: ellipsis; /* 넘치는 부분을 ...으로 표시 */
    width: 100%; /* 부모 요소에 맞춰 너비 설정 */
    display: block; /* 블록 요소로 변경 */
}


.popup-location img,
.popup-date img{
width:20px;
height: 20px;
}

.popup-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
}

.popup-actions span {
    display: flex;
    align-items: center;
    font-size: 12px;
    cursor: pointer;
}

.popup-actions .fa {
    font-size: 1.1rem;
}
.popup-share{
width:120px;
font-size: 12px;
}

.popup-share img{
height: 15px;
width: 15px;
}
.scroll-button {
    position: fixed;
    bottom: 100px; /* 화면 아래에서의 거리 */
    right: 15px; /* 화면 오른쪽에서의 거리 */
    background-color: rgba(0, 255, 132, 0.7);
    color: white; /* 버튼 텍스트 색상 */
    border: none;
    border-radius: 50%;
    padding: 10px;
    font-size: 20px;
    cursor: pointer;
    z-index: 1000; /* 다른 요소 위에 표시 */
    width: 25px;
    height: 25px;
}


  .likebtn {
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    cursor: pointer; /* 포인터 커서로 변경 */
}

.likebtn img {
    margin-right: 5px; /* 이미지와 텍스트 사이의 간격 */
    height: 20px;
    width: 20px;
}
      .scroll-button {
      position: fixed;
      bottom: 15%; /* 화면 아래에서의 거리 */
      right: 2%; /* 화면 오른쪽에서의 거리 */
      background-color: rgba(0, 255, 132, 0.7);
      color: white; /* 버튼 텍스트 색상 */
      border: none;
      border-radius: 50%;
      padding: 10px;
      font-size: 20px;
      cursor: pointer;
      z-index: 1000; /* 다른 요소 위에 표시 */
      width: 40px;
      height: 40px;
  }
/* ======================== */

/* 반응형 디자인 */
@media (max-width: 768px) {
    #popup-container {
        width: 80%; /* 모바일 화면에서 너비를 더 넓게 */
        transform: translate(-50%, -110%); /* 마커 위 여백 추가 */
    }
        #gpsButton {
        top: 80%; /* 모바일 화면에서 위치 조정 */
        left: 83%; /* 모바일 화면에서 위치 조정 */
    }
}

@media (max-width: 360px) {
    #popup-container {
        width: 90%; /* 작은 모바일 화면에서 너비 확장 */
        font-size: 14px; /* 글자 크기 조정 */
        transform: translate(-50%, -120%); /* 팝업 위치 조정 */
    }

}

</style>
</head>
<body>
	<main>
		<div id="map">
		   <div class="search-container">
	        <input type="text" class="search-input">
	        <button class="search-button">
	            <img class="imgsearch" src="/images/main/search.png" alt="검색">
	        </button>
	    </div>
			<div id="gpsButton">
				<img src="/images/map/Gps_duotone_line.svg" class="gps">
			</div>
		</div>
	<div class="container">
    <c:forEach var="popup" items="${popupList}">
        <a href="/Mobile/Users/Info?store_idx=${popup.store_idx}" class="card">
        <span class="popup-like" >
            <span class="likebtn"  data-store-idx="${popup.store_idx}"  onclick="event.preventDefault(); event.stopPropagation(); LikeConfig(this);"><img src="/images/detail/noHeart.svg" class="heartimg"> <span class="like-count">${popup.like_count}</span></span>
        </span>
            <img src="/image/read?path=${fn:replace(popup.image_path, '\\', '/')}" alt="Store Image" class="popup-image">
            <div class="popup-content">
                <div class="popup-title">${popup.title}</div>
                <div class="popup-info">
                    <div class="popup-location">
                        <img src="/images/detail/locationicon.svg"> ${popup.address}
                    </div>
                    <div class="popup-date">
                        <img src="/images/detail/calender.svg"> ${popup.start_date} ~ ${popup.end_date}
                    </div>
                </div>
                <div class="popup-actions">
                <span></span>
                    <span class="popup-share">
                        <span class="bookmark"  data-store-idx="${popup.store_idx}"  onclick="event.preventDefault(); event.stopPropagation(); bookConfig(this);"><img src="/images/detail/noStar.svg"> 찜하기</span> |
                        <span class="share" onclick="event.preventDefault(); event.stopPropagation(); clipboard(window.location.href);">
                        <!--  onShare('${popup.title}', '${popup.start_date} ~ ${popup.end_date}', '${popup.image_path}', '${popup.store_idx}')" -->
                        	<img src="/images/detail/share.svg"> 공유하기
                    	</span>
                    </span>
                </div>
            </div>
        </a>
    </c:forEach>
</div>
	</main>
	 <button id="scrollToTop" class="scroll-button" onclick="scrollToTop()">
        ↑
    </button>
	<script>
	// 스크롤 맨 위로 이동하는 함수
	function scrollToTop() {
	    window.scrollTo({
	        top: 0,
	        behavior: 'smooth' // 부드럽게 스크롤
	    });
	}

	// 스크롤 위치에 따라 버튼 표시
	window.onscroll = function() {
	    const button = document.getElementById('scrollToTop');
	    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
	        button.style.display = "block"; // 100px 이상 스크롤하면 버튼 표시
	    } else {
	        button.style.display = "none"; // 100px 이하로 스크롤하면 버튼 숨김
	    }
	};

	document.addEventListener("DOMContentLoaded", function() {
	    // 기본 위치
	    var defaultCoords = new naver.maps.LatLng(37.5665, 126.9780); //기본위치: 서울
	    var map = new naver.maps.Map('map', {
	        center: defaultCoords,
	        zoom: 13,
	        zoomControl: true,
	        zoomControlOptions: {
	            position: naver.maps.Position.LEFT_CENTER,
	            style: naver.maps.ZoomControlStyle.SMALL
	        }
	    });
	    var markers=[];

	    // 마커 데이터 렌더링 함수
function renderPopupList(data) {
    const container = document.querySelector('.container');
    container.innerHTML = ''; // 기존 목록 초기화

    data.forEach(popup => {
        const card =
            '<a href="/Mobile/Users/Info?store_idx=' + popup.store_idx + '" class="card">' +
                '<span class="popup-like">' +
                    '<span class="likebtn" data-store-idx="' + popup.store_idx +
                    '" onclick="event.preventDefault(); event.stopPropagation(); LikeConfig(this);">' +
                        '<img src="/images/detail/noHeart.svg" class="heartimg"> ' +
                        '<span class="like-count">' + popup.like_count + '</span>' +
                    '</span>' +
                '</span>' +
                '<img src="/image/read?path=' + popup.image_path.replace(/\\/g, '/') +
                '" alt="Store Image" class="popup-image">' +
                '<div class="popup-content">' +
                    '<div class="popup-title">' + popup.title + '</div>' +
                    '<div class="popup-info">' +
                        '<div class="popup-location">' +
                            '<img src="/images/detail/locationicon.svg"> ' + popup.address +
                        '</div>' +
                        '<div class="popup-date">' +
                            '<img src="/images/detail/calender.svg"> ' + popup.start_date + ' ~ ' + popup.end_date +
                        '</div>' +
                    '</div>' +
                    '<div class="popup-actions">' +
                        '<span></span>' +
                        '<span class="popup-share">' +
                            '<span class="bookmark" data-store-idx="' + popup.store_idx +
                            '" onclick="event.preventDefault(); event.stopPropagation(); bookConfig(this);">' +
                                '<img src="/images/detail/noStar.svg"> 찜하기</span> | ' +
                            '<span class="share" onclick="event.preventDefault(); event.stopPropagation(); clipboard(window.location.href);">' +
                                '<img src="/images/detail/share.svg"> 공유하기' +
                            '</span>' +
                        '</span>' +
                    '</div>' +
                '</div>' +
            '</a>';

        container.insertAdjacentHTML('beforeend', card);
    });
}



	    var htmlMarker1 = {
	    	    content: '<div style="cursor:pointer;width:100px;height:100px;line-height:102px;font-size:24px;color:white;text-align:center;font-weight:bold;background:url(\'https://raw.githubusercontent.com/navermaps/marker-tools.js/refs/heads/master/marker-clustering/images/cluster-marker-1.png\');background-size:contain;"></div>',
	    	    size: N.Size(100, 100),
	    	    anchor: N.Point(50, 50)  // 앵커 포인트 중앙으로 조정
	    	},
	    	htmlMarker2 = {
	    	    content: '<div style="cursor:pointer;width:120px;height:120px;line-height:122px;font-size:26px;color:white;text-align:center;font-weight:bold;background:url(\'https://raw.githubusercontent.com/navermaps/marker-tools.js/refs/heads/master/marker-clustering/images/cluster-marker-2.png\');background-size:contain;"></div>',
	    	    size: N.Size(120, 120),
	    	    anchor: N.Point(60, 60)
	    	},
	    	htmlMarker3 = {
	    	    content: '<div style="cursor:pointer;width:140px;height:140px;line-height:142px;font-size:28px;color:white;text-align:center;font-weight:bold;background:url(\'https://raw.githubusercontent.com/navermaps/marker-tools.js/refs/heads/master/marker-clustering/images/cluster-marker-3.png\');background-size:contain;"></div>',
	    	    size: N.Size(140, 140),
	    	    anchor: N.Point(70, 70)
	    	},
	    	htmlMarker4 = {
	    	    content: '<div style="cursor:pointer;width:160px;height:160px;line-height:162px;font-size:30px;color:white;text-align:center;font-weight:bold;background:url(\'https://raw.githubusercontent.com/navermaps/marker-tools.js/refs/heads/master/marker-clustering/images/cluster-marker-4.png\');background-size:contain;"></div>',
	    	    size: N.Size(160, 160),
	    	    anchor: N.Point(80, 80)
	    	},
	    	htmlMarker5 = {
	    	    content: '<div style="cursor:pointer;width:180px;height:180px;line-height:182px;font-size:32px;color:white;text-align:center;font-weight:bold;background:url(\'https://raw.githubusercontent.com/navermaps/marker-tools.js/refs/heads/master/marker-clustering/images/cluster-marker-5.png\');background-size:contain;"></div>',
	    	    size: N.Size(180, 180),
	    	    anchor: N.Point(90, 90)
	    	};

	    // 전역 변수로 userMarker 선언
	    var userMarker = null;

	    // 현재 위치 가져오기
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(function(position) {
	            var userLat = position.coords.latitude;
	            var userLon = position.coords.longitude;
	            var userCoords = new naver.maps.LatLng(userLat, userLon);

	            // 사용자의 현재 위치로 지도 중심 이동
	            map.setCenter(userCoords);

	            // 현재 위치에 마커 표시
	            userMarker = new naver.maps.Marker({
	                position: userCoords,
	                map: map,
	                icon: {
	                    url: '/images/map/Map-07-512.webp',
	                    scaledSize: new naver.maps.Size(50, 50)
	                },
	                title: '내 위치'
	            });

	            // 팝업 리스트 데이터 가져오기
	            fetch('/Mobile/Users/Map/popuplist')
	                .then(response => response.json())
	                .then(data => {
	                    data.forEach(location => {

	                        const { title, latitude, longitude, hit_count, start_date, end_date, igdate, image_path, store_idx, like_count, address} = location;

	                        console.log("like_count"+like_count, "address"+address);
	                        var coords = new naver.maps.LatLng(latitude, longitude);


	                            var titlecoords = new naver.maps.LatLng(latitude, longitude);
	                            // 제목을 항상 표시할 위치 설정
	                            var titleMarker = new naver.maps.Marker({
								    position: titlecoords,
								    map: map,
								    icon: {
							            content: [
							                '<div style="position: relative;">',
							                '<img src="/images/map/location_on.svg" style="width: 50px; height: 50px;">',
							                '<div style="position: absolute; top: -40px; left: 50%; transform: translateX(-50%); background-color: rgba(143, 255, 68, 0.8); color: #000000; padding: 5px; border-radius: 5px; font-size: 22px; white-space: nowrap; text-overflow: ellipsis;">',
							                title,
							                '</div>',
							                '</div>'
							            ].join(''),
							            size: new naver.maps.Size(80, 80),
							            anchor: new naver.maps.Point(40, 80)
							        },
							        title: title
								});

	                            //마커 객체에 관련 데이터를 추가
	                            titleMarker.set("popupData", {
	                            	store_idx: store_idx,
	                                title: title,
	                                hit_count: hit_count,
	                                start_date: start_date,
	                                end_date: end_date,
	                                igdate: igdate,
	                                image_path: image_path,
	                                address: address,
	                                like_count: like_count
	                            });

	                            markers.push(titleMarker);

	                    	    // 지도에서 보이는 영역 내에 있는 마커 필터링
	                    	    function updatePopupList(bounds) {
	                    	        const filteredPopups = markers.filter(titleMarker => {
	                    	            const position = titleMarker.getPosition();
	                    	            return bounds.hasLatLng(position); // 마커가 지도 경계 내에 포함되는지 확인
	                    	        });
	                    	        // 필터링된 마커가 존재할 경우 목록 갱신
	                    	        if (filteredPopups.length > 0) {
	                    	            const popupData = filteredPopups.map(titleMarker => titleMarker.get("popupData"));
	                    	            renderPopupList(popupData);
	                    	        } else {
	                    	            // 마커가 없을 경우의 처리 (원하는 경우)
	                    	            const container = document.querySelector('.container');
	                    	            container.innerHTML = "<div class='nodata'>팝업스토어가 없습니다.</div>"; // 메시지 표시
	                    	        }
	                    	    }

	                    	    // 지도 경계가 변경될 때마다 호출
	                    	    naver.maps.Event.addListener(map, 'idle', function() {
	                    	        const bounds = map.getBounds();
	                    	        updatePopupList(bounds);
	                    	    });

	                	        // 마커 클릭 시 목록에 표시될 데이터 업데이트
	                	        naver.maps.Event.addListener(titleMarker, 'click', function() {
	                	            const popupData = titleMarker.get("popupData");
	                	            renderPopupList([popupData]); // 클릭된 마커의 데이터만 목록에 표시
	            	                map.setCenter(titlecoords);
	            	                map.setZoom(18);
	                	        });

	                	     // 검색 버튼 클릭 이벤트 등록
	                	        const searchButton = document.querySelector('.search-button');
	                	        searchButton.addEventListener('click', searchAndMoveToMarker);

	                	        const searchInput = document.querySelector('.search-input');
	                	        searchInput.addEventListener('keyup', function (event) {
	                	            if (event.key === 'Enter') {
	                	                searchAndMoveToMarker();
	                	            }
	                	        });

	                        	    function searchAndMoveToMarker() {
	                        	        const searchTerm = searchInput.value.toLowerCase().trim();
	                        	        const foundMarker = markers.find(marker => {
	                        	            const title = marker.get("popupData").title.toLowerCase(); // 데이터에서 제목 가져오기
	                        	            return title.includes(searchTerm);
	                        	        });

	                        	        if (foundMarker) {
	                        	            const position = foundMarker.getPosition();
	                        	            if (position) {
	                        	                map.setCenter(position);
	                        	                map.setZoom(18); // 적절한 줌 레벨 설정
	                        	                foundMarker.setAnimation(naver.maps.Animation.BOUNCE);
	                        	                setTimeout(() => foundMarker.setAnimation(null), 2100);
	                        	            } else {
	                        	                console.error("Marker position is undefined");
	                        	            }
	                        	        } else {
	                        	            alert("검색 결과가 없습니다.");
	                        	        }
	                        	    }
	                        	    if (markers.length === 0) {
	                        	        alert("데이터가 로드되지 않았습니다.");
	                        	        return;
	                        	    }

	                        	    searchButton.addEventListener('click', searchAndMoveToMarker);

	                        	    searchInput.addEventListener('keyup', function(event) {
	                        	        if (event.key === 'Enter') {
	                        	            searchAndMoveToMarker();
	                        	        }
	                        	    });



	                            var markerClustering = new MarkerClustering({
	                                minClusterSize: 2,
	                                maxZoom: 13,
	                                map: map,
	                                markers: markers, // markers 배열을 그대로 사용
	                                disableClickZoom: false,
	                                gridSize: 150,
	                                icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
	                                indexGenerator: [10, 100, 200, 500, 1000],
	                                stylingFunction: function(clusterMarker, count) {
	                                    const displayedCount = count; // 클러스터 수를 2로 나눔
	                                    $(clusterMarker.getElement()).find('div:first-child').text(displayedCount); // 클러스터 수를 표시
	                                }
	                            });


	                        });
	                    })
	                    .catch(error => console.error('Error:', error));
	        }, function() {
	            alert('위치 정보를 가져올 수 없습니다.');
	            map.setCenter(defaultCoords);
	        }, {
	            enableHighAccuracy: true
	        });
	    } else {
	        alert('이 브라우저에서는 위치 정보를 지원하지 않습니다.');
	        map.setCenter(defaultCoords);
	    }

	    // GPS 버튼 클릭 시 현재 위치로 이동
	    document.getElementById('gpsButton').onclick = function() {
	        if (navigator.geolocation) {
	            // 기존 마커가 있으면 지도에서 제거
	            if (userMarker) {
	                userMarker.setMap(null);
	            }

	            navigator.geolocation.getCurrentPosition(function(position) {
	                var userLat = position.coords.latitude;
	                var userLon = position.coords.longitude;
	                var userCoords = new naver.maps.LatLng(userLat, userLon);

	                // 현재 위치로 지도 이동
	                map.setCenter(userCoords);

	                // 현재 위치에 마커 표시 (특별한 아이콘 사용)
	                userMarker = new naver.maps.Marker({
	                    position: userCoords,
	                    map: map,
	                    icon: {
	                        url: '/images/map/Map-07-512.webp',
	                        scaledSize: new naver.maps.Size(50, 50)
	                    },
	                    title: '내 위치',
	                    animation: naver.maps.Animation.BOUNCE
	                });


	            }, function() {
	                alert('위치 정보를 가져올 수 없습니다.');
	            }, {
	                enableHighAccuracy: true
	            });
	        } else {
	            alert('이 브라우저에서는 위치 정보를 지원하지 않습니다.');
	        }
	    };
	});

	document.addEventListener("DOMContentLoaded", () => {
	    // 모든 좋아요 버튼에 대해 LikeConfig 실행 (상태 확인만)
	    const likeButtons = document.querySelectorAll('.likebtn');
	    likeButtons.forEach(button => {
	        LikeConfig(button);  // 페이지 로드 시 상태 확인만 실행
	    });

	    // 좋아요 버튼 클릭 시 처리
	    likeButtons.forEach(button => {
	        button.addEventListener('click', () => {
	            // 좋아요 상태를 클릭 시에만 토글
	            toggleLike(button);
	        });
	    });
	});

	function LikeConfig(likeElement) {
	    const store_idx = likeElement.getAttribute('data-store-idx');

	    const content = {
	        store_idx: store_idx
	    };

	    fetch(`/Popup/Mobile/Like/Config`, {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
		    if (!response.ok) {
		        // 상태 코드가 2xx가 아닐 경우 오류 처리
		        return response.text().then(text => {
		            throw new Error(`로그인 실패: ${text}`);
		        });
		    }

		    // 응답 본문이 비어있지 않은지 확인
		    return response.json().catch(err => {
		        // JSON 변환 실패 시 처리
		        return null; // null 반환
		    });
		})
	    .then(data => {
	        // data가 null인 경우는 좋아요가 안 눌려져 있는 상태로 처리
	        if (data == null) {
	        	const imgElement = likeElement.querySelector('img');
	            imgElement.src = '/images/detail/noHeart.svg';
	        } else {
	        	const imgElement = likeElement.querySelector('img');
	            imgElement.src = '/images/detail/heart.svg';
	        }
	    })
	    .catch(error => {
	        console.error('에러:', error);
	    });
	}

	// 좋아요 상태를 변경하는 함수 (클릭 시 호출됨)
	function toggleLike(likeElement) {
	    const store_idx = likeElement.getAttribute('data-store-idx');
	    const content = { store_idx: store_idx };

	    // 서버에서 좋아요 상태를 가져옴
	    fetch(`/Popup/Mobile/Like/Config`, {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (response.status === 401) {
	            window.location.href = '/Mobile/Users/LoginForm';
	        } else {
	            // 응답 본문이 비어있지 않은지 확인
	            return response.json().catch(err => {
	                // JSON 변환 실패 시 처리
	                return null; // null 반환
	            });
	        }
	    })
	    .then(data => {
	        if (data == null) {
	            // 좋아요가 안 눌린 상태이면 좋아요 추가
	            LikeUp(likeElement);
	        } else {
	            // 이미 좋아요가 눌린 상태이면 좋아요 취소
	            LikeDown(data, likeElement);
	        }
	    })
	    .catch(error => {
	        console.error('좋아요 상태 확인 실패:', error);
	    });
	}

	// 좋아요 추가
	function LikeUp(likeElement) {
	    const store_idx = likeElement.getAttribute('data-store-idx');
	    const content = { store_idx: store_idx };

	    fetch(`/Popup/Mobile/Like/Write`, {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (response.status === 401) {
	            window.location.href = '/Mobile/Users/LoginForm';
	        } else {
	            return response.json();
	        }
	    })
	    .then(data => {
	        if (data) {
	            const imgElement = likeElement.querySelector('img');
	            if (imgElement) imgElement.src = '/images/detail/heart.svg';

	            const likeCountElement = likeElement.querySelector('.like-count');
	            if (likeCountElement) likeCountElement.textContent = data;
	        }
	    })
	    .catch(error => console.error('좋아요 처리 실패:', error));
	}

	// 좋아요 취소
	function LikeDown(ls_idx, likeElement) {
	    const store_idx = likeElement.getAttribute('data-store-idx');
	    const content = { ls_idx: ls_idx, store_idx: store_idx };

	    fetch(`/Popup/Like/Delete`, {
	        method: 'DELETE',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
	        return response.json();
	    })
	    .then(data => {
	        const imgElement = likeElement.querySelector('img');
	        if (imgElement) imgElement.src = '/images/detail/noHeart.svg';

	        const likeCountElement = likeElement.querySelector('.like-count');
	        if (likeCountElement) likeCountElement.textContent = data;
	    })
	    .catch(error => console.error('좋아요 삭제 실패:', error));
	}


	document.addEventListener("DOMContentLoaded", () => {
	    const bookmarkButtons = document.querySelectorAll('.bookmark');
	    bookmarkButtons.forEach(button => {
	    	bookConfig(button);  // 페이지 로드 시 상태 확인만 실행
	    });

	    bookmarkButtons.forEach(button => {
	        button.addEventListener('click', () => {
	            // 좋아요 상태를 클릭 시에만 토글
	            toggleBookmark(button);
	        });
	    });
	});

	function bookConfig(bookmarkElement) {
	    const store_idx = bookmarkElement.getAttribute('data-store-idx');

	    const content = {
	        store_idx: store_idx
	    };

	    fetch(`/Popup/Mobile/Bookmark/Config`, {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
		    if (!response.ok) {
		        // 상태 코드가 2xx가 아닐 경우 오류 처리
		        return response.text().then(text => {
		            throw new Error(`로그인 실패: ${text}`);
		        });
		    }

		    // 응답 본문이 비어있지 않은지 확인
		    return response.json().catch(err => {
		        // JSON 변환 실패 시 처리
		        return null; // null 반환
		    });
		})
	    .then(data => {
	        // data가 null인 경우는 좋아요가 안 눌려져 있는 상태로 처리
	        if (data == null) {
	        	const imgElement = bookmarkElement.querySelector('img');
	            imgElement.src = '/images/detail/noStar.svg';
	        } else {
	        	const imgElement = bookmarkElement.querySelector('img');
	            imgElement.src = '/images/detail/star.svg';
	        }
	    })
	    .catch(error => {
	        console.error('에러:', error);
	    });
	}
	//좋아요 상태를 변경하는 함수 (클릭 시 호출됨)
	function toggleBookmark(bookmarkElement) {
	    const store_idx = bookmarkElement.getAttribute('data-store-idx');
	    const content = { store_idx: store_idx };

	    // 서버에서 좋아요 상태를 가져옴
	    fetch(`/Popup/Mobile/Bookmark/Config`, {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (response.status === 401) {
	            window.location.href = '/Mobile/Users/LoginForm';
	        } else {
	            // 응답 본문이 비어있지 않은지 확인
	            return response.json().catch(err => {
	                // JSON 변환 실패 시 처리
	                return null; // null 반환
	            });
	        }
	    })
	    .then(data => {
	        if (data == null) {
	            // 좋아요가 안 눌린 상태이면 좋아요 추가
	            BookmarkUp(bookmarkElement);
	        } else {
	            // 이미 좋아요가 눌린 상태이면 좋아요 취소
	            BookmarkDown(data, bookmarkElement);
	        }
	    })
	    .catch(error => {
	        console.error('좋아요 상태 확인 실패:', error);
	    });
	}

	function BookmarkUp(bookmarkElement) {
		const store_idx = bookmarkElement.getAttribute('data-store-idx');
	    const content = {
	        store_idx: store_idx
	    };

	    fetch(`/Popup/Mobile/Bookmark/Write`, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json',
	        },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (response.status === 401) {
	            // 리다이렉션 처리
	            window.location.href = '/Mobile/Users/LoginForm';
	        } else {
	            return response.json(); // 다른 정상 응답 처리
	        }
	    })
	    .then(data => {
	        if (data) {
	            // bookmarkElement의 자식 img 요소 찾기
	            const imgElement = bookmarkElement.querySelector('img');

	            // img 요소의 src 속성 변경
	            if (imgElement) {
	                imgElement.src = '/images/detail/star.svg'; // 원하는 이미지 경로로 변경
	            }

	            bookmarkElement.classList.add('bookmark-on');
	        }
	    })
	    .catch(error => {
	        console.error('에러발생', error);
	    });
	}

	function BookmarkDown(data, bookmarkElement) {
	    const content = {
	        bookmark_idx: data
	    };

	    fetch(`/Popup/Bookmark/Delete`, {
	        method: 'DELETE',
	        headers: {
	            'Content-Type': 'application/json',
	        },
	        body: JSON.stringify(content),
	    })
	    .then(response => {
	        if (!response.ok) {
	            throw new Error(`HTTP error! status: ${response.status}`);
	        }
	        return response.json(); // 응답을 JSON으로 변환
	    })
	    .then(data => {
	        // bookmarkElement의 자식 img 요소 찾기
	        const imgElement = bookmarkElement.querySelector('img');

	        // img 요소의 src 속성 변경
	        if (imgElement) {
	            imgElement.src = '/images/detail/noStar.svg'; // 원하는 이미지 경로로 변경
	        }
	        bookmarkElement.classList.remove('bookmark-on'); // 북마크 상태 제거
	    })
	    .catch(error => {
	        console.error('북마크 내역이 없습니다', error);
	    });
	}

	</script>
	<script>
        function clipboard(text) {
            // 모바일 브라우저에 대한 처리
            if (navigator.clipboard) {
                // 최신 브라우저에서 clipboard API 사용
                navigator.clipboard.writeText(text)
                    .then(() => {
                        console.log('클립보드에 복사되었습니다:', text);
                        alert('클립보드에 복사되었습니다: ' + text);
                    })
                    .catch(err => {
                        console.error('클립보드 복사 실패:', err);
                        alert('클립보드 복사에 실패했습니다. 다시 시도해주세요');
                    });
            } else {
                const textArea = document.createElement('textarea');
                textArea.value = text;
                document.body.appendChild(textArea);
                textArea.select();

                try {
                    const successful = document.execCommand('copy');
                    if (successful) {
                        console.log('클립보드에 복사되었습니다:', text);
                    } else {
                        throw new Error('복사 실패');
                    }
                } catch (err) {
                    console.error('클립보드 복사 실패:', err);
                    alert('클립보드 복사에 실패했습니다. 다시 시도해주세요');
                } finally {
                    document.body.removeChild(textArea);
                }
            }
        }
	</script>
	<!-- <script>
	    // Kakao SDK 초기화
	    Kakao.init('4c54ad5ba758bf789727f818ba5af518'); // Replace with your actual JavaScript Key
	    console.log(Kakao.isInitialized()); // 초기화 확인

	    function onShare(title, description, imagePath, storeIdx) {
	        if (!Kakao.isInitialized()) {
	            alert('Kakao SDK가 초기화되지 않았습니다.');
	            return;
	        }

	        const imageUrl = `http://localhost:9090/image/read?path=\${encodeURIComponent(imagePath)}`;
	        const linkUrl = `http://localhost:9090/Popup/StoreDetails?store_idx=\${storeIdx}`;

	        Kakao.Link.sendDefault({
	            objectType: 'feed',
	            content: {
	                title: title,
	                description: description,
	                imageUrl: imageUrl,
	                link: {
	                    mobileWebUrl: linkUrl,
	                    webUrl: linkUrl,
	                },
	            },
	            buttons: [
	                {
	                    title: '상세보기',
	                    link: {
	                        mobileWebUrl: linkUrl,
	                        webUrl: linkUrl,
	                    },
	                },
	            ],
	        })
	        .then(() => {
	            console.log('공유 성공');
	        })
	        .catch((err) => {
	            console.error('공유 실패', err);
	        });
	    }
	</script> -->
</body>
<%@include file="/WEB-INF/include/app-navbar.jsp" %>
</html>
