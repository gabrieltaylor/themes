FROM nginx:1.16.1-alpine

COPY conf/nginx.conf /etc/nginx/
COPY conf/conf.d/default.conf /etc/nginx/conf.d/
COPY themes /app/themes

ENTRYPOINT ["nginx -g 'daemon off'"]
