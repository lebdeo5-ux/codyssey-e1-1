#!/bin/bash

# 1. 환경 설정 및 로그 파일 준비
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/git_test_log.txt"

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
# Git 기본 설정 및 로그 기록
# ---------------------------------------------------------

step "1. Git 사용자 정보 설정"
log_msg "-> Git 커밋에 기록될 사용자 이름을 설정합니다."
git config --global user.name "Noh Jung-woo" | tee -a "$LOG"

# 이메일은 터미널에서 직접 입력받도록 구성
printf "${CYAN}GitHub에 등록된 이메일 주소를 입력하세요: ${RESET}"
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL" | tee -a "$LOG"
echo

step "2. Git 기본 브랜치명 설정"
log_msg "-> 기본 브랜치명을 'main'으로 설정합니다."
git config --global init.defaultBranch main | tee -a "$LOG"
echo

step "3. Git 설정 확인 (마스킹 주의 구역)"
log_msg "-> 현재 적용된 Git 설정 목록을 확인합니다."
log_msg "${YELLOW}🚨 주의: 기술 문서에 이 결과를 복사할 때, 이메일이나 토큰 등 민감한 정보는 반드시 *** 처리하여 마스킹하세요!${RESET}"
git config --list | grep -E 'user|init' | tee -a "$LOG"
echo

log_msg "=========================================="
log_msg "Git 기본 설정 완료! 로그가 $LOG 에 저장되었습니다."
log_msg "=========================================="