FROM php:7.3-apache
RUN apt update \
    && cd \
    && apt install -y --no-install-recommends opam \
    && opam init -y --disable-sandboxing \
    && opam update \
    && opam switch \
    && eval $(opam env) \
    && opam install -y extlib ocamlfind

