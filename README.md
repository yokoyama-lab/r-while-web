# r-while-web — R-WHILE Playground

可逆プログラミング言語 **R-WHILE** のオンラインインタプリタ。ブラウザ上で
R-WHILE のプログラムを書き、実行・逆転（inversion）・program2data 変換・
マクロ展開ができる。横山研究室の学生が作成した。

処理系の本体は `src/`（OCaml + [BNFC](https://bnfc.digitalgrammars.com/)）にあり、
Web 側は Laravel（PHP）でその実行を仲介するだけである。

## 必要なもの

| | 版 |
|---|---|
| PHP | 8.3 以上（`mbstring` `dom` `xml` `tokenizer` `ctype` `fileinfo` `openssl`） |
| Composer | 2 系 |
| OCaml | 4.14 以上（5.3 で動作確認済み） |
| ocamlfind, extlib | — |
| BNFC | 2.9 系 |

Ubuntu なら次で揃う。

```sh
sudo apt install php-cli php-mbstring php-xml composer ocaml ocaml-findlib libextlib-ocaml-dev bnfc
```

## 導入

```sh
git clone https://github.com/yokoyama-lab/r-while-web.git
cd r-while-web

composer install
cp .env.example .env
php artisan key:generate

# R-WHILE の処理系を作り、bin/ri に置く
make -C src install

php artisan serve
```

`http://127.0.0.1:8000/` が Playground。

> `bin/ri` が無いと実行ボタンは 503 を返す。処理系のビルドは必須である。

## テスト

```sh
make -C src test   # 処理系だけで例題を回す
php artisan test   # Web 側（画面・実行・入力検証・後始末）
```

`bin/ri` が無い状態では実行系のテストは **skip** される（合格ではない）。
CI（`.github/workflows/ci.yml`）は処理系を必ずビルドしてから走らせている。

## 構成

```
app/Http/Controllers/RWHILEController.php  画面とリクエストの処理（このアプリの実質すべて）
config/rwhile.php                          処理系の場所・実行時間の上限・入力の上限
resources/views/index.blade.php            Playground の画面（Ace エディタ）
public/examples/                           Sample ドロップダウンが読む例題 53 本
src/                                       R-WHILE 処理系（OCaml）
bin/ri                                     make install が置く実行ファイル（git 管理外）
```

## 設定

`.env` で変えられるもの:

| キー | 既定 | 意味 |
|---|---|---|
| `RWHILE_RI_BIN` | `bin/ri` | 処理系の実行ファイル |
| `RWHILE_TIMEOUT` | `10` | 1 回の実行に許す秒数 |
| `RWHILE_MAX_INPUT_BYTES` | `262144` | 受け付けるソース・データの最大バイト数 |

このアプリはデータベースを使わない。セッションとキャッシュはファイルに置く
（`SESSION_DRIVER=file` / `CACHE_STORE=file`）。

## 本番へ出すとき

- **`APP_DEBUG=false` と `APP_ENV=production`。** `.env.example` の既定もそうしてある。
  デバッグ表示を有効にしたまま公開すると、Laravel の例外画面から環境変数まで読める。
- `php artisan config:cache` は `.env` を読み込み済みの状態で行う。
- 書き込みが要るのは `storage/` と `bootstrap/cache/` だけ。**`public/` 配下に
  書き込み権限は要らない**（利用者の投稿は `storage/app/rwhile/` に一時ファイルとして
  置き、実行後に消す）。

## 補足

- R-WHILE は停止しないプログラムを書ける。`public/examples/infinite.rwhile` は
  意図的な非停止例で、`RWHILE_TIMEOUT` で打ち切られる。
- OCaml 5 では `-unsafe-string` は**廃止**されている。無指定のままビルドできる
  （旧 README にあった「新しい OCaml では `-unsafe-string` を足す」という記述は誤り）。
