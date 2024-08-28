# パッケージをインストールするためのイメージ
FROM python:3.11.9-slim-bullseye as builder

COPY python/requirements.txt .

# パッケージの追加とタイムゾーンの設定
# libgomp1を入れないと、lightgbmをimportしたときエラーが出る
RUN apt-get update
RUN apt-get install -y \
    tzdata \
    libgomp1 \
    &&  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Tokyo

# pythonパッケージ
RUN python3 -m pip install --upgrade pip \
    &&  python3 -m pip install --no-cache-dir -r requirements.txt
