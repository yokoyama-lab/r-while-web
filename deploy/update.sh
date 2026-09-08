#!/bin/sh
# 本番（s1: tetsuo.jp）を更新する。サーバ上で実行する。
#   ssh s1 'sh /var/www/apps/r-while-web/deploy/update.sh'
#
# 初回の設置（Apache の Alias、ocaml-nox、所有権）は
# ~/dev/www/tetsuo.jp-conf/r-while-setup.sh を root で 1 回走らせる。
set -eu

APP_DIR=/var/www/apps/r-while-web
cd "$APP_DIR"

git pull --ff-only

# composer は dist（GitHub API）だと s1 の IP がレート制限に掛かって全滅する。
# --prefer-source なら git 越しに取れて、認証情報をサーバに置かずに済む。
~/bin/composer install --no-dev --no-interaction --no-progress --prefer-source

# R-WHILE 処理系。バイトコードの shebang にビルドマシンの ocamlrun の絶対パスが
# 焼かれるので、手元でビルドして配ってはいけない。必ずサーバ上で作る。
make -C src install

php artisan config:cache
php artisan view:cache

# ⚠ route:cache は使わない。Alias（/r-while）配下だと GET / が 405 になる
#   （2026-09-08 に本番で 2 回再現。/r-while/2 は 200 のまま、/ だけが落ちる）。
php artisan route:clear

echo "done"
