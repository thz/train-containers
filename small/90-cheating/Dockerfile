FROM debian as build
RUN apt-get update
RUN apt-get install -y gcc
COPY foo.c /foo.c
RUN gcc -nostdlib -static /foo.c
RUN strip /a.out
RUN ls -l /a.out

FROM scratch
COPY --from=build /a.out /foo
ENTRYPOINT [ "/foo" ]
