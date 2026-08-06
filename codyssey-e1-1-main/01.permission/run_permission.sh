#!/bin/bash

# 1. 환경 설정 및 로그 파일 준비
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/permission_log.txt"

rm -f "$LOG"
cd "$BASE" || { echo "오류: 경로 접근 실패"; exit 1; }

# 색상 정의
GREEN='\033[1;32m'
CYAN='\033[1;36m'
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
# 본격적인 실습 시작
# ---------------------------------------------------------

step "1. 실습용 파일 및 디렉토리 생성"
DIR_NAME="perm_test_dir"
FILE_NAME="perm_test_file.txt"

# TODO: mkdir과 touch를 이용해 디렉토리와 파일을 생성하세요.
mkdir -p "$DIR_NAME"
touch "$FILE_NAME"
log_msg "-> '$DIR_NAME' 디렉토리와 '$FILE_NAME' 파일이 생성되었습니다."
echo

step "2. 권한 변경 전 초기 상태 확인"
# macOS 터미널에서 권한을 확인하기 위해 'ls -l' (또는 디렉토리의 경우 'ls -ld')를 사용합니다.
log_msg "[변경 전 권한]"
ls -ld "$DIR_NAME" | tee -a "$LOG"
ls -l "$FILE_NAME" | tee -a "$LOG"
echo

step "3. chmod를 이용한 권한 변경 실습"
# TODO: chmod 명령어를 사용하여 권한을 변경해 보세요. 
# 예: 디렉토리는 755(또는 700), 파일은 644(또는 600) 등
log_msg "-> 디렉토리 권한을 755로, 파일 권한을 644로 변경합니다."
chmod 755 "$DIR_NAME"
chmod 644 "$FILE_NAME"
echo

step "4. 권한 변경 후 상태 비교"
# 요구사항에 맞춰 변경 전/후를 비교하기 위해 다시 한번 상태를 출력합니다.
log_msg "[변경 후 권한]"
ls -ld "$DIR_NAME" | tee -a "$LOG"
ls -l "$FILE_NAME" | tee -a "$LOG"
echo

log_msg "=========================================="
log_msg "권한 실습 완료! 로그가 $LOG 에 저장되었습니다."
log_msg "이 로그 결과를 복사하여 README.md의 터미널 조작 로그 기록에 첨부하세요."
log_msg "=========================================="