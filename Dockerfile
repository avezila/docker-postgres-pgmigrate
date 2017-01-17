FROM sameersbn/postgresql

MAINTAINER pioh "thepioh@zoho.com"

RUN apt-get update \
 && apt-get install -y python3 python3-dev libyaml-cpp-dev python3-pip postgresql-server-dev-${PG_VERSION} gcc libpq-dev \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && pip3 install yandex-pgmigrate \
 && rm -rf .cache/pip
