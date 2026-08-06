#!/bin/bash

# 환경 설정
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/cli_Log.txt"

# 초기화
rm -f "$LOG"
cd "$BASE" || { echo "오류: 경로 접근 실패"; exit 1; }

# 색상 정의
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

# 핵심 함수
step() {
    clear  
    echo -e "${GREEN}==========================================${RESET}"
    echo -e "${GREEN} STEP: $1 ${RESET}"
    echo -e "${GREEN}==========================================${RESET}"
}

log_msg() {
    echo -e "$1" | tee -a "$LOG"
}

# 1. 시작하기 & 2. 시스템 정보 (기존과 동일)
step "시작하기"
log_msg "사용자 맞춤형 CLI 실습을 시작합니다."
echo
printf "${YELLOW}엔터를 누르면 시스템 정보를 확인합니다...${RESET}"
read

step "시스템 정보 확인"
{
    echo "조회 시간: $(date)"
    echo "현재 사용자: $(whoami)"
    echo "현재 위치: $(pwd)"
    echo "OS 버전: $(sw_vers -productVersion)"
    echo "사용 중인 쉘: $(basename "$SHELL")"
    echo "Git 버전: $(git --version)"
    echo "Docker 버전: $(docker --version 2>/dev/null || echo 'Docker 미설치')"
} | tee -a "$LOG"
echo
printf "${YELLOW}엔터를 누르면 직접 폴더와 파일을 만들러 이동합니다...${RESET}"
read

# 3. 디렉토리 및 파일 생성 실습 (수정된 부분!)
step "파일 시스템 실습 (사용자 정의)"

# [폴더 이름 입력]
printf "${CYAN}1. 생성할 폴더 이름을 입력하세요: ${RESET}"
read DIR_NAME
# 만약 아무것도 입력하지 않으면 기본값 'my_folder' 사용
DIR_NAME=${DIR_NAME:-my_folder}

log_msg "-> '$DIR_NAME' 폴더를 생성합니다."
mkdir -p "$DIR_NAME"

# [파일 이름 입력]
printf "${CYAN}2. 생성할 파일 이름을 입력하세요 (예: test.txt): ${RESET}"
read FILE_NAME
# 만약 아무것도 입력하지 않으면 기본값 'result.txt' 사용
FILE_NAME=${FILE_NAME:-result.txt}

# 파일 내용 입력
printf "${CYAN}3. 파일에 저장할 내용을 입력해주세요: ${RESET}"
read USER_INPUT

# 입력받은 내용을 사용자 정의 파일로 저장
echo "$USER_INPUT" > "$DIR_NAME/$FILE_NAME"
log_msg "-> '$DIR_NAME/$FILE_NAME' 파일이 성공적으로 생성되었습니다."

echo
printf "${YELLOW}엔터를 누르면 최종 결과를 확인합니다...${RESET}"
read

# 결과 확인
echo
log_msg "=========================================="
log_msg "실습 완료! 당신이 만든 폴더: $DIR_NAME"
log_msg "실습 완료! 당신이 만든 파일: $FILE_NAME"
log_msg "=========================================="

step "최종 파일 생성 결과 확인"
ls -R "$DIR_NAME" 

echo
log_msg "파일 내용 확인 "
cat "$DIR_NAME/$FILE_NAME" | tee -a "$LOG"