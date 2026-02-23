# Mini Deployment Pipeline (Shell Script + Nginx + GitHub Actions)
![Shell](https://img.shields.io/badge/script-bash-blue) 
![Nginx](https://img.shields.io/badge/server-nginx-green) 
![Runner](https://img.shields.io/badge/runner-self--hosted-orange)

이 프로젝트는 Shell Script 기반으로 HTML 파일을 원격 서버에 자동 배포하고, nginx 재시작과 Health Check, Rollback까지 수행하는 간단한 배포 파이프라인입니다.  
DevOps 기본 개념인 배포 / 검증 / 로그 / 실패 대응 흐름을 직접 구현하며 학습한 기록입니다.

---

## Features
- 원격 서버 자동 배포 (scp)
- nginx 자동 재시작 (systemctl)
- Health Check 기반 배포 성공/실패 판별
- 배포 실패 시 이전 버전 자동 복구 (rollback)
- SSH key 기반 비대화형 배포
- exit code 기반 파이프라인 제어
- 파이프라인 전체 로그 저장 (pipeline.log)
- GitHub Actions self-hosted runner 기반 자동 실행

---

## Pipeline Flow
git push  
      ↓  
GitHub Actions  
      ↓  
self-hosted runner  
      ↓  
run_all.sh (전체 파이프라인 실행 + 로그 저장)  
      ↓  
deploy.sh (배포 + 백업)  
      ↓  
health_check.sh (검증)  
      ↓  
실패 시 rollback.sh 실행  

---

## Project Structure
deploy.sh : 배포 스크립트  
health_check.sh : 헬스체크 스크립트  
rollback.sh : 배포 실패 시 이전 버전 복구  
run_all.sh : 전체 파이프라인 실행 + 로그  
config.env : 환경 변수 설정  
index.html : 배포 대상 파일  
pipeline.log : 실행 로그  
version.txt : 버전 관리 파일  

---

## Usage
1) 실행 권한 부여  
chmod +x deploy.sh health_check.sh rollback.sh run_all.sh  

2) 배포 대상 파일 작성  
echo "hello dongho" > index.html  

3) 전체 파이프라인 실행  
./run_all.sh  

4) 로그 확인  
cat pipeline.log  

---

## Failure Test (학습용)
1) SRC_FILE 경로 오류 → Deploy FAILED → Rollback 실행  
2) index.html에 Health keyword가 없을 경우 → HealthCheck FAILED → Rollback 실행  

Rollback 동작 방식:
index.html → index.html.bak 백업  
실패 시 → index.html.bak 복구 후 nginx 재시작  

---

## Development Environment
- OS: Rocky Linux (테스트 환경)  
- Shell: Bash 4.x  
- Web Server: Nginx  
- GitHub Actions (self-hosted runner)  
- SSH 활성화된 원격 서버 사용  
- Git을 이용한 버전 관리  

---

## Future Improvements
- Docker 기반 배포 환경 구성
- GitHub Actions 기반 배포 흐름 정리
- 간단한 버전 관리 방식 추가

---

## Summary
이 프로젝트는 DevOps의 핵심 흐름인  
"배포 자동화 → 검증 → 실패 대응 → 로그 관리"  
구조를 Shell Script와 GitHub Actions 기반으로 구현한 실습 프로젝트입니다.
