# ベースイメージ
FROM ruby:3.2

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y nodejs npm

# Yarn のインストール
RUN npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /app

# Gemfile と Gemfile.lock をコピー（依存関係インストール用）
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundler をインストール
RUN bundle install

# アプリケーション全体をコピー
COPY . /app

# ポートを公開
EXPOSE 3000

# アプリケーションの起動コマンド
CMD ["sh", "-c", "bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}"]
