# 개발 환경 구축 미션
# 1. 프로젝트 개요
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
# 2. 실행 환경
- OS: macOS
- Shell: zsh
- Terminal: iTerm2 또는 macOS Terminal
- Docker: OrbStack 기반 Docker 환경 사용
- Git: 로컬 Git 설치 환경 사용

# 3. 버전 확인 명령어
```bash
sw_vers -productVersion #OS 버전 확인
echo "$(basename "${SHELL:-unknown}")" #실행 쉘
git --version # 깃 버전
```

도커 버전 확인 - Orbstack 실행 후
```bash
docker --version  # 도커 버전
```

버전 확인 명령어 결과물
```bash
15.7.4
zsh
git version 2.53.0
Docker version 28.5.2, build ecc6942
```
> 기본적인 환경은 코디세이 센터 내 캐빈 환경을 기본으로 함. `orbstack` 환경을 기본으로함.

# 4. 프로젝트 구조
```bash
.
├── 00_cli
│   └── cls_cli.sh
│   └── run_cli.sh
├── 01_permission
│   └── run_permission.sh
├── 02_docker
│   ├── 00_run_docker_check.sh
│   ├── 01_run_web.sh
│   ├── 02_run_volume_test.sh
│   └── web
│       ├── Dockerfile
│       └── site
│           └── index.html
└── 03_github
    └── run_git.sh
```

# 4-1. 디렉토리 구조 구성 기준
프로젝트 디렉토리는 실습 주제별 분리, 재현 가능성, 로그 추적 용이성을 기준으로 구성.

00,,,03 디렉토리는 과제의 핵심 실습 단위를 기준으로 분리.
각 디렉토리에는 해당 단계만 실행할 수 있는 run_***.sh 스크립트를 두어, 특정 단계만 개별적으로 재실행할 수 있도록 구성.

# 5. 실행 방법
# 5-1. 스크립트 실행방법
각 단계는 개별 실행이 가능하도록 구성.
필요한 스크립트에 실행 권한을 부여한 뒤, 원하는 단계만 직접 실행하여 결과를 확인.

예시:
```bash
chmod +x 00_cli/run_cli.sh
./00_cli/run_cli.sh
```
# 5-2. 포트 및 볼륨 실습을 재현 가능하게 구성한 방식
이번 과제에서는 포트 매핑과 볼륨 테스트를 단순히 수동으로 한 번 실행하는 것이 아니라, 같은 명령을 다시 실행해도 같은 결과를 얻을 수 있도록 스크립트 기반으로 정리.

포트 매핑 실습은 01_run_web.sh 안에서 이미지 빌드 → 컨테이너 실행 → curl 확인 순서로 고정.
같은 이름의 컨테이너가 이미 존재할 수 있으므로, 실행 전에 docker rm -f ... >/dev/null 2>&1 형태로 기존 테스트 컨테이너를 정리하도록 구성.

바인드 마운트 실습은 호스트의 site/index.html 을 수정하고, 같은 주소에 다시 curl 하여 변경 사항이 즉시 반영되는지 확인하는 방식으로 재현 가능하게 구성.

볼륨 테스트는 항상 docker volume create → 첫 번째 컨테이너에서 데이터 저장 → 컨테이너 삭제 → 두 번째 컨테이너에서 같은 데이터 확인 순서로 고정.

볼륨 이름(codyssey-data)과 테스트 컨테이너 이름(vol-test, vol-test2)을 고정하여, 재실행 시에도 동일한 흐름으로 검증할 수 있게 했다.
각 단계의 결과는 로그 파일에 남도록 구성하여, 실제 실행 순서와 결과를 다시 검토할 수 있게 했다.
즉, 재현 가능성은 단순히 명령을 기록한 것이 아니라, 사전 정리 → 실행 → 확인 → 로그 기록의 흐름을 스크립트로 고정함으로써 확보하였다.

# 6. 00_CLI: 터미널 기본 조작
# 6-1. 사용 스크립트

```bash
00_cli/run_cli.sh
```

# 6-2. 목적
터미널에서 가장 기본적인 파일 및 디렉토리 조작 명령을 직접 수행하고, 결과를 로그 파일로 남기는 것을 목표로 하였다.

# 6-3. 실행 방법
```bash
chmod +x 00_cli/run_cli.sh
./00_cli/run_cli.sh
```
실행 결과는 아래 파일에 기록된다.
```bash
00_cli/cli_log
```
# 6-4. 수행 명령 및 예상 출력
# 6-4-1. 현재 위치 확인
```bash
pwd
```
예상 출력
```bash
<프로젝트>/00_cli
```
예시
```bash
$BASE_DIRECTORY/00_cli
```
run_cli.sh 내부에서 BASE="$(cd "$(dirname "$0")" && pwd -P)" 와 cd "$BASE" 를 수행하므로, pwd 결과는 항상 run_cli.sh 가 위치한 디렉토리 기준으로 맞춰진다.

# 6-4-2. 작업 디렉토리 생성
```bash
mkdir -p "$BASE/answer_directory"
ls -la "$BASE" | grep answer_directory
```

예상 출력
```bash
drwxr-xr-x  ... answer_directory
6-4-3.
```

전체 파일 목록 확인
```bash
ls -la "$BASE"
```

예상 출력
```bash
answer_directory
cli_log
```

# 6-4-4. 빈 파일 생성
```bash
touch "$BASE/test"
ls -la "$BASE/test"
```
예상 출력
```bash
-rw-r--r--  ... test
```
# 6-4-5. 파일 복사
```bash
cp "$BASE/test" "$BASE/test_copy"
ls -la "$BASE" | grep test
```
예상 출력
```bash
-rw-r--r--  ... test
-rw-r--r--  ... test_copy
```
# 6-4-6. 파일 이름 변경
```bash
mv "$BASE/test_copy" "$BASE/test_renamed"
ls -la "$BASE" | grep test
```
예상 출력
```bash
-rw-r--r--  ... test
-rw-r--r--  ... test_renamed
```
# 6-4-7. 파일 삭제 후 목록 확인
```bash
rm -f "$BASE/test_renamed" "$BASE/test"
ls -la "$BASE"
```

예상 출력
```bash
answer_directory
cli_log
```
# 6-4-8. 로그 파일 내용 확인
```bash
cat 00_cli/cli_log
```
예상 출력
```bash
=== 1단계: [pwd] 현재 위치 ===
$ pwd
/Users/사용자이름/__dev/codyssey_week_01/00_cli

=== 2단계: [mkdir answer_directory] 폴더 생성 ===
$ mkdir -p "$BASE/answer_directory" && ls -la "$BASE" | grep answer_directory
drwxr-xr-x ... answer_directory
```
실제 로그에는 각 단계의 명령과 출력 결과가 순서대로 누적된다.

# 6-5. 검증 포인트

pwd 결과가 00_cli 디렉토리 기준으로 출력되는지 확인
answer_directory 생성 여부를 확인
파일 생성, 복사, 이름 변경, 삭제가 단계별로 반영되는지 확인
명령어와 출력 결과가 cli_log에 누적되는지 확인

# 7. 01_Permission: 파일 권한 실습
# 7-1. 사용 스크립트
```bash
01_permission/run_permission.sh
```
# 7-2. 목
파일 1개와 디렉토리 1개를 대상으로 권한을 변경하고, 변경 전후 차이를 확인하는 것을 목표로 함.

7-3. 실행 방법
```bash
chmod +x 01_permission/run_permission.sh
./01_permission/run_permission.sh
```
실행 결과는 아래 파일에 기록된다.
```bash
01_permission/permission_log
```
# 7-4. 수행 명령 및 예상 출력
# 7-4-1. 실습용 파일/디렉토리 생성
```bash
touch $BASE_DIRECTORY/01_permission/permission_test_file
mkdir -p $BASE_DIRECTORY/01_permission/permission_test_dir
ls -ld $BASE_DIRECTORY/01_permission/permission_test_file $BASE_DIRECTORY/01_permission/permission_test_dir
```
예시 출력
```bash
-rw-r--r--  ... $BASE_DIRECTORY/01_permission/permission_test_file
drwxr-xr-x  ... $BASE_DIRECTORY/01_permission/permission_test_dir
```
# 7-4-2. 초기 권한 확인
```bash
stat -f "%Sp %N" $BASE_DIRECTORY/01_permission/permission_test_file $BASE_DIRECTORY/01_permission/permission_test_dir
```
예시 출력
```bash
-rw-r--r-- $BASE_DIRECTORY/01_permission/permission_test_file
drwxr-xr-x $BASE_DIRECTORY/01_permission/permission_test_dir
```
# 7-4-3. 파일 권한을 600으로 변경
```bash
chmod 600 $BASE_DIRECTORY/01_permission/permission_test_file
stat -f "%Sp %N" $BASE_DIRECTORY/01_permission/permission_test_file
```
예시 출력
```bash
-rw------- $BASE_DIRECTORY/01_permission/permission_test_file
```
# 7-4-4. 파일 권한을 644로 변경
```bash
chmod 644 $BASE_DIRECTORY/01_permission/permission_test_file
stat -f "%Sp %N" $BASE_DIRECTORY/01_permission/permission_test_file
```
예시 출력
```bash
-rw-r--r-- $BASE_DIRECTORY/01_permission/permission_test_file
```
# 7-4-5. 디렉토리 권한을 700으로 변경
```bash
chmod 700 $BASE_DIRECTORY/01_permission/permission_test_dir
stat -f "%Sp %N" $BASE_DIRECTORY/01_permission/permission_test_dir
```
예시 출력
```bash
drwx------ $BASE_DIRECTORY/01_permission/permission_test_dir
```
# 7-4-6. 디렉토리 권한을 755로 변경
```bash
chmod 755 $BASE_DIRECTORY/01_permission/permission_test_dir
stat -f "%Sp %N" $BASE_DIRECTORY/01_permission/permission_test_dir
```
예시 출력
```bash
drwxr-xr-x $BASE_DIRECTORY/01_permission/permission_test_dir
```
# 7-5. 권한 의미 정리

r: read, 읽기 권한
w: write, 쓰기 권한
x: execute, 실행 권한
숫자 권한은 다음 값을 더해서 표현.

r = 4
w = 2
x = 1
예시:
```bash
755
```
소유자: 7 = rwx
그룹: 5 = r-x
기타 사용자: 5 = r-x
```bash
644
```
소유자: 6 = rw-
그룹: 4 = r--
기타 사용자: 4 = r--
디렉토리에서 x 권한은 단순 실행이 아니라 해당 디렉토리에 진입하거나 내부 항목에 접근할 수 있음을 의미한다.

# 7-6. 검증 포인트
파일 권한이 600 → 644로 변경되는지 확인
디렉토리 권한이 700 → 755로 변경되는지 확인
stat -f "%Sp %N" 결과가 단계별로 로그에 기록되는지 확인
파일과 디렉토리에서 x 권한 의미가 다름을 설명할 수 있는지 확인
# 8. 02_Docker: Docker 기본 점검 및 실습
# 8-1. 개요
Docker 파트는 기본 점검, 기본 운영 명령, 컨테이너 실행 실습, 커스텀 이미지 제작, 포트 매핑, 바인드 마운트, 볼륨 영속성 검증으로 나누어 진행하였다.

# 8-2. Docker 설치 및 기본 점검
사용 스크립트
```bash
02_docker/00_run_docker_check.sh
```
실행 방법
```bash
chmod +x 02_docker/00_run_docker_check.sh
cd 02_docker
./00_run_docker_check.sh
```
실행 결과는 아래 파일에 기록.
```bash
02_docker/docker_check_log
```
사전 조건
서울캠퍼스 환경에서는 sudo 사용이 제한될 수 있으므로, Docker 실행 환경으로 OrbStack을 사용하였다.
스크립트 실행 전 OrbStack 애플리케이션이 실행 중이어야 한다.

수행 명령
```bash
docker --version
docker info
```
예시 출력
```bash
Docker version XX.XX.X, build XXXXXXX
Client:
 Context:    default

Server:
 Containers: ...
 Images: ...
 Server Version: ...
```
설명
docker --version 은 Docker CLI 설치 여부를 확인한다.
docker info 는 Docker 데몬이 실제로 실행 중인지 확인한다.
8-3. Docker 기본 운영 명령
이 단계는 00_run_docker_check.sh 스크립트 안에서 함께 수행하였다.

수행 명령
```bash
docker run hello-world
docker pull ubuntu
docker images
```
예시 출력
```bash
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    ...            ...           ...
ubuntu        latest    ...            ...           ...
docker run -dit --name ubuntu-cli-test ubuntu bash
docker ps
docker ps -a
```
예시 출력
```bash
CONTAINER ID   IMAGE    COMMAND   STATUS    NAMES
...            ubuntu   "bash"    Up ...    ubuntu-cli-test
docker logs hello-world-test
```
예시 출력
```bash
Hello from Docker!
This message shows that your installation appears to be working correctly.
docker run -d --name ubuntu-stats ubuntu sleep infinity
docker stats --no-stream ubuntu-stats
```
예시 출력
```bash
CONTAINER ID   NAME          CPU %   MEM USAGE / LIMIT   MEM %
...            ubuntu-stats  ...     ...                 ...
```
실행 예시
```bash
$ docker run -d --name ubuntu-stats ubuntu sleep infinity
b8c1c2d3e4f5g6h7i8j9k0lmnopqrstuv

$ docker stats --no-stream ubuntu-stats
CONTAINER ID   NAME          CPU %   MEM USAGE / LIMIT   MEM %
b8c1c2d3e4f5   ubuntu-stats  0.00%   1.234MiB / 7.656GiB  0.02%
```
설명
docker images 는 로컬 이미지 목록을 확인한다.
docker ps 는 실행 중인 컨테이너만 보여준다.
docker ps -a 는 종료된 컨테이너까지 포함해 전체를 보여준다.
docker logs 는 종료된 컨테이너의 실행 로그도 확인할 수 있다.
docker stats 는 실행 중인 컨테이너의 리소스 사용량을 보여준다.
docker stats 는 실행 중인 컨테이너에 대해서만 의미 있는 정보를 보여주므로, 먼저 sleep infinity 를 사용해 테스트용 컨테이너를 종료되지 않은 상태로 유지했다.
--no-stream 옵션은 실시간으로 계속 갱신하지 않고 자원 사용량을 1회만 출력하므로, 로그 기록이나 캡처용 확인에 적합하다.
# 8-4. 컨테이너 실행 실습
이 단계 역시 00_run_docker_check.sh 스크립트 안에서 함께 수행하였다.

hello-world 실행 성공 확인
```bash
docker run hello-world
```
hello-world 컨테이너는 실행 후 바로 종료되며, Docker 설치가 정상적으로 동작함을 보여주는 기본 테스트로 사용하였다.

ubuntu 컨테이너 실행 후 내부 명령 수행
```bash
docker run -dit --name ubuntu-cli-test ubuntu bash
docker exec ubuntu-cli-test bash -lc "ls; echo 'hello from ubuntu container'; pwd"
```
예시 출력
```bash
bin
boot
dev
etc
home
...

hello from ubuntu container
/
```
attach 와 exec 차이 정리
attach
이미 실행 중인 컨테이너의 주 프로세스에 직접 붙는다.
컨테이너가 포그라운드 프로그램처럼 동작할 때 상태를 그대로 볼 수 있다.
잘못 다루면 메인 프로세스 종료와 연결될 수 있다.
exec
실행 중인 컨테이너 안에서 새 명령을 별도로 실행한다.
점검, 디버깅, 일회성 명령 실행에 더 안전하고 자주 사용된다.
이번 실습에서는 docker exec를 사용해 ubuntu 컨테이너 내부에서 ls, echo, pwd를 실행하였다.

# 8-5. Dockerfile 기반 커스텀 이미지 제작
사용 스크립트
```bash
02_docker/01_run_custom_web.sh
```
실행 방법
```bash
chmod +x 02_docker/01_run_custom_web.sh
cd 02_docker
./01_run_custom_web.sh
```
실행 결과는 아래 파일에 기록된다.
```bash
02_docker/custom_web_log
```
선택한 베이스 이미지
이번 단계에서는 기존 웹 서버 베이스 이미지인 nginx:alpine을 사용하였다.

# 선택 이유
가볍고 빠르게 실행 가능
정적 HTML 파일 배포에 적합
포트 매핑과 웹 접속 확인이 쉬움

Dockerfile 파일 위치
```bash
02_docker/web/Dockerfile
```
내용
```bash
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-custom-nginx"
LABEL org.opencontainers.image.description="Custom NGINX image for codyssey workstation mission"

ENV APP_ENV=dev

COPY site/ /usr/share/nginx/html/

EXPOSE 80
```
빌드 명령
```bash
docker build -t codyssey-custom-web:1.0 ./web
```
예시 출력
```bash
Successfully built ...
Successfully tagged codyssey-custom-web:1.0
```
## 8-6. 포트 매핑을 통한 접속 검증
목적
작성한 Dockerfile로 빌드한 커스텀 웹 서버를 백그라운드에서 실행하고, 호스트(macOS)와 컨테이너 간의 포트를 연결하여 정상적으로 서비스가 노출되는지 확인한다.

사용 스크립트 및 실행
```bash
02_docker/01_run_web.sh
```
# 1. 기존 잔여 컨테이너 정리 (충돌 방지)
```bash
docker rm -f my-web-8080 2>/dev/null
```
# 2. 포트 매핑(-p)을 적용하여 컨테이너 실행
```bash
docker run -d -p 8080:80 --name my-web-8080 codyssey-custom-web:1.0
```
# 3. CLI를 통한 로컬호스트 접속 테스트
``` bash
curl http://localhost:8080
```
## 9. Docker 볼륨 데이터 영속성 검증
목적컨테이너가 삭제되더라도 데이터베이스나 중요 파일이 유지되어야 하는 상황을 가정하여, Docker 볼륨을 생성하고 영속성(Persistence)을 검증한다.  

사용 스크립트 및 실행
```bash
02_docker/02_run_volume_test.sh
```
수행 명령 및 흐름

# 1. 볼륨 생성
```bash
$ docker volume create codyssey-data
```
# 2. 첫 번째 컨테이너에 볼륨 마운트 및 데이터 작성
```bash
$docker run -d --name vol-test -v codyssey-data:/data ubuntu sleep infinity$ docker exec vol-test bash -lc "echo 'Hello Codyssey Volume Data!' > /data/hello.txt && cat /data/hello.txt"
Hello Codyssey Volume Data!
```
# 3. 컨테이너 강제 삭제 (데이터 손실 위험 상황 가정)
```bash
$ docker rm -f vol-test
```
# 4. 두 번째 컨테이너 생성 후 동일 볼륨 마운트하여 데이터 복원 확인
```bash
$docker run -d --name vol-test2 -v codyssey-data:/data ubuntu sleep infinity$ docker exec vol-test2 bash -lc "cat /data/hello.txt"
Hello Codyssey Volume Data!
```
검증 포인트
docker rm -f로 컨테이너가 완전히 삭제되었음에도, 볼륨을 통해 다시 마운트했을 때 데이터가 그대로 유지됨을 확인했다.

## 10. Git 설정 및 GitHub 연동
목적
소스코드 버전 관리를 위한 기본 사용자 정보를 설정하고, 원격 협업 플랫폼인 GitHub와 VSCode를 연동하여 개발 작업실 세팅을 마무리한다.

수행 명령

# 1. 사용자 정보 및 기본 브랜치 설정
```bash
$ git config --global user.name "Noh Jung-woo"
$ git config --global user.email "***@***.com"  # 보안을 위해 이메일 마스킹 처리
$ git config --global init.defaultBranch main
```
# 2. 설정 확인
```bash
$ git config --list | grep -E 'user|init'
user.name=Noh Jung-woo
user.email=***@***.com
init.defaultbranch=main
```






