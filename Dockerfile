FROM ruby:3.2

# 必要なライブラリのインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# アプリのディレクトリ作成
WORKDIR /app

# 必要ファイルをコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# 必要なGemのインストール
RUN bundle install

# Railsアプリの作成コマンド (初回だけ実行する場合は適宜修正)
CMD ["rails", "server", "-b", "0.0.0.0"]