import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
stages: [
    { duration: '60', target: 1000},
    // vuser 1000 을 60초동안 생성 (램프업)
    { duration: '2m30s', target: 100},
    // vuser 100명이 2분30초 동안 로드를 주입
    { duration: '60', target: 0},
    // vuser가 0명이 되도록 40초 동안 램프 백 다운
 ],
};

export default function () {
    http.get('http://kimdoliving.com.s3-website.ap-northeast-2.amazonaws.com/');
    // kimdoliving.com 실제 구현 시 http.get('   ') 이 부분에 사용하는 도메인 넣어야함. 
    sleep('15');
    // 실행 지연 10초
}