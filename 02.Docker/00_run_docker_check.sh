#!/bin/bash

# 1. 환경 설정 및 로그 파일 준비
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/docker_check_log.txt"

rm -f "$LOG"
cd "$BASE" || { echo "오류: 경로 접근 실패"; exit 1; }

# 색상 정의
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

log_msg() {
    echo -e "$1" | tee -a "$LOG"
}

step() {
    echo -e "${GREEN}==========================================${RESET}"
    echo -e "${GREEN} STEP: $1 ${RESET}"
    echo -e "${GREEN}==========================================${RESET}" | tee -a "$LOG"
}

# ---------------------------------------------------------
# Docker 점검 실습 시작
# ---------------------------------------------------------

step "1. Docker 설치 및 데몬 상태 점검"
log_msg "-> Docker 버전을 확인합니다."
docker --version | tee -a "$LOG"
echo
log_msg "-> Docker 데몬(시스템) 상태를 요약 출력합니다."
docker info | tee -a "$LOG"
echo

step "2. 기본 컨테이너 실행 테스트 (hello-world)"
log_msg "-> hello-world 이미지를 다운받고 실행합니다."
docker run hello-world | tee -a "$LOG"
echo

step "3. Docker 기본 운영 명령 (이미지 및 프로세스 확인)"
log_msg "-> 현재 다운로드된 Docker 이미지 목록을 확인합니다."
docker images | tee -a "$LOG"
echo
log_msg "-> 실행 중이거나 종료된 모든 컨테이너 목록을 확인합니다."
docker ps -a | tee -a "$LOG"
echo

step "4. Ubuntu 컨테이너 실행 및 내부 진입 실습"
log_msg "-> ubuntu 컨테이너를 백그라운드에서 실행 상태로 유지합니다."
# -dit 옵션: 백그라운드(-d)에서 터미널 입력(-it)을 대기하며 실행 유지
docker run -dit --name ubuntu-cli-test ubuntu bash | tee -a "$LOG"

log_msg "-> 실행 중인 ubuntu 컨테이너 내부에 명령(ls, pwd)을 전달합니다."
docker exec ubuntu-cli-test bash -c "ls -la && pwd" | tee -a "$LOG"
echo

step "5. 컨테이너 리소스 모니터링 (stats) 및 종료"
log_msg "-> ubuntu-cli-test 컨테이너의 자원 사용량을 확인합니다."
# --no-stream 옵션은 실시간 갱신을 막고 1회만 출력하게 해줍니다.
docker stats --no-stream ubuntu-cli-test | tee -a "$LOG"
echo
log_msg "-> 테스트가 끝난 컨테이너를 강제 삭제합니다."
docker rm -f ubuntu-cli-test | tee -a "$LOG"

log_msg "=========================================="
log_msg "Docker 기본 점검 완료! 로그가 $LOG 에 저장되었습니다."
log_msg "=========================================="
