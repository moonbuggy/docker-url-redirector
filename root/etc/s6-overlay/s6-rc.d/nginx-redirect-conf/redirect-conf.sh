#! /usr/bin/with-contenv /bin/sh
#shellcheck shell=sh

[ -z "${REDIRECTS+set}" ] \
  && echo "nginx-redirect-conf: info: no redirections to set" \
  && exit

rm -f /etc/nginx/http.d/redirect-*.conf

for redirect in $(echo ${REDIRECTS} | xargs -n1); do
  echo "nginx-redirect-conf: info: redirection: ${redirect%,*} -> ${redirect#*,}"
  sed -E \
    -e "s|SOURCE_DOMAIN|${redirect%,*}|g" \
    -e "s|TARGET_DOMAIN|${redirect#*,}|g" \
    /etc/nginx/http.d/redirect.template > "/etc/nginx/http.d/redirect-${redirect%,*}.conf"
done
