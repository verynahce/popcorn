<h1>팝업스토어 플랫폼 프로젝트 - 팝콘(POPCORN)</h1>

<img width="959" height="537" alt="image" src="https://github.com/user-attachments/assets/cc719277-6049-4232-a383-5ebcbb06edb0" />
<ul>
  <li>프로젝트 기간 : 2024.11.19 ~ 2024.11.29 (10일)</li>
</ul>

<h2>프로젝트 소개</h2>
<ul>
  <li>POPCORN은 팝업스토어 예약 플랫폼입니다.  </li> 
  <li>실시간 예약, 팝업 코스 설정, 지도 기반 위치 확인, 팝업 정보 제공 기능을 지원하여  브랜드에는 효율적인 홍보 채널을, 소비자에게는 편리하고 맞춤형 경험을 제공합니다.</li>
</ul>
&nbsp


<h2>예약 시연 영상</h2>

#### 사진 클릭시 이동 >>
[<img src="https://github.com/user-attachments/assets/2a65873a-ace1-4c68-a471-aaed288ad859" width="640"/>](https://youtu.be/AL6hZP5hm5M)


#### 전체시연영상
<h6>https://youtu.be/f_H1YPZHJ60</h6> 
&nbsp


<h2>담당 업무</h2>

#### 기업 담당자 웹 페이지 전반 개발 및 예약/입점 관리 기능 구현

<ul>
 <li>팝업스토어 입점 게시글 CRUD(등록·수정·삭제) 기능 구현</li> 
 <li>사전예약 시스템 개발: 기간 설정, 예약 인원 관리, 예약 타임 슬롯 설정</li> 
 <li> 실시간 예약 기능 구현: WebSocket 기반 예약 취소/확인 및 순번 알림 처리</li> 
 <li>관리자 기능 개발: 팝업 게시글 삭제·수정 요청 처리</li> 
 <li>기업 담당자 회원 정보 수정 기능 구현</li> 
 <li> 실시간 예약 대기 현황 조회 기능 개발</li> 
 <li>앱 내 **예약 미루기(대기자 순번 조정)** 기능 추가</li> 
</ul>


# 개발언어
![Image](https://github.com/user-attachments/assets/2f0267f4-f364-4915-982c-00196aa1b8ac)





# 트러블 슈팅

### 1. 사례 – 네이버 지도 API Submodule 적용 불가 문제

**문제**  
- 네이버 지도 API의 `geolocation` 서브모듈은 **HTTPS 환경에서만 동작**  
- `localhost` 개발 단계에서는 호출이 불가하여 지도 초기화 실패 및 주소 → 좌표 변환 불가 문제 발생

**해결 (임시 대체)**  
- 개발 단계에서는 **Nominatim(OpenStreetMap) API**를 사용해 주소를 위도·경도로 변환  
- 네이버 지도 객체에는 변환된 좌표를 직접 주입하여 로컬 환경에서도 정상적으로 지도 렌더링 가능

```javascript
// 개발 환경: Nominatim 대체 적용
const requestUrl = 'https://nominatim.openstreetmap.org/search?format=json&q=' 
    + encodeURIComponent(storeAddress);

fetch(requestUrl)
    .then(response => response.json())
    .then(result => {
        const latitude = result[0].lat;
        const longitude = result[0].lon;
        const mapCenter = new naver.maps.LatLng(latitude, longitude);

        const map = new naver.maps.Map('map', {
            center: mapCenter,
            zoom: 14
        });

        new naver.maps.Marker({
            position: mapCenter,
            map: map
        });
    })
    .catch(error => console.error('좌표 변환 오류:', error));

```
- 운영 환경(HTTPS)에서는 네이버 API의 geolocation을 그대로 사용하는 것이 권장
-   Nominatim은 무료 API라 트래픽이 몰리면 속도가 느리거나 차단되거나 주소가 약간의 오차가 생길 수 있다는 단점이 있으나 개발단계라서 접목해서 진행 운영과 개발을 분리하면 더 도움 될 것같다는 생각을 했음



### 2. 사례 – 실시간 예약 대기 평균 그래프 집계 오류

**문제**  
- 가게별 실시간 예약 대기 평균 시간을 그래프로 표현해야 했으나,  
  - 단순 등록 시점(`cdate`) 기준으로 계산 시 실제 체감 대기 시간과 불일치 발생  
  - 그래프가 시간 단위가 아닌 이벤트 발생 단위로 집계되어 고객이 보기 어려움  
- 특히 **예약 대기 완료 시점**을 기준으로 하지 않으면, 혼잡 시간대의 대기 시간이 왜곡되는 문제가 발생

**해결**  
- **대기 완료 시점(`edate`) 기준**으로 대기 시간을 측정  
- 30분 단위로 버킷팅(`00분/30분`) 하여 구간별 평균을 계산  
- Chart.js에서 해당 데이터를 `label=HH:mm`, `data=average`로 바인딩하여 시각화  
- 고객은 상세 페이지에서 **30분 단위 팝업 발생 시점**에만 평균 그래프 확인 가능하도록 구현  

```java
// Service: 30분 단위 평균 대기시간 집계
@Override
public List<Map<String, Object>> getTimeGrape(int storeIdx) {
    List<Map<String, String>> waitingData = watingMapper.getWatingTime(storeIdx);
    Map<LocalDateTime, List<Long>> timeBuckets = new TreeMap<>();

    for (Map<String, String> entry : waitingData) {
        LocalDateTime cdate = LocalDateTime.parse(entry.get("CDATE"), formatter);
        LocalDateTime edate = LocalDateTime.parse(entry.get("EDATE"), formatter);

        long waitMinutes = ChronoUnit.MINUTES.between(cdate, edate);

        // 종료 시점을 30분 단위로 버킷팅
        LocalDateTime bucket = edate.truncatedTo(ChronoUnit.HOURS)
                                    .plusMinutes((edate.getMinute() / 30) * 30);

        timeBuckets.computeIfAbsent(bucket, k -> new ArrayList<>()).add(waitMinutes);
    }

    // 구간별 평균 계산
    return timeBuckets.entrySet().stream()
            .map(entry -> {
                Map<String, Object> result = new HashMap<>();
                result.put("time", entry.getKey());
                result.put("average", entry.getValue().stream()
                                  .mapToLong(Long::longValue)
                                  .average()
                                  .orElse(0.0));
                return result;
            })
            .collect(Collectors.toList());
}
```
```
// Front: Chart.js 시각화 (30분 단위 평균 대기시간)
function waitingTime(storeIdx) {
    fetch(`/api/waiting/timegrape?store_idx=${storeIdx}`)
        .then(res => res.json())
        .then(jsonData => {
            const labels = jsonData.map(item => {
                const date = new Date(item.time);
                return `${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
            });
            const data = jsonData.map(item => item.average);

            if (trafficChart) trafficChart.destroy();
            trafficChart = new Chart(ctx, {
                type: 'bar',
                data: { labels, datasets: [{ label: '평균 대기 소요 시간(분)', data }] },
                options: { responsive: true, maintainAspectRatio: false }
            });
        })
        .catch(err => console.error('Error fetching data:', err));
}
```

### 3. 사례 – WebSocket 구독 다중 유지 시 화면 동기화 문제

**문제**  
- 매장별 WebSocket 채널(`/topic/Waiting/{storeIdx}`)을 모두 구독해 두는 구조  
- 캐러셀 화면 전환 시 특정 매장 화면만 보여줘야 하지만,  
  - 모든 구독 데이터가 한 번에 반영되면서 **대기 리스트가 섞여 표시**되는 문제가 발생  

**해결**  
- 구독 자체는 여러 개 유지 (`subscriptionMap`에 저장)  
- 다만, 캐러셀 전환 시 `currentCompanyIdx`를 기준으로 **현재 활성화된 매장 데이터만 화면에 반영**하도록 로직 개선  
- 불필요한 중복 렌더링을 막아 **화면 동기화 안정성**을 확보  

```javascript
let subscriptionMap = {};
let currentCompanyIdx = null;

// 매장 구독 등록 (여러 매장 동시에 구독 가능)
function subscribeStore(storeIdx) {
  const subscription = stompClient.subscribe(`/topic/Waiting/${storeIdx}`, function(message) {
    const waitingList = JSON.parse(message.body);

    // 현재 캐러셀 매장과 일치할 때만 UI 반영
    if (storeIdx === currentCompanyIdx) {
      updateWaitingList(waitingList);
    }
  });

  subscriptionMap[storeIdx] = subscription;
}

// 캐러셀 이동 시 현재 매장 변경
function onCarouselChange(storeIdx) {
  currentCompanyIdx = storeIdx;
  console.log(`현재 화면 매장: ${currentCompanyIdx}`);
}
```
### 4. 사례 – 실시간 예약 Race Condition & SRP 위배

**문제**  
- 실시간 예약 시 다수 사용자 동시 요청으로 **Race Condition(경합 조건)** 발생  
- 예약 순번 꼬임 및 중복 예약 문제 발생  
- 예약/상태 변경/포인트 차감 로직이 단일 서비스 계층에 집중되어 **SRP(단일 책임 원칙) 위배** 및 롤백 처리 불안정

**해결**  
- `@Transactional`을 적용하여 예약 상태 변경, 노쇼 처리, 순번 재정렬을 **원자적(Atomic)**으로 처리  
- 트랜잭션 단위에서 예외 발생 시 전체 작업을 롤백하여 데이터 무결성 보장  
- 예약/포인트/알림 로직을 별도 Service로 분리 → 단일 책임 원칙 강화 및 롤백 안정성 확보  
- (개선 아이디어) 트래픽 증가 시 DB **Isolation Level**을 `SERIALIZABLE`로 조정하거나,  
  **락(Lock) 기반 제어**를 적용해 Race Condition을 더 강력히 방어할 수 있음

```java
@Service
public class WaitingFacadeService {
    @Autowired private ReservationService reservationService;
    @Autowired private PointService pointService;
    @Autowired private WaitingOrderService waitingOrderService;
    @Autowired private WatingMapper watingMapper;

    @Transactional
    public List<WaitingDto> updateWatingList(WaitingDto waitingDto) {
        // 1. 상태 업데이트
        reservationService.updateStatus(waitingDto);

        // 2. 노쇼 포인트 차감
        if ("노쇼".equals(waitingDto.getStatus().trim())) {
            pointService.handleNoShow(waitingDto.getWaiting_idx());
        }

        // 3. 순번 재정렬
        int storeIdx = watingMapper.getStore_idxWaiting(waitingDto.getWaiting_idx());
        waitingOrderService.reorder(storeIdx);

        // 4. 최종 대기 리스트 반환
        return watingMapper.getWatingList(storeIdx);
    }
}
```
# Feature


## 사용자
### Login & Signup
|**회원가입**|**로그인**|
|---|---|
|![Image](https://github.com/user-attachments/assets/05cb1f0b-0757-4ac7-8c81-ca0ed6f72158)|![Image](https://github.com/user-attachments/assets/978f6dd9-4470-4ed4-b2e2-c3fb5e417658)|

### Main
|**Main**|
|---|
|<img src="https://github.com/user-attachments/assets/199ab9ab-32a4-4920-8717-371991de14b4" width="60%"/>|
***
### Main Detail
|**Main Detail**|
|---|
|<img src="https://github.com/user-attachments/assets/7c5382bb-57ce-4eda-bb96-008fc07c7f38" width="60%"/>|
***

|**Detail - Map**|**Detail - Review**|
|---|---|
|![Image](https://github.com/user-attachments/assets/3b0a539d-abb2-443d-9be0-dd22c1eab85f)|![Image](https://github.com/user-attachments/assets/a7c0ee5c-5f56-4a31-ae2e-eb4777a89ade)|
***

|**Datil - Review Detail**|**Detail - Review Write&Update**|
|---|---|
|![Image](https://github.com/user-attachments/assets/d824918c-d252-4be9-bae6-3999a5a75c4a)|![Image](https://github.com/user-attachments/assets/5f9b4eef-b835-48c9-9183-32cfde87c1d6)|
***

### Map
|**Main**|**Detail**|
|---|---|
|![Image](https://github.com/user-attachments/assets/6c1dc226-2013-4c27-9905-0d9a5617c1cc)|![Image](https://github.com/user-attachments/assets/bbe65d1f-5a6b-4197-95df-adaf18e4a227)|
***

### Profile
|**Profile**|
|---|
|<img src="https://github.com/user-attachments/assets/30845bc2-ae1e-4302-aa78-2c14b57b795a" width="600"/>|
***

|**Reservation**|**BookMark**|
|---|---|
|![Image](https://github.com/user-attachments/assets/d0ff9d89-0087-405a-b86a-a95c20e5ef4a)|![Image](https://github.com/user-attachments/assets/f2bdd54e-f0ae-4ab0-a0f8-4fc0285ea79b)|
***

|**Recommend**|**My Review**|
|---|---|
|![Image](https://github.com/user-attachments/assets/97d8117b-db7b-4f9e-9b04-022665817a66)|![Image](https://github.com/user-attachments/assets/0445a139-94bd-46f9-88f4-6ef0890f1d48)|
***

### Wallet(Rewards)
|**Wallet**|**Path**|**Path Detail**|
|---|---|---|
|![Image](https://github.com/user-attachments/assets/5fab1a3c-cec0-4f4f-8a45-01a2774eed00)|![Image](https://github.com/user-attachments/assets/a168599d-818e-44a8-9d55-b2e5328ec72b)|![Image](https://github.com/user-attachments/assets/00761942-f479-4274-a790-6a0764e5caa6)|
***


## 스토어 담당자
### Login & Signup
|**Login**|**Signup**|
|---|---|
|![Image](https://github.com/user-attachments/assets/99894606-583d-4fe2-b793-5d8dd355c275)|![Image](https://github.com/user-attachments/assets/67f16276-4e50-42e7-a2df-816b77cf7de1)|
***
### 운영
|**사전예약**|**현장문의**|
|---|---|
|![Image](https://github.com/user-attachments/assets/b5696692-657a-4227-97d0-a9ae62f13187)|![Image](https://github.com/user-attachments/assets/da2c27dd-13b5-4f34-ab8d-bfb9139043e9)|
***

|**현장예약대기**|
|---|
|![Image](https://github.com/user-attachments/assets/49f337d9-3b5f-451b-b8c0-8ff911808f77)|
***

|**예약**|**수정**|
|---|---|
|![Image](https://github.com/user-attachments/assets/761da38f-7d2d-42bb-8809-a6e072e4a086)|![Image](https://github.com/user-attachments/assets/ca0859e8-289e-49da-971e-b408ef0aee62)|
***

### 관리
|**스토어 내역**|
|---|
|![Image](https://github.com/user-attachments/assets/cf48c838-5b0b-4183-9448-5d3f69489fab)|
***

|**예약내역 확인 및 수정**|
|---|
|<img src="https://github.com/user-attachments/assets/36f45099-3cd3-4be1-890a-69e1734c812e" width="600"/>|
***

|**관리자 요청**|
|---|
|![Image](https://github.com/user-attachments/assets/3395d9fa-a076-4c09-ac32-affb4f3e1314)|
***
### 등록
|**등록**|**사전예약**|
|---|---|
|![Image](https://github.com/user-attachments/assets/2f8bd989-59d2-4e0c-9dd6-ee9ceeed25fe)|![Image](https://github.com/user-attachments/assets/87af3843-0cba-4751-82e4-20d358d09ad1)|
***


## 관리자
|**대시보드**|
|---|
|![Image](https://github.com/user-attachments/assets/37ed7ad2-6675-4ff2-bcab-bafef4069f9c)|

#### 스토어 관리
|**스토어관리**|
|---|
|![Image](https://github.com/user-attachments/assets/70c57867-2242-4551-85f8-6adc7dd0eb47)|
***

|**스토어 상세정보**|**스토어 수정**|
|---|---|
|![Image](https://github.com/user-attachments/assets/f790e729-298c-4f7a-a09d-849275e7f042)|![Image](https://github.com/user-attachments/assets/eaf9d3a8-3e87-4072-987a-6f9c922e431c)|
***

#### 스토어 담당자
|**스토어 담당자**|**스토어 담당자 상세**|
|---|---|
|![Image](https://github.com/user-attachments/assets/e8090b2e-88df-42b1-ad3a-ca5dc9829575)|![Image](https://github.com/user-attachments/assets/36345b18-333c-4e2e-9f70-9611fc63910e)|
***

#### 유저 관리
|**유저 리스트**|**유저 상세**|
|---|---|
|![Image](https://github.com/user-attachments/assets/a44619f9-de9e-4090-a62d-32ccfeb342d0)|![Image](https://github.com/user-attachments/assets/a35eb98e-7cca-4a73-9b65-e5c99721bd23)|
***

#### 배너관리
|**배너**|
|---|
|![Image](https://github.com/user-attachments/assets/571ebd94-ab7d-4b53-bafb-17068ece7b38)|
***

##모바일 UI
### 사용자
#### 로그인
|**Login**|**Sign**|
|---|---|
|![Image](https://github.com/user-attachments/assets/091ff576-c7b4-438f-80e3-728006171d09)|![Image](https://github.com/user-attachments/assets/2e649138-982b-4a71-aa7a-d69d6cd8e190)|
***

#### 메인화면
|**Main**|**info**|
|---|---|
|![Image](https://github.com/user-attachments/assets/88eb20ee-0973-4a98-9195-93f8d67a2cce)|![Image](https://github.com/user-attachments/assets/0c10a82e-3092-41a5-91d4-5bfbd4e31b01)|
***



|**Map**|**Review**|
|---|---|
|![Image](https://github.com/user-attachments/assets/8e496616-fd60-4717-be7f-de512a635b20)|![Image](https://github.com/user-attachments/assets/52002602-d7fa-4bf0-8acb-bc150e087eca)|

|**Review Detail**|**Review UPdate**|
|---|---|
|![Image](https://github.com/user-attachments/assets/5312167b-94bb-4332-b169-32aa79a1fa61)|![Image](https://github.com/user-attachments/assets/416b6a05-2c36-4c8a-86ef-a21840f57f16)|

|**Reservation**|**Reservation View**|
|---|---|
|![Image](https://github.com/user-attachments/assets/81107533-2cb1-4cf6-b54d-8ba769e25ebf)|![Image](https://github.com/user-attachments/assets/7f87c4c6-1866-4390-ab70-af0a7b122886)|
***
#### 맵
|**Map**|
|---|
|<img src="https://github.com/user-attachments/assets/0fc53480-99a2-4ba1-ad56-dd95e66bf10a" width="600"/>|
***

#### 예약확인
|**Reservation**|**Reservation Detail**|
|---|---|
|![Image](https://github.com/user-attachments/assets/9b294bc5-b6e8-4a56-915d-1bd2f5921abf)|![Image](https://github.com/user-attachments/assets/86670126-6f69-4dc4-9aca-f887d591cae0)|
***

#### 리워드
|**Reword**|**cos**|
|---|---|
|![Image](https://github.com/user-attachments/assets/c33e1d64-4f0b-451e-97c0-c094e7a13046)|![Image](https://github.com/user-attachments/assets/0632213e-da5b-44e3-9cdc-1b45469a0751)|
***

#### 프로필
|**Profuile**|**BookMark Popup**|
|---|---|
|![Image](https://github.com/user-attachments/assets/28a2593b-4c18-4c38-be8a-aa251dbb99a7)|![Image](https://github.com/user-attachments/assets/dad1546c-45ad-4319-bb74-1e2df86e2e84)|


# ERD
<img width="1473" height="727" alt="KakaoTalk_20250116_153133481" src="https://github.com/user-attachments/assets/278a23e7-7249-43b7-868f-7c2cf9ca2a6c" />
