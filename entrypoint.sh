#!/bin/bash
set -e
source ${PG_APP_HOME}/functions

[[ ${DEBUG} == true ]] && set -x

# allow arguments to be passed to postgres
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == postgres || ${1} == $(which postgres) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch postgres
if [[ -z ${1} ]]; then
  map_uidgid

  create_datadir
  create_certdir
  create_logdir
  create_rundir

  set_resolvconf_perms

  configure_postgresql

  echo "Starting PostgreSQL ${PG_VERSION}..."
  echo $EXTRA_ARGS
	if [ -d "/entrypoint" ]; then
		if [ -f "/entrypoint/entrypoint.sh" ]; then
			exec_as_postgres ${PG_BINDIR}/pg_ctl -D "$PG_DATADIR" -o "${EXTRA_ARGS}" -w start
			exec_as_postgres /entrypoint/entrypoint.sh
			exec_as_postgres ${PG_BINDIR}/pg_ctl -D "$PG_DATADIR" -m fast -w stop
  	fi
	fi

  exec start-stop-daemon --start --chuid ${PG_USER}:${PG_USER} \
    --exec ${PG_BINDIR}/postgres -- -D ${PG_DATADIR} ${EXTRA_ARGS}
else
  exec "$@"
fi
