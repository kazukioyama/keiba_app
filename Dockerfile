FROM ruby:2.7
# Dockerにnodeをインストールする
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
# Dockerにyarnをインストールする
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# #selenium用
# ## google-chrome
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
# wget http://dl.google.com/linux/deb/pool/main/g/google-chrome-unstable/google-chrome-unstable_93.0.4577.18-1_amd64.deb && \
# apt-get install -y -f ./google-chrome-unstable_93.0.4577.18-1_amd64.deb
# ## ChromeDriver
# ADD https://chromedriver.storage.googleapis.com/93.0.4577.15/chromedriver_linux64.zip /opt/chrome/
# RUN cd /opt/chrome/ && \
# unzip chromedriver_linux64.zip

# Chrome をインストール
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qq \
  && apt-get install -y google-chrome-stable libnss3 libgconf-2-4

# ChromeDriver をインストール
# 現在の最新のバージョンを取得し、それをインストールする。
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` \
  && curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip \
  && mv chromedriver /usr/local/bin/

RUN gem install bundler
COPY . app
WORKDIR /app