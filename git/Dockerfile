FROM ubuntu

RUN apt-get update && apt-get install -y git openssh-server
RUN mkdir -p /var/run/sshd
RUN echo root:password | chpasswd
EXPOSE 22
