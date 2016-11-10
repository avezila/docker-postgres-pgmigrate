FROM postgres

MAINTAINER pioh "thepioh@zoho.com"

RUN apt-get update \
 && apt-get install -y python3 python3-pip python3-virtualenv postgresql-server-dev-9.6 libpq-dev \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && pip3 install yandex-pgmigrate \
 && rm -rf .cache/pip
