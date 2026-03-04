# Mini Deployment Pipeline (Docker + Bash + GitHub Actions)

![Shell](https://img.shields.io/badge/script-bash-blue)
![Docker](https://img.shields.io/badge/container-docker-blue)
![Runner](https://img.shields.io/badge/runner-self--hosted-orange)

이 프로젝트는 Docker 기반 애플리케이션을 자동 배포하고  
Health Check와 Rollback을 수행하는 간단한 CI/CD 파이프라인입니다.

GitHub Actions self-hosted runner를 사용하여

git push → 자동 배포 → 상태 검증 → 실패 시 Rollback

흐름을 직접 구현하며 DevOps 기본 개념을 학습한 프로젝트입니다.

---

# Architecture

```mermaid
flowchart TD

A[Developer git push] --> B[GitHub Repository]

B --> C[GitHub Actions]

C --> D[self-hosted runner]

D --> E[run_all.sh]

E --> F[deploy.sh Docker build]
F --> G[Docker Container run]

G --> H[health_check.sh]

H -->|success| I[version update]

H -->|fail| J[rollback.sh]

J --> K[previous container run]

D --> L[/opt/mini-deploy/state]

L --> M[config.env]
L --> N[version.txt]
L --> O[active_version.txt]
```

---

# Features

- Docker 기반 애플리케이션 자동 배포
- Health Check 기반 배포 성공 / 실패 판단
- 실패 시 이전 버전 컨테이너 자동 Rollback
- GitHub Actions self-hosted runner 기반 자동 실행
- 배포 파이프라인 로그 기록
- 버전 기반 컨테이너 관리
- runtime state directory 분리

---

# Pipeline Flow

```
Developer
   ↓ git push
GitHub
   ↓
GitHub Actions
   ↓
Self-hosted Runner
   ↓
run_all.sh
   ↓
deploy.sh (Docker build + run)
   ↓
health_check.sh
   ↓
success → version update
fail → rollback.sh
```

---

# Runtime State Directory

CI 실행 workspace와 runtime 상태 파일을 분리하기 위해  
다음 디렉토리를 사용합니다.

```
/opt/mini-deploy/state
```

여기에는 다음 파일이 저장됩니다.

```
config.env
version.txt
active_version.txt
```

| 파일 | 설명 |
|-----|------|
| config.env | 배포 환경 변수 설정 |
| version.txt | 다음 배포 버전 |
| active_version.txt | 현재 실행 중인 버전 |

이 구조를 통해 CI workspace와 runtime 상태를 분리했습니다.

---

# Project Structure

```
mini-deploy-pipeline
│
├ deploy.sh
├ rollback.sh
├ health_check.sh
├ run_all.sh
├ Dockerfile
├ index.html
│
└ .github/workflows
   └ workflow.yml
```

| 파일 | 설명 |
|-----|------|
| deploy.sh | Docker 이미지 빌드 및 컨테이너 배포 |
| health_check.sh | 서비스 정상 동작 확인 |
| rollback.sh | 이전 버전 컨테이너로 롤백 |
| run_all.sh | 전체 파이프라인 실행 |
| Dockerfile | nginx 기반 컨테이너 이미지 생성 |
| workflow.yml | GitHub Actions CI/CD 설정 |

---

# Deployment Process

배포 과정은 다음 단계로 진행됩니다.

1. Docker 이미지 빌드
2. 기존 컨테이너 중지 및 제거
3. 새로운 버전 컨테이너 실행
4. Health Check 수행
5. 실패 시 이전 버전 Rollback

---

# Development Environment

| Component | Description |
|---|---|
OS | Rocky Linux |
Shell | Bash |
Container | Docker |
Web Server | Nginx |
CI/CD | GitHub Actions |
Runner | self-hosted runner |

---

# Future Improvements

- Docker Registry 기반 이미지 관리
- Blue-Green 배포 전략 적용
- Slack / Discord 배포 알림
- GitHub hosted runner 지원

---

# Summary

이 프로젝트는 DevOps 배포 파이프라인의 핵심 흐름인

자동 배포  
서비스 검증  
실패 대응 (Rollback)  
CI/CD 자동화  

구조를 Docker와 GitHub Actions 기반으로 구현한 실습 프로젝트입니다.
