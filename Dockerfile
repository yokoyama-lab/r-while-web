FROM php:7.3-apache
ARG        OCAML_MAJOR=4.05
ARG        OCAML_VERSION=4.05.0
ARG        OPAM_VERSION=1.2.2

RUN apt update \
    # システムの文字コード指定
    && echo 'export LANG=C.UTF-8' >> ~/.bashrc \
    && echo 'export LANGUAGE="C.UTF-8"' >> ~/.bashrc \

    cd /home \
    # opamをインストール
    wget http://caml.inria.fr/pub/distrib/ocaml-${OCAML_MAJOR}/ocaml-${OCAML_VERSION}.tar.gz && \
    tar xzf ocaml-${OCAML_VERSION}.tar.gz && \
    cd ocaml-${OCAML_VERSION} && \
    ./configure && make world.opt && umask 022 && make install && make clean && \
    cd .. && \
    rm -f ocaml-${OCAML_VERSION}.tar.gz && \
    rm -rf ocaml-${OCAML_VERSION} && \
    wget https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-full-${OPAM_VERSION}.tar.gz && \
    tar zxf opam-full-${OPAM_VERSION}.tar.gz && \
    cd opam-full-${OPAM_VERSION} && \
    ./configure && make lib-ext && make && make install && \
    cd .. && \
    rm -f opam-full-${OPAM_VERSION}.tar.gz && \
    rm -rf opam-full-${OPAM_VERSION} && \
    yes | opam init && \
    eval `opam config env` && \
    yes | opam install utop
    
    # haskellをインストール
    && apt install -y haskell-platform \
    && cabal update \
    && cabal install BNFC \
    && ln -s /root/.cabal/bin/bnfc /usr/local/bin/bnfc

