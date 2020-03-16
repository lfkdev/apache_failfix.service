#!/usr/bin/env bash
#author: l.klostermann@pm.me

main() {
  i "$0 triggered!"
  get_config
  restart_apache
}

get_config() {
  # shellcheck disable=SC2005
  error_conf=$(echo "$(apachectl configtest 2>&1)" \
    | grep "Syntax error" | grep -oE '[^ ]+$') \
    && i "found conf: $error_conf"
  [ ! -z "$error_conf" ] || e "could not find corrupt conf"
}

restart_apache() {
  if unlink "${error_conf%?}" &> /dev/null ; then
    i "unlinked ${error_conf%?}" ; 
  else e "could not unlink $error_conf" ; fi

  if systemctl start apache2.service ; then i "restarted apache!" ; \
    wall -n "[APACHE-FAILFIX.SERVICE]: Restartet Apache!" ; #also send mail
  else e "could not restart apache ;-(" ; fi
}

i() { echo "$1"; }
e() { echo "$1" 1>&2; exit 1; }

main