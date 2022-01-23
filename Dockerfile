FROM ubuntu:latest
LABEL maintainer="David Stenglein <dave@davidstenglein.com>"


RUN adduser --gecos "*" --disabled-password devuser && \
    apt-get update && \
    apt-get -y install sudo git 

RUN adduser devuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY requirements.yml /tmp
COPY devshell-playbook.yml /tmp
COPY antigen-playbook.yml /tmp

RUN apt-get -y install python3-apt ansible && \
    ansible-galaxy install -r /tmp/requirements.yml && \
    ansible-playbook /tmp/devshell-playbook.yml -i localhost && \
    ansible-playbook /tmp/antigen-playbook.yml -i localhost && \
    apt-get -y remove ansible python3-apt && \
    apt-get -y autoremove && rm -rf /var/lib/apt/lists/* && \
    rm /tmp/*

USER devuser
ENV COLORTERM=truecolor
ENV TERM=xterm-256color

CMD ["zsh"]
