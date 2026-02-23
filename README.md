# Mini Deployment Pipeline

![Shell](https://img.shields.io/badge/script-bash-blue)
![Nginx](https://img.shields.io/badge/server-nginx-green)
![Runner](https://img.shields.io/badge/runner-self--hosted-orange)

Shell Script 기반으로 정적 HTML 파일을 원격 서버에 배포하고  
nginx 재시작 및 Health Check를 수행하는 간단한 배포 파이프라인입니다.  

GitHub Actions self-hosted runner 환경에서 동작하도록 구성했습니다.

---

## Features

- scp를 이용한 원격 서버 배포
- nginx 자동 재시작
- Health Check 기반 배포 검증
- 배포 실패 시 이전 버전 자동 복구 (rollback)
- SSH key 기반 비대화형 배포
- exit code 기반 파이프라인 제어
- 실행 로그 저장 (pipeline.log)

---

## Pipeline Flow

```
git push
  ↓
GitHub Actions
  ↓
self-hosted runner
  ↓
run_all.sh
  ├─ deploy.sh
  │   ├─ 기존 파일 백업 (.bak)
  │   ├─ 파일 배포
  │   └─ nginx restart
  ↓
health_check.sh
  ├─ 성공 → 종료
  └─ 실패 → rollback.sh 실행
            ├─ 백업 파일 복구
            └─ nginx restart
```

---

## Project Structure

deploy.sh        : 배포 스크립트  
health_check.sh  : 헬스 체크  
rollback.sh      : 배포 실패 시 복구  
run_all.sh       : 전체 파이프라인 제어  
config.env       : 환경 변수 설정  
index.html       : 배포 대상 파일  
pipeline.log     : 실행 로그  
version.txt      : 버전 파일  

---

## Usage

실행 권한 부여:

```bash
chmod +x deploy.sh health_check.sh rollback.sh run_all.sh
```

전체 실행:

```bash
./run_all.sh
```

로그 확인:

```bash
cat pipeline.log
```

---

## Rollback 방식

배포 전에 기존 파일을 `.bak`으로 백업합니다.  
Health Check 실패 시 해당 백업 파일로 복구한 뒤 nginx를 재시작합니다.

---

## Environment

- Rocky Linux
- Bash 4.x
- Nginx
- GitHub Actions (self-hosted runner)
- SSH 기반 원격 서버

---

## 개선 예정

- 환경 분리 (dev / prod)
- Docker 기반 배포
- Blue-Green 방식 적용
- 배포 알림 기능
