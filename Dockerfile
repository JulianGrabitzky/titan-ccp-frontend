FROM nginx:alpine

COPY index.html /var/www/titan-ccp/index.html
COPY dist /var/www/titan-ccp/dist
COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /entrypoint.sh

ENV CONFIGURATION_BASE_URL http://titan-ccp-configuration:80
ENV HISTORY_BASE_URL http://titan-ccp-history:80
ENV STATS_BASE_URL http://titan-ccp-stats:80
ENV KSQL_SERVER_BASE_URL http://ksql-server:8088

ENTRYPOINT ["/entrypoint.sh"]

CMD cp /etc/nginx/nginx.conf /etc/nginx/nginx.tmpl.conf \
    && envsubst '$CONFIGURATION_BASE_URL $HISTORY_BASE_URL $STATS_BASE_URL $KSQL_SERVER_BASE_URL' < /etc/nginx/nginx.tmpl.conf > /etc/nginx/nginx.conf \
    && nginx -g "daemon off;"