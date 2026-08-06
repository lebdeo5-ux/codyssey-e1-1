#!/bin/bash

# 1. 환경 설정 및 로그 파일 준비
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/run_web_log.txt"

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
# 커스텀 Docker 이미지 빌드 및 포트 매핑 실습
# ---------------------------------------------------------

step "1. 기존 컨테이너 정리"
log_msg "-> 이전 실습의 잔여 컨테이너가 있다면 포트 충돌 방지를 위해 삭제합니다."
# TODO: 기존에 띄워둔 동일 이름의 컨테이너가 있다면 삭제하는 명령을 추가하세요.
docker rm -f my-web-8080 2>/dev/null
echo

step "2. 커스텀 Docker 이미지 빌드"
log_msg "-> ./web 폴더의 Dockerfile을 기반으로 이미지를 빌드합니다."
# TODO: 현재 폴더 하위의 'web' 디렉토리에 있는 Dockerfile을 사용해 'codyssey-custom-web:1.0' 이라는 이름으로 빌드하세요.
docker build -t codyssey-custom-web:1.0 ./web | tee -a "$LOG"
echo

step "3. 포트 매핑을 이용한 컨테이너 실행"
log_msg "-> 호스트의 8080 포트를 컨테이너의 80 포트와 연결하여 백그라운드에서 실행합니다."
# TODO: -d (백그라운드), -p (포트매핑 8080:80), --name (my-web-8080) 옵션을 넣어 컨테이너를 실행하세요.
docker run -d -p 8080:80 --name my-web-8080 codyssey-custom-web:1.0 | tee -a "$LOG"
echo

step "4. 로컬호스트 접속 테스트 (CLI)"
log_msg "-> curl 명령어로 웹 서버가 정상적으로 응답하는지 확인합니다."
sleep 2 # 컨테이너 내 웹서버가 구동될 시간을 잠시 대기합니다.
curl http://localhost:8080 | tee -a "$LOG"
echo

log_msg "=========================================="
log_msg "웹 서버 실행 완료! 로그가 $LOG 에 저장되었습니다."
log_msg "!! 중요: 브라우저를 열고 http://localhost:8080 에 접속하여 주소창이 포함된 스크린샷을 꼭 캡처하세요 !!"
log_msg "=========================================="