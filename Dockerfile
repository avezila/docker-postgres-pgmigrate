FROM sameersbn/postgresql

MAINTAINER pioh "thepioh@zoho.com"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:jonathonf/python-3.6
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install -y software-properties-common python3.6 python3.6-dev libyaml-cpp-dev python3-pip postgresql-server-dev-${PG_VERSION} g++-4.9 libpq-dev gcc python3 python3-dev
RUN apt-get dist-upgrade -y
RUN apt-get clean
RUN rm -rf /usr/bin/x86_64-linux-gnu-gcc
RUN ln -s /usr/bin/gcc-4.9 /usr/bin/x86_64-linux-gnu-gcc
RUN pip3 install yandex-pgmigrate pgcli
RUN rm -rf .cache/pip

ADD ./entrypoint.sh /sbin/entrypoint.sh
