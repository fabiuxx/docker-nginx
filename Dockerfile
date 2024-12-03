FROM ubuntu:22.04

# Instalar dependencias.
RUN apt update \
    && apt install -y curl nginx supervisor \
    && apt autoclean

# Configurar nginx.
RUN mkdir -p /var/log/nginx
COPY config/nginx.conf /etc/nginx/
COPY config/sites-enabled/test.conf /etc/nginx/sites-enabled/default

# Configurar supervisord.
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT [ "supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]