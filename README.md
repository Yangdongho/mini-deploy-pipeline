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
2) index.html에 "dongho" 없음 → HealthCheck FAILED  

## Future Improvements
- rollback 구조 추가  
- GitHub Actions CI 도입  
- Docker/Kubernetes 기반 확장  

## Summary
이 프로젝트는 DevOps의 핵심 흐름인 "배포 자동화 → 검증 → 로그 → 파이프라인 제어" 기능을 Shell Script만으로 직접 구현한 실습 프로젝트입니다. 작지만 CI/CD 이해의 기반이 되는 구조를 직접 체득하기 위한 학습용 레포지토리입니다.
