FROM golang as buildstage

RUN mkdir /counter
COPY ./foo.go /counter
WORKDIR /counter

RUN go build


FROM alpine

COPY --from=buildstage /counter/counter /bin/counter

CMD [ "/bin/counter" ]
