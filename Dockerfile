FROM anapsix/alpine-java:jre8

# a fork of https://github.com/Quantisan/docker-clojure

ENV LEIN_VERSION=2.6.1
ENV LEIN_INSTALL=/usr/local/bin/

WORKDIR /tmp

RUN apk upgrade --update \
  && apk add --update gnupg \  
  && mkdir -p $LEIN_INSTALL \
  && wget -q https://github.com/technomancy/leiningen/archive/$LEIN_VERSION.tar.gz \
  && echo "Comparing archive checksum ..." \
  && echo "f7643a14fd8a4d5c19eeb416db8ea549d8d2c18a *$LEIN_VERSION.tar.gz" | sha1sum -c - \
  && mkdir ./leiningen \
  && tar -xzf $LEIN_VERSION.tar.gz  \
  && mv leiningen-$LEIN_VERSION/bin/lein-pkg $LEIN_INSTALL/lein \
  && rm -rf $LEIN_VERSION.tar.gz ./leiningen-$LEIN_VERSION \

  && chmod 0755 $LEIN_INSTALL/lein \

# Download and verify Lein stand-alone jar
  && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip \
  && wget -q https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip.asc \

  && gpg --keyserver pool.sks-keyservers.net --recv-key 2E708FB2FCECA07FF8184E275A92E04305696D78 \
  && echo "Verifying Jar file signature ..." \
  && gpg --verify leiningen-$LEIN_VERSION-standalone.zip.asc \

# Put the jar where lein script expects
  && rm leiningen-$LEIN_VERSION-standalone.zip.asc \
  && mkdir -p /usr/share/java \
  && mv leiningen-$LEIN_VERSION-standalone.zip /usr/share/java/leiningen-$LEIN_VERSION-standalone.jar \
  && apk del gnupg

# cant find rlfe or rlwrap, ignored for now:

# Some REPLs (e.g., Figwheel) necessitate a readline wrapper.
#  &&  apt-get update && apt-get install rlfe && rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:$LEIN_INSTALL
ENV LEIN_ROOT 1

RUN lein
