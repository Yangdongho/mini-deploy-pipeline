# Monitoring Test - Blue-Green 장애 및 복구 검증

## 구성

Client
→ nginx-proxy:8080
→ py-backend-blue / py-backend-green

Docker containers
→ cAdvisor
→ Prometheus
→ Grafana Dashboard

## 테스트 흐름

정상 상태
→ nginx-proxy Up
→ py-backend-blue Up (healthy)
→ py-backend-green Up (healthy)
→ Grafana에서 CPU / Memory / Network 메트릭 수집 확인

장애 재현
→ active backend인 py-backend-green 중지
→ docker stop py-backend-green

장애 결과
→ nginx-proxy는 살아있음
→ upstream 대상인 green backend는 중지됨
→ curl localhost:8080 요청 시 502 Bad Gateway 발생
→ Grafana에서 py-backend-green 메트릭 감소 / 단절 확인

복구 진행
→ switch.sh로 nginx upstream을 blue backend로 전환
→ cd /root/deploy-test
→ ./switch.sh blue

복구 결과
→ curl localhost:8080
→ Flask Backend Blue 응답 확인
→ 서비스가 blue backend 기준으로 정상 복구됨

green 재기동
→ docker start py-backend-green
→ py-backend-green Up (healthy) 상태 복귀
→ Grafana에서 green 메트릭 재수집 확인

## 정리

active backend 장애
→ nginx upstream 대상 없음
→ 502 Bad Gateway 발생
→ Grafana에서 메트릭 단절 확인
→ switch.sh로 blue 전환
→ 서비스 복구 검증

이번 테스트를 통해 nginx 컨테이너가 살아있어도 upstream backend 장애 시 서비스 장애가 발생할 수 있음을 확인했다. 또한 Prometheus / cAdvisor / Grafana를 통해 컨테이너 장애와 복구 흐름을 관측할 수 있었다.
