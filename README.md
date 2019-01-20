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

## Linux Ubuntu にてインストール例

```
sudo apt update
sudo apt install opam
opam init
opam update
```
+ 指示された設定を行う
```
opam switch
```
+ 最新版のOCamlをインストールする
```
opam install extlib ocamlfind
cd src
make
```

## 注意点
新しいOCamlを使用する場合は，Makefile中の
```
OCAMLC=ocamlfind ocamlc -g -package extlib -linkpkg
```
を
```
OCAMLC=ocamlfind ocamlc -unsafe-string -g -package extlib -linkpkg
```
に変更する必要があった

ディレクトリwebの中に data, programs を書き込みできるようにしておく必要がある．
```
mkdir data programs
chmod 777 data
chmod 777 programs
```