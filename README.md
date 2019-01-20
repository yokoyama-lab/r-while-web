# rwhile-C-OCaml
An R-WHILE interpreter in OCaml

## Requirements
+ OCaml
 + ocamlfind
 + ocamlyacc
 + extlib
+ The BNF Converter: http://bnfc.digitalgrammars.com/

## macにてインストール例

+ Homebrew をインストール: http://brew.sh/index_ja.html
+ 以下をタイプ
```
brew update
brew install ocaml
opam init
```
+ 指示された設定を行う
+ rwhile-C-ocaml-master.zip をダウンロードして解凍して以下を実行
```
opam update
opam install extlib ocamlfind
cd src
make
```
