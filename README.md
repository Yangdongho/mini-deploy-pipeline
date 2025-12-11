# Mini Deployment Pipeline (Shell Script + Nginx)
이 프로젝트는 Shell Script 기반으로 HTML 파일을 원격 서버에 자동 배포하고, nginx 재시작과 Health Check까지 수행하는 간단한 배포 파이프라인입니다. DevOps 기본 개념인 배포 / 검증 / 로그 / 파이프라인 제어 흐름을 직접 구현하며 실습한 기록입니다.

## Features
- 원격 서버 자동 배포(scp)
- nginx 자동 재시작(systemctl)
- Health Check 기반 배포 성공/실패 판별
- exit code 기반 파이프라인 제어
- 파이프라인 전체 로그 저장 (pipeline.log)
- run_all.sh 한 번으로 전체 프로세스 실행

## Project Structure
deploy.sh : 배포 스크립트  
health_check.sh : 헬스체크 스크립트  
run_all.sh : 전체 파이프라인 실행 + 로그  
index.html : 배포 대상 파일  
pipeline.log : 실행 로그  

## Environment
Linux 계열 (Rocky / CentOS / OEL)  
nginx  
SSH 접속 가능한 서버 1대  
Shell Script (bash)  
nginx 기본 문서 루트: /usr/share/nginx/html/

## Script Roles
deploy.sh 는 index.html 을 원격 서버로 복사(scp)하고 nginx 를 재시작합니다. 성공 시 exit 0, 실패 시 exit 1 을 반환합니다.  
health_check.sh 는 curl 로 페이지를 가져와 특정 문자열(dongho) 포함 여부를 검사합니다. 포함 시 success, 미포함 시 failed 를 출력하며 exit 0 또는 exit 1을 반환합니다.  
run_all.sh 는 deploy → health_check 순서로 전체 파이프라인을 실행하고 stdout, stderr 을 pipeline.log 에 기록합니다. 배포 또는 헬스체크 실패 시 즉시 종료하고 성공 시 최종 성공 메시지를 출력합니다.

## Usage
실행 권한 부여  
chmod +x deploy.sh health_check.sh run_all.sh  

배포 대상 파일 작성  
echo "hello dongho" > index.html  

전체 파이프라인 실행  
./run_all.sh  

로그 확인  
cat pipeline.log  

## Failure Test (학습용)
1) SRC_FILE 경로를 잘못 설정하면 scp 오류가 발생하며 Deploy FAILED 로 종료됩니다.  
2) index.html 에 dongho 문자열이 없으면 HealthCheck FAILED 로 종료됩니다.

## Future Improvements
- rollback.sh 구성 (배포 실패 시 자동 복구)  
- GitHub Actions 기반 CI/CD 자동화  
- Docker/Kubernetes 기반 배포 확장  
- version.txt 기반 자동 버전 관리  

## Summary
이 프로젝트는 DevOps 핵심 흐름(배포 자동화 → 검증 → 로그 → 파이프라인 제어)을 Shell Script만으로 직접 구현한 미니 CI/CD 실습 프로젝트입니다. 학습용으로 적합하며, 이후 GitHub Actions 또는 Jenkins로 확장하여 CI/CD를 직접 구축하는 기반이 됩니다.

