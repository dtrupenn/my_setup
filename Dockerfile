ARG OS_NAME=ubuntu
ARG OS_VERSION=xenial

FROM ${OS_NAME}:${OS_VERSION}

ENV DIRPATH /tmp

ADD dotfiles $DIRPATH/dotfiles
ADD bin $DIRPATH/bin
ADD git_alias $DIRPATH/git_alias
ADD init.vim $DIRPATH
ADD flake8 $DIRPATH
ADD setup.sh $DIRPATH

WORKDIR $DIRPATH
# https://github.com/phusion/baseimage-docker/issues/319
RUN apt-get update && apt-get install -y --no-install-recommends \
                      sudo apt-utils \
		      && rm -rf /var/lib/apt/lists/*
RUN ["/bin/bash", "setup.sh"]
