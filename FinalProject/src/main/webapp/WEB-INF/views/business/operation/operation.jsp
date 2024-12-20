<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>POP CORN.biz - 운영</title>
    <link rel="stylesheet" href="/css/common.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style type="text/css">
main {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
}

main {
    padding: 20px;
}

.store-info, .real-time-updates, .reservation, .first-reservation {
    background-color: white;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.ratings span {
    margin-right: 15px;
}

.traffic-update {
    margin-bottom: 20px;
}

canvas {
    max-width: 100%;
    height: 300px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 10px;
    text-align: center;
}

th {
    background-color: #f2f2f2;
}

.buttons {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

button {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #45a049;
}


    </style>
</head>

<body>
    <%@include file="/WEB-INF/include/header.jsp" %>
    <main>
         <section class="store-info">
            <h2>스탠리 1913 기념 팔람스토어</h2>
            <p>드디어 스탠리 1913에서 새로운 팔람스토어가 생겼다!</p>
            <div class="ratings">
                <span>현재 재고: 4</span>
                <span>평균 평점: 4.5</span>
                <span>좋아요: 200</span>
                <span>조회수: 30</span>
            </div>
        </section>

        <section class="real-time-updates">
            <h3>실시간 혼잡도 업데이트</h3>
            <div class="traffic-update">
                <label for="traffic-range">혼잡도 업데이트</label>
                <input type="range" id="traffic-range" min="0" max="100">
            </div>
            <canvas id="trafficChart"></canvas>
        </section>

        <section class="reservation">
            <h3>사전예약명단</h3>
            <div class="calendar">
                <h4>2025.04</h4>
                <div class="calendar-grid">
                    <!-- 달력 구조는 필요에 따라 추가 -->
                </div>
            </div>
            <div class="reservations">
                <h4>[2025.04.03 (목) 예약 현황]</h4>
                <table>
                    <tr>
                        <th>시간</th>
                        <th>예약 현황</th>
                        <th>상세보기</th>
                    </tr>
                    <tr>
                        <td>11:30 - 12:00</td>
                        <td>30명 예약</td>
                        <td><button>상세보기</button></td>
                    </tr>
                    <!-- 추가 예약 현황 -->
                </table>
            </div>
        </section>

        <section class="first-reservation">
            <h3>1차 명단</h3>
            <table>
                <tr>
                    <th>순번</th>
                    <th>이름</th>
                    <th>ID</th>
                    <th>연락처</th>
                    <th>상세보기</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>김진환</td>
                    <td>bange</td>
                    <td>전화번호</td>
                    <td><button>상세보기</button></td>
                </tr>
                <!-- 추가 명단 -->
            </table>
        </section>

        <div class="buttons">
            <button>예약 일자 수정하기</button>
            <button>기본정보 수정하기</button>
            <button>팔람 페이지 이동하기</button>
        </div>

    </main>
    <%@include file="/WEB-INF/include/footer.jsp" %>
        <script>
        const ctx = document.getElementById('trafficChart').getContext('2d');
        const trafficChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['월', '화', '수', '목', '금', '토', '일'],
                datasets: [{
                    label: '혼잡도',
                    data: [0, 0, 0, 0, 0, 0, 100],
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        const trafficRange = document.getElementById('traffic-range');
        trafficRange.addEventListener('input', function() {
            const congestionValue = this.value;
            // 혼잡도를 업데이트 (예: 값에 따라 그래프의 특정 바를 수정)
            const newData = [Number(congestionValue), Number(congestionValue), Number(congestionValue), Number(congestionValue), Number(congestionValue), Number(congestionValue), 100];
            trafficChart.data.datasets[0].data = newData;
            trafficChart.update();
        });
    </script>
</body>
</html>
