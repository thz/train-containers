FROM debian as buildstage

RUN apt-get update && apt-get install -y build-essential 
RUN mkdir /src

COPY ./foo.c /src
WORKDIR /src

RUN make foo


FROM ubuntu

COPY --from=buildstage /src/foo /bin/foo

CMD [ "/bin/foo" ]
