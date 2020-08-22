FROM ocaml/opam2:ubuntu

RUN sudo apt update -y \
    # システムの文字コード指定
    && echo 'export LANG=C.UTF-8' >> ~/.bashrc \
    && echo 'export LANGUAGE="C.UTF-8"' >> ~/.bashrc \

    # opam 
    && sudo apt install m4 \
    && opam install extlib ocamlfind \
    && eval `opam config env` \

    # haskellをインストール
    && sudo apt install -y haskell-platform \
    && sudo cabal update \
    && sudo cabal install BNFC \
    && sudo ln -s /home/opam/.cabal/bin/bnfc /usr/bin/bnfc

