# 1. 베이스 이미지 선택: 가볍고 빠른 정적 웹 서버 구동을 위해 NGINX alpine 버전을 사용합니다.
FROM nginx:alpine

# 2. 커스텀 포인트 적용 (라벨): 이미지의 목적과 소유자를 명확히 기록합니다.
LABEL org.opencontainers.image.title="codyssey-custom-web"
LABEL org.opencontainers.image.description="Codyssey 2기: GAME & QUEST 개발 워크스테이션 웹 서버"
LABEL org.opencontainers.image.authors="Noh Jung-woo"

# 3. 커스텀 포인트 적용 (환경 변수): 현재 컨테이너가 개발(dev) 환경용임을 시스템에 명시합니다.
ENV APP_ENV=dev

# 4. 소스코드 주입: 앞서 작성한 로컬의 HTML 파일을 NGINX가 서비스하는 기본 컨테이너 경로로 복사합니다.
COPY site/ /usr/share/nginx/html/

# 5. 포트 노출: NGINX의 기본 웹 서비스 포트인 80번을 외부에 노출하도록 설정합니다.
EXPOSE 80               