import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    // Test configuration
    stages: [
        { duration: '30s', target: 20 },  // Ramp up to 20 users over 30 seconds
        { duration: '1m', target: 20 },   // Stay at 20 users for 1 minute
        { duration: '30s', target: 0 },   // Ramp down to 0 users over 30 seconds
    ],
    thresholds: {
        // Set thresholds for metrics
        http_req_duration: ['p(95)<500'], // 95% of requests should be below 500ms
        http_req_failed: ['rate<0.01'],   // Less than 1% of requests should fail
    },
};

export default function () {
    // Replace this URL with your actual test target
    const response = http.get('https://news.ycombinator.com');

    // Add checks that will appear in the dashboard
    check(response, {
        'is status 200': (r) => r.status === 200,
        'body contains title': (r) => r.body.includes('title'),
    });

    // Random sleep between requests (1-5 seconds)
    sleep(Math.random() * 4 + 1);
}