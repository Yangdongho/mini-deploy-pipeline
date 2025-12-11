# Mini Deployment Pipeline (Shell Script + Nginx)
![Shell](https://img.shields.io/badge/script-bash-blue) ![Nginx](https://img.shields.io/badge/server-nginx-green) ![Status](https://img.shields.io/badge/pipeline-manual-lightgrey)

이 프로젝트는 Shell Script 기반으로 HTML 파일을 원격 서버에 자동 배포하고, nginx 재시작과 Health Check까지 수행하는 간단한 배포 파이프라인입니다. DevOps 기본 개념인 배포 / 검증 / 로그 / 파이프라인 제어 흐름을 직접 구현하며 학습한 기록입니다.

## Features
- 원격 서버 자동 배포(scp)
- nginx 자동 재시작(systemctl)
- Health Check 기반 배포 성공/실패 판별
- exit code 기반 파이프라인 제어
- 파이프라인 전체 로그 저장 (pipeline.log)
- run_all.sh 한 번으로 전체 프로세스 실행

## Pipeline Flow
index.html 수정  
      ↓  
deploy.sh (배포)  
      ↓  
health_check.sh (검증)  
      ↓  
run_all.sh (전체 파이프라인 실행 + 로그 저장)

## Project Structure
deploy.sh : 배포 스크립트  
health_check.sh : 헬스체크 스크립트  
run_all.sh : 전체 파이프라인 실행 + 로그  
index.html : 배포 대상 파일  
pipeline.log : 실행 로그  

## Usage
1) 실행 권한 부여  
chmod +x deploy.sh health_check.sh run_all.sh  

2) 배포 대상 파일 작성  
echo "hello dongho" > index.html  

3) 전체 파이프라인 실행  
./run_all.sh  

4) 로그 확인  
cat pipeline.log  

## Failure Test (학습용)
1) SRC_FILE 경로 오류 → Deploy FAILED  
2) index.html에 "dongho" 문자열이 없을 경우 → HealthCheck FAILED  

## Development Environment
- OS: Rocky Linux 8 (테스트 환경)  
- Shell: Bash 4.x  
- Web Server: Nginx 1.x  
- SSH 활성화된 원격 서버 사용  
- Git을 이용한 버전 관리  

## Future Improvements
- 배포 실패 시 이전 버전으로 자동 복구하는 롤백 기능 추가  
- GitHub Actions를 이용한 CI/CD 자동화 파이프라인 구성  
- Docker 기반 컨테이너 환경으로 확장하여 배포 구조 개선  
- version.txt를 이용한 자동 버전 관리 기능 도입  
- 배포 완료 후 Slack 또는 이메일 알림 기능 추가  

## Summary
이 프
