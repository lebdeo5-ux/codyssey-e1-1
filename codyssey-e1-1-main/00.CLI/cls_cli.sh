#!/bin/bash

# 1. 환경 설정
BASE="$(cd "$(dirname "$0")" && pwd -P)"
MY_NAME=$(basename "$0")      # 이 파일의 이름 (clean.sh)
RUN_SCRIPT="run_cli.sh"       # 보존할 실행 파일 이름 (본인의 파일명에 맞게 수정하세요)

# 색상 정의
RED='\033[1;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

cd "$BASE" || exit 1

echo -e "${YELLOW}정리를 시작합니다...${RESET}"

# 2. 삭제
# 현재 폴더의 모든 파일/폴더를 하나씩 체크
for item in *; do
    if [[ "$item" == "$MY_NAME" || "$item" == "$RUN_SCRIPT" ]]; then
        continue
    fi

    # 나머지는 삭제
    rm -rf "$item"
    echo -e "${RED}[삭제됨]${RESET} $item"
done

echo -e "${YELLOW}==========================================${RESET}"
echo -e "남은 파일: $(ls | tr '\n' ' ')"
echo -e "${YELLOW}정리가 완료되었습니다!${RESET}"