FROM alpine as build
RUN apk add --update gcc libc-dev
COPY foo.c /foo.c
RUN gcc -static /foo.c

FROM scratch
COPY --from=build /a.out /foo
CMD /foo
