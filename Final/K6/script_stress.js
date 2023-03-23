import http from "k6/http";
import { sleep } from "k6";

export const options = {
    scenarios: {
        stress: {
            executor: "ramping-arrival-rate",
            preAllocatedVUs: 1000,
            timeUnit: "1s",
            stages: [
                { duration: "2m", target: 30 },
                { duration: "5m", target: 30 },
                { duration: "2m", target: 40 },
                { duration: "5m", target: 40 },
                { duration: "2m", target: 50 },
                { duration: "5m", target: 50 },
                { duration: "2m", target: 60 },
                { duration: "5m", target: 60 },
                { duration: "10m", target: 0 },
            ],
        },
    },
};

export default function () {
    const BASE_URL = "http://kimdoliving.com.s3-website.ap-northeast-2.amazonaws.com";
    const responses = http.batch([
        ["GET", `${BASE_URL}/index.html`],
    ]);
}
