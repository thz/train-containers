FROM debian
RUN apt-get update && apt-get install -y vim

COPY ./vimrc /etc/vim/vimrc

WORKDIR /root
ENTRYPOINT [ "vim" ] 
