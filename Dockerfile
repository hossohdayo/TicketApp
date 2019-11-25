# Docker公式のRubyイメージを使う
FROM ruby:2.5.3

# アプリケーションを配置するディレクトリ
WORKDIR /app

# nodeのイメージからNode.jsとYarnをコピーする
COPY --from=node:12.10.0 /usr/local/ /usr/local/
COPY --from=node:12.10.0 /opt/ /opt/

# Bundlerを設定してgemをインストールする
ARG BUNDLE_INSTALL_ARGS="-j 4"
COPY Gemfile Gemfile.lock ./
RUN bundle config --local disable_platform_warnings true \
    && bundle install ${BUNDLE_INSTALL_ARGS}

# YarnでNodeパッケージをインストールする
COPY package.json yarn.lock ./
RUN yarn install

# エントリーポイントを設定する
COPY docker-entrypoint*.sh /
RUN chmod +x /docker-entrypoint*.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# アプリケーションのファイルをコピーする
COPY . ./

# サービスを実行するコマンドとポート設定する
CMD ["rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000
