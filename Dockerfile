# Python 3.9 버전을 기반으로 하는 런타임 이미지 준비 (Alpine 리눅스 버전으로 경량화)
FROM python:3.10-slim

# 작업 디렉토리 설정
WORKDIR /app

# 애플리케이션 의존성 파일 (requirements.txt) 복사
# 먼저 복사하고 설치하여 캐시 활용도를 높입니다.
COPY requirements.txt .

# Python 의존성 설치
RUN pip install --no-cache-dir -r requirements.txt

# 앱 소스코드만 카피
COPY ./app ./app

# 앱 env파일 카피
COPY .env .env

# 애플리케이션이 사용할 포트 노출 (예: 웹 서버의 기본 포트 8000)
EXPOSE 8000

ENTRYPOINT [ "uvicorn" , "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

# 시간대 설정
# ENV TZ=Asia/Seoul

# 애플리케이션 실행
# 여기서는 Gunicorn을 사용하는 Flask/Django 앱을 가정합니다.
# 'your_app_name:app'은 Flask 앱의 경우 'app.py' 파일 내의 'app' 객체를,
# Django 앱의 경우 'your_project_name.wsgi:application' 등을 의미할 수 있습니다.
# 실제 프로젝트에 맞춰 수정해야 합니다.

# 또는 간단한 파이썬 스크립트 실행의 경우:
# CMD ["python", "your_script.py"]