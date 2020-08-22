FROM php:7.3-apache
RUN apt update \
    # システムの文字コード指定
    && echo 'export LANG=C.UTF-8' >> ~/.bashrc \
    && echo 'export LANGUAGE="C.UTF-8"' >> ~/.bashrc \

    # opamをインストール
    && apt install -y --no-install-recommends opam \
    && opam init -y --disable-sandboxing \
    && opam update \
    && opam switch \
    && eval $(opam env) \
    && opam install -y extlib ocamlfind ocamlyacc \
    && eval $(opam env) \

    # haskellをインストール
    && apt install -y haskell-platform \
    && cabal update \
    && cabal install BNFC \
    && ln -s /root/.cabal/bin/bnfc /usr/local/bin/bnfc

