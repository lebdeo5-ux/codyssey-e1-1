# 개발 환경 구축 미션
터미널, Docker, Git/GitHub를 활용하여 개발 워크스테이션 환경을 직접 구성하고, 그 과정과 결과를 기술 문서 형태로 정리.

1번 미션에서는 다음 항목을 중심으로 작업을 진행.

- 터미널로 작업 디렉토리 및 파일을 다루는 기본 조작 수행.
- 파일과 디렉토리의 권한 확인 및 변경 실습.
- Docker 설치 및 데몬 동작 여부 점검.
- hello-world 및 ubuntu 컨테이너 실행과 기본 운영 명령 확인.
- Dockerfile 기반 커스텀 이미지 제작.
- 포트 매핑을 통한 브라우저 접속 확인.
- 바인드 마운트로 호스트 변경 사항이 컨테이너에 즉시 반영되는지 검증.
- Docker 볼륨을 이용한 데이터 영속성 확인.
- Git 사용자 설정 및 원격 저장소 연결 상태 확인.
# 실행 환경
- OS: macOS
- Shell: zsh
- Terminal: iTerm2 또는 macOS Terminal
- Docker: OrbStack 기반 Docker 환경 사용
- Git: 로컬 Git 설치 환경 사용
# 버전 확인 명령어
'''
sw_vers -productVersion
echo "$(basename "${SHELL:-unknown}")"
git --version
'''

# 도커 버전 확인 - drbstack 실행 후
'''
docker --version
'''

# 버전 확인 명령어 결과물
'''
15.7.4
zsh
git version 2.53.0
Docker version 28.5.2, build ecc6942
'''
