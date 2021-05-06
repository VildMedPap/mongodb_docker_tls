openssl req -newkey rsa:2048 -new -x509 -days 365 -nodes -out config/ssl/mongodb-cert.crt -keyout config/ssl/mongodb-cert.key -subj "/CN=xx.xx.xx.xx"
cat config/ssl/mongodb-cert.key config/ssl/mongodb-cert.crt > config/ssl/mongodb.pem
rm config/ssl/mongodb-cert.key config/ssl/mongodb-cert.crt