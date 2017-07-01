ARG OS_NAME=ubuntu
ARG OS_VERSION=trusty

FROM ${OS_NAME}:${OS_VERSION}

ENV DIRPATH /tmp

ADD dotfiles $DIRPATH/dotfiles
ADD bin $DIRPATH/bin
ADD git_alias $DIRPATH/git_alias
ADD init.vim $DIRPATH
ADD flake8 $DIRPATH
ADD setup.sh $DIRPATH

WORKDIR $DIRPATH
RUN ["/bin/bash", "setup.sh"]
