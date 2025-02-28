FROM alpine:3.19

RUN apk update && apk upgrade && apk add nginx --no-cache && apk add openssl

# RUN openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
# -keyout /etc/ssl/private/private.key \
# -out /etc/ssl/certs/certificate.crt \
# -subj "/C=BR/ST=SP/L=Sao Paulo/O=42sp/CN=aperis-p.42.fr"

RUN openssl req -newkey rsa:2048 -nodes \
-keyout /etc/nginx/private.key -x509 -days 365 \
-out /etc/nginx/certificate.pem -subj "/C=BR/ST=SP/L=SãoPaulo/O=42sp/CN=aperis-p.42.fr"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]