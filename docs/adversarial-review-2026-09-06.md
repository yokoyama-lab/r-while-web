# 敵対的査読 — r-while-web — 2026-09-06

対象: `/work/a/dev/github.com/yokoyama-lab/r-while-web`（`master`、HEAD `2d5e327`、
**GitHub 上は PUBLIC**、最終 push 2026-05-28）。本査読は `docs/` に本ファイルを 1 つ置いた以外、
このリポジトリを一切書き換えていない（ビルド検証は
`/work/tmp/.../scratchpad/rwhile-src` に `src/` を**複製して**行った）。
commit / push / tag はしていない。

## 範囲と方法

読んだもの: `README.md` / `Dockerfile` / `composer.json` / `composer.lock` / `package.json` /
`phpunit.xml` / `.env.example` / `.gitignore` / `src/`（OCaml 7 ファイル＋`Makefile`）/
`routes/web.php` / `app/Http/Controllers/RWHILEController.php` / `tests/` / `public/`。

実際に実行したもの（すべて 5 分未満）:

- `src/` を scratchpad に複製して **`make`**（OCaml 5.3.0 + bnfc）→ **rc=0、`ri` 2.3MB を生成**
- 生成した `ri` で `public/examples/` の `.rwhile` を 25 組実行（結果は下記）
- `php -v`（**8.4.11**）、`git log` / `git status --porcelain`（空）/ `git branch -r`
- `gitleaks detect`（31 commits、**no leaks found**）
- `gh repo view`（可視性。**読み取りのみ**）
- 依存の版差分: `composer.lock` を JSON として読み、`R-WHILE_Quick_Start/r-while/` の
  同ファイルと突合（77 パッケージ差）

**未実施**: `composer install`（`composer` がこの機械に無く、かつ
`composer.json` の `"php": "^7.2"` は手元の PHP 8.4 と両立しない）、
`php artisan serve` による起動、`phpunit` の実行、`docker build`（5 分を超えうる）。

## 同定した中心的主張（層ラベル）

| # | 主張 | 出典 | 層 | 査読後 |
|---|---|---|---|---|
| C1 | README の手順で Ubuntu にインストールできる | README「Linux Ubuntu にてインストール例」 | 層3 | **手順に破れがある**（→ C-1） |
| C2 | `cd src && make install` で処理系が作れる | README | 層2 | **層2（妥当）。OCaml 5.3 で今日ビルドが通った** |
| C3 | 新しい OCaml では `-unsafe-string` が要る | README「注意点」 | 層3 | **陳腐化。OCaml 5 では該当オプションが廃止されており、無しで通る**（→ M-2） |
| C4 | テストがある（`tests/`・`phpunit.xml`） | リポジトリ構成 | 層4 | **中身は Laravel の雛形 2 本のみ。検査ゼロ**（→ H-1） |

**中心的な研究主張は無い。** これは R-WHILE のオンラインインタプリタという
Web アプリケーションで、README は導入手順書である。したがって争点は
「手順どおりに動くか」「放置の度合い」「公開物としての安全性」に絞られる。

---

## 確定した指摘

### CRITICAL

#### C-1. README のインストール手順は、書いてある順に実行すると 2 か所で止まる

README「Linux Ubuntu にてインストール例」の最初のブロック:

```
git clone https://github.com/yokoyama-lab/r-while-web.git
...
curl -sS https://getcomposer.org/installer | php
cd RWHILE-Online-Interpreter
./composer.phar install
```

**(1) `cd RWHILE-Online-Interpreter` は必ず失敗する。**
直前の `git clone` が作るディレクトリは **`r-while-web`** である
（リポジトリ名がそれ。`RWHILE-Online-Interpreter` は README の 1 行目の
見出し `# RWHILE-Online-Interpreter` に由来する**旧名**とみられる）。

**(2) 順序が逆で `./composer.phar` が存在しない。**
`curl -sS https://getcomposer.org/installer | php` は
**カレントディレクトリ**（= クローン先の親）に `composer.phar` を作る。
その後 `cd` してプロジェクトに入るので、`./composer.phar install` の
`./composer.phar` はそこに無い。

入門用の手順書として、**最初のブロックの 3 行目と 4 行目が両方とも壊れている**。

⚠ **さらに現在は 3 つ目の壁がある。** `composer.json` は
`"require": {"php": "^7.2"}` を宣言しており、PHP 8 系では
`composer install` が依存解決に失敗する（この機械の PHP は **8.4.11**）。
`laravel/framework: ^6.2`（Laravel 6 LTS）は **2022-09-06 にセキュリティ
サポートが終了**しており、PHP 8.1 以降を正式には支えない。
**未実施**: `composer` がこの機械に無いので、実際に走らせて確かめてはいない。
確定しているのは `composer.json` の制約と手元の PHP 版の食い違いである。

確認手段: `README.md`（該当ブロック）／`git remote -v`（リポジトリ名）／
`cat composer.json`（`"php": "^7.2"`, `laravel/framework: ^6.2`）／`php -v`。

---

### HIGH

#### H-1. 検査がゼロ。CI が無く、テストは Laravel の雛形 2 本だけ。それでも依存の自動更新だけは 6 年間マージされ続けている

- **`.github/` が存在しない**（`ls -a` で確認）→ **CI ゼロ**。
- `tests/` の中身は `tests/Unit/ExampleTest.php` と `tests/Feature/ExampleTest.php` の
  **2 本だけ**で、どちらも Laravel が生成する雛形そのままである:

  ```php
  public function testBasicTest() { $this->assertTrue(true); }          // Unit
  public function testBasicTest() { $response = $this->get('/');
                                    $response->assertStatus(200); }     // Feature
  ```

  R-WHILE の実行（`RWHILEController::execute`）も、OCaml 処理系との連携も、
  **1 行もテストされていない**。

一方 `git log` を見ると、**直近 24 コミット中の実質すべてが Dependabot の
依存更新とそのマージ**である。機能に触れた最後のコミットは:

```
2020-08-22 update Dockerfile
2020-08-14 R-WHILE の Syntax_Highlight 機能を実装
```

すなわち **6 年間、機能の変更は無く、依存だけが自動更新され、
それを検証する仕組みは 1 つも無い**。さらに `git branch -r` には
**未マージの Dependabot ブランチが 3 本**残っている:

```
origin/dependabot/composer/laravel/framework-6.20.45
origin/dependabot/composer/symfony/http-kernel-4.4.50
origin/dependabot/composer/symfony/polyfill-intl-idn-1.38.1
```

`laravel/framework` は現在 `v6.18.43` で、**6.20.45 への更新が滞留している**。
Laravel 6.x への Dependabot 提案はセキュリティ由来のことが多い。

> 「走っていない検査は異常なしと区別がつかない」——ここでは検査が
> 存在すらしないので、**マージされた 20 件超の依存更新がアプリを壊していないことを
> 示す証跡は 1 つも無い**。

確認手段: `ls -a`（`.github` 無し）／`cat tests/Unit/ExampleTest.php tests/Feature/ExampleTest.php`／
`git log --format='%ad %s' --date=short | grep -v -i 'bump\|dependabot\|merge pull'`／`git branch -r`。

---

### MEDIUM

#### M-1. `src/Makefile` の `test` ターゲットは、存在しないディレクトリを参照している

`src/Makefile` の `test:` は 20 行以上が `../examples/…` を参照する:

```make
test: ri
	./ri ../examples/rep.rwhile ../examples/list123.val
	./ri -inverse ../examples/ri.rwhile
	...
```

しかしリポジトリ直下に **`examples/` は存在しない**（`ls -d examples` は
`No such file or directory`）。例題は **`public/examples/`**（53 ファイル）にある。
したがって `make test` は最初の 1 行で落ちる。

⚠ **本査読では scratchpad の複製上で `make`（`all`/`ri`）だけを実行し、
`make test` は走らせていない**（パスが壊れているので走らせる意味が無い）。
代わりに `public/examples/` を直接指定して 25 組を実行した（→ 棄却 2）。

なお同ターゲットには `# ./ri ../examples/perm_to_code.rwhile … # failed?` という
**「失敗するかも」と書かれたままコメントアウトされた行**が 1 本あり、
`# 1:31:39.23もかかった` のような実測メモも残っている。
記録としては良いが、**回帰テストとしては誰も走らせていない**。

確認手段: `ls -d examples`（不在）／`ls public/examples | wc -l`（53）／`cat src/Makefile`。

#### M-2. README「注意点」の OCaml 対策は、現在の OCaml では逆効果になりうる

README:

> 新しいバージョンのOCamlを使用する場合は，Makefile中の
> `OCAMLC=ocamlfind ocamlc -g -package extlib -linkpkg` を
> `OCAMLC=ocamlfind ocamlc -unsafe-string -g -package extlib -linkpkg` に変更する必要がある

**実測では、この変更は不要だった。** 手元の **OCaml 5.3.0** で
`src/` を複製して `make` を走らせたところ、**無変更で rc=0**、`ri`（2.3MB）が生成された
（警告は `Warning 52 [fragile-literal-pattern]` が 2 件のみ）。
そして `-unsafe-string` は **OCaml 5.0 で廃止された**オプションなので、
README の指示どおりに書き換えると**逆にビルドが通らなくなる**おそれがある。

⚠ **未確認**: `-unsafe-string` を付けた場合に実際に落ちるかは試していない
（README の指示を試す価値が無いと判断した）。確定しているのは
**無変更で通る**ことである。

確認手段: scratchpad での `make`（rc=0、`ri` 生成）／`ocaml -version`（5.3.0）。

#### M-3. 利用者が投稿したプログラムとデータが、`public/` の下に無期限に溜まる

`app/Http/Controllers/RWHILEController.php:88-105`:

```php
$dir = public_path();
$prog_hash = substr(sha1($prog_text), 0, 8);
file_put_contents("$dir/programs/$prog_hash.rwhile", $prog_text);
...
file_put_contents("$dir/data/$data_hash.rwhile", $data_text);
```

- 保存先は **`public/`（Web から配信されるディレクトリ）**の直下。
- README は「`chmod 777 data` / `chmod 777 programs`」を指示している。
- 削除・期限切れの処理はコード中に無い（`rg` で `unlink` / `File::delete` は 0 件）。

`public/.htaccess` に `Options -MultiViews -Indexes` があるので**一覧はできない**が、
ファイル名は投稿内容の sha1 先頭 8 桁なので、**同じ内容を投稿すれば URL を再現できる**。
つまり「誰かが投稿したプログラムを、内容を知っている者は取得できる」状態で、
かつ**ディスクは単調に増え続ける**。教材サイトとしては軽微だが、
運用者が把握しておくべき性質である。

確認手段: `RWHILEController.php:88-110`／`public/.htaccess`／
`rg -n "unlink|File::delete" app/`（0 件）／README「注意点」。

---

### LOW

- **L-1**: README の見出しが `# RWHILE-Online-Interpreter` で、
  リポジトリ名（`r-while-web`）と一致しない。C-1 の `cd` 誤りの原因でもある。
- **L-2**: README の DB 設定の節が **HTML コメント `<!-- -->` で丸ごと無効化**されている。
  読者には見えないが、`.env.example` には `DB_CONNECTION=mysql` が残っているので、
  「DB をどう設定すべきか」がどこにも書かれていない状態になっている。
- **L-3**: `package.json` があるが、README にフロントエンドのビルド手順
  （`npm install` / `npm run dev`）が 1 行も無い。
- **L-4**: 未マージの Dependabot ブランチが 3 本、リモートに残っている（H-1 に含む）。

---

## 棄却した攻撃

1. **「OCaml 処理系がもうビルドできない」** → 棄却。
   scratchpad に `src/` を複製し、**OCaml 5.3.0 + bnfc 1.x で `make` が rc=0**、
   `ri`（2.3MB）が生成された。2020 年のコードが 6 年後の OCaml 5 系で
   無修正で通るのは、むしろ良い方である。
2. **「同梱の例題が処理系を通らない」** → 棄却。
   生成した `ri` で `public/examples/` の `.rwhile` を 25 組実行し、**22 組が正常終了**。
   落ちた 3 つのうち 2 つ（`infinite` / `infinite_inv`）は
   `src/Makefile` に「**#停止しない例**」と明記されている意図的な非停止例である。
   残る 1 つ（`update`）は**本査読の入力ファイルの当て方が適当だった可能性が高く、
   欠陥とは断定しない（未確認）**。
3. **「Web の実行経路にコマンドインジェクションがある」** → 棄却。
   `RWHILEController.php:79` の `$cmd = "timeout -sKILL 10 $dir/ri"` に入る変数は
   `public_path()` と、**sha1 から作った 8 桁 16 進のファイル名**だけである。
   利用者のプログラム本文はシェルを経由せず、
   `fwrite($pipes[0], $prog_text)` で**標準入力に直接**渡される。
   フラグ（`-inverse` / `-p2d` / `-exp`）も真偽値で選ばれる固定文字列。
   **シェルに到達する利用者制御の文字列は見つからなかった。**
4. **「秘密が混入している」** → 棄却。`gitleaks detect` は
   31 commits / 3.57MB を走査して **no leaks found**。
   `.env.example` の `APP_KEY` / `DB_PASSWORD` / `AWS_*` / `PUSHER_*` は**すべて空値**で、
   `.gitignore` に `.env` が入っている（`cat .gitignore`）。
5. **「作業ツリーに未追跡の訂正が残っている」** → 棄却。`git status --porcelain` は空。
6. **「Docker のベースイメージがもう無い」** → 棄却。
   `docker manifest inspect php:7.4-apache` は取得できた（**読み取りのみ**）。
   タグは今も存在する。ただし PHP 7.4 は 2022-11-28 に EOL である。

---

## 層ラベルの妥当性

- **このリポジトリは研究成果ではなく Web アプリケーションなので、層 1 は存在せず、
  主張もしていない。妥当。**
- **層 2 と呼べるのは 1 点だけ**: OCaml 処理系のビルドと例題の実行
  （本査読が今日再現した。22/25 組が動く）。
  **これはリポジトリの中に証跡が無い**（CI も、走る `make test` も無い）ので、
  現状はリポジトリ的には層 4 に置かれている。
- **README のインストール手順は層 3（紙の手順）で、しかも検証されていない。**
  C-1 の 2 か所は、誰かが 1 回でも頭から実行していれば見つかる誤りである。
- **「テストがある」という外形（`tests/` と `phpunit.xml` の存在）は層 4 である。**
  雛形 2 本が `assertTrue(true)` を通すだけなので、
  緑になっても何も保証しない。

---

## 推奨アクション

1. **(C-1) README の最初のブロックを 2 行直す。**
   `cd RWHILE-Online-Interpreter` → `cd r-while-web`、
   composer の導入をクローン後に移す（`cd r-while-web && curl -sS … | php && ./composer.phar install`）。
   **入門用リポジトリで最も費用対効果が高い一手である。**
2. **(C-1 続) PHP 8 に載せるか、「PHP 7.4 が必要」と README に明記する。**
   現状は制約が `composer.json` の中にしか無く、README を読んだ人は
   PHP 8 で詰まってから気づく。Laravel 6 は 2022-09 に EOL なので、
   長期的には Laravel 10/11 への更新か、アプリの凍結宣言のどちらかが要る。
3. **(H-1) CI を 1 本置く。** 最小構成でよい:
   `docker build` は重いので、**`cd src && make`（OCaml 処理系のビルド）だけでも
   自動化する価値が高い**——実測で数十秒で終わり、
   「6 年前のコードが今日の OCaml で通るか」を毎回教えてくれる。
   雛形テスト 2 本をそのまま走らせても意味は薄いので、
   `execute` の統合テストを 1 本足すのが望ましい。
4. **(H-1 続) 滞留している Dependabot 3 本を処理する。**
   CI が無いのでマージの可否を機械が判断できない。3 の CI を先に置くこと。
5. **(M-1) `src/Makefile` の `test:` を `../public/examples/` に直す。**
   その後 3 の CI に組み込めば、`# failed?` とコメントアウトされた
   1 本の真偽もその場で分かる。
6. **(M-2) README「注意点」の `-unsafe-string` の段を削除するか、
   「OCaml 4.06〜4.14 向け。OCaml 5 では不要（かつ廃止済み）」と書き換える。**
7. **(M-3) `public/programs` / `public/data` の保存期間と掃除方針を決める。**
   最低限、README の運用注意に 1 行足す。

> **生き残った部分**: 攻撃の主力だった「もう動かないだろう」は外れた。
> **6 年前の OCaml コードが、OCaml 5.3 で無修正のまま今日ビルドでき、
> 同梱例題の 22/25 が実行できた**のは素直に強い。
> Web 側の実行経路もシェルを介さない設計で、
> インジェクションの入口は見つからなかった。秘密の混入も無く、
> `.env` は正しく無視され、作業ツリーもクリーンである。
> 本査読の CRITICAL / HIGH は**コードではなく、
> 入口の 2 行の手順書と、検査が 1 つも無いこと**に集中している。
