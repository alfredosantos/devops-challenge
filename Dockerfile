FROM nginx

EXPOSE 443

ADD build/main /usr/bin/goapps
ADD src/entrypoint.sh /entrypoint.sh
ADD src/vhost.conf /etc/nginx/conf.d/default.conf
ADD src/certifile.com.br.cer /etc/nginx/ssl/certifile.com.br.cer
ADD src/certifile.com.br.key /etc/nginx/ssl/certifile.com.br.key

RUN apt update \
    && apt install -y curl \
    && mkdir -p /etc/nginx/ssl \
    && chmod +x /entrypoint.sh

HEALTHCHECK --interval=5s --timeout=3s CMD curl --insecure --fail https://127.0.0.1/ || exit 1

ENTRYPOINT ["/entrypoint.sh"]