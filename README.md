# alpine-lein

Leiningen 2.6.1 container based on [Docker Alpine](https://hub.docker.com/_/alpine/) and [Anapsix/alpine-java:jre8](https://github.com/anapsix/docker-alpine-java).

This is essentially a fork of... wait a minute, there was already an offical [Alpine build of leiningen] (https://hub.docker.com/_/clojure/).

The only difference is that this container is based on the alpine-java:jre8 instead of (the larger) jdk8. The only time the JDK is preferable over the JRE, AFAIK, is when you have [project specific java source files] (https://github.com/technomancy/leiningen/blob/master/doc/MIXED_PROJECTS.md#source-layout) in your Leiningen project.

## Alternatives

* The official [Alpine build of leiningen](https://hub.docker.com/_/clojure/).
* [Alpine-lein2-ci](https://github.com/ryanbaldwin/alpine-lein2-ci), consider the clever usage of volumes on the maven repository folder to avoid dependency bonanza.

## Shortcomings

No rlfe or rlwrap, which will make your repl development unnescessarily painful.
