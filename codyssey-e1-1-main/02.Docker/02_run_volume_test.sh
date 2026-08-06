#!/bin/bash

# 1. 환경 설정 및 로그 파일 준비
BASE="$(cd "$(dirname "$0")" && pwd -P)"
LOG="$BASE/volume_test_log.txt"

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
# Docker 볼륨 데이터 영속성 검증 실습
# ---------------------------------------------------------

step "1. 테스트용 사전 정리 및 Docker 볼륨 생성"
log_msg "-> 기존 동일 테스트 컨테이너 삭제 및 볼륨 재생성"
docker rm -f vol-test vol-test2 2>/dev/null
docker volume rm codyssey-data 2>/dev/null

log_msg "-> 'codyssey-data' 볼륨 생성"
docker volume create codyssey-data | tee -a "$LOG"
docker volume ls | grep codyssey-data | tee -a "$LOG"
echo

step "2. 첫 번째 컨테이너 생성 및 볼륨 마운트 후 데이터 쓰기"
log_msg "-> 'vol-test' 컨테이너에 'codyssey-data' 볼륨을 /data 경로로 연결합니다."
docker run -d --name vol-test -v codyssey-data:/data ubuntu sleep infinity | tee -a "$LOG"

log_msg "-> 컨테이너 내부 /data/hello.txt 에 데이터 기록 및 확인"
docker exec vol-test bash -lc "echo 'Hello Codyssey Volume Data!' > /data/hello.txt && cat /data/hello.txt" | tee -a "$LOG"
echo

step "3. 첫 번째 컨테이너 삭제 (데이터 보존 여부 검증)"
log_msg "-> 데이터가 작성된 'vol-test' 컨테이너를 완전 강제 삭제합니다."
docker rm -f vol-test | tee -a "$LOG"
log_msg "-> 삭제 후 컨테이너 상태 확인:"
docker ps -a | grep vol-test || log_msg "vol-test 컨테이너가 정상 삭제되었습니다."
echo

step "4. 두 번째 컨테이너 생성 후 동일 볼륨 연결 및 데이터 복원 확인"
log_msg "-> 새로운 'vol-test2' 컨테이너에 동일한 'codyssey-data' 볼륨을 연결합니다."
docker run -d --name vol-test2 -v codyssey-data:/data ubuntu sleep infinity | tee -a "$LOG"

log_msg "-> 'vol-test2' 내부에서 기존 데이터가 유지되는지 조회합니다."
docker exec vol-test2 bash -lc "cat /data/hello.txt" | tee -a "$LOG"
echo

step "5. 실습 완료 및 정리"
log_msg "-> 테스트용 컨테이너 지우기 (볼륨은 유지 가능)"
docker rm -f vol-test2 | tee -a "$LOG"

log_msg "=========================================="
log_msg "볼륨 데이터 영속성 검증 완료! 로그가 $LOG 에 저장되었습니다."
log_msg "=========================================="