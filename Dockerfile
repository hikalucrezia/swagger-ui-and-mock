FROM nginx:alpine

RUN apk update && apk add --no-cache "nodejs>=18.14.1-r0" && apk add --no-cache "tiff>=4.4.0-r4"

LABEL maintainer="fehguy"

ENV API_KEY="**None**" \
    SWAGGER_JSON="/app/swagger.json" \
    PORT="4011" \
    PORT_IPV6="" \
    BASE_URL="/" \
    SWAGGER_JSON_URL=""

COPY ./swagger-files /usr/share/nginx/html/swagger-files
COPY --chown=nginx:nginx --chmod=0666 ./docker/default.conf.template ./docker/cors.conf /etc/nginx/templates/

COPY --chmod=0666 ./dist/* /usr/share/nginx/html/
COPY --chmod=0555 ./docker/docker-entrypoint.d/ /docker-entrypoint.d/
COPY --chmod=0666 ./docker/configurator /usr/share/nginx/configurator

RUN chmod 777 /usr/share/nginx/html/ /etc/nginx/conf.d/ /etc/nginx/conf.d/default.conf /var/cache/nginx/ /var/run/

EXPOSE 4011
