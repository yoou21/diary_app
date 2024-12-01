# Dockerfile

FROM ruby:3.2

# 必要なライブラリのインストール
RUN apt-get update -qq && apt-get install -y nodejs npm

# yarn のインストール
RUN npm install -g yarn

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
