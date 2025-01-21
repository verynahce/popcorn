 const swiper = new Swiper('.swiper-container', {
    slidesPerView: 1, // 화면에 이미지 두 개 표시
    spaceBetween: 0,  // 이미지 간 여백 없음
    slidesPerGroup: 1, // 한 번에 한 장씩 슬라이드 이동
    loop: true, // 무한 루프
    navigation: {
      nextEl: '.swiper-button-next', // 다음 버튼
      prevEl: '.swiper-button-prev', // 이전 버튼
    },
    autoplay: {
      delay: 5000, // 3초마다 자동 슬라이드
    },
  });




 function clipboard() {
     var text = window.location.href;
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