# Containerized MongoDB with TLS/SSL (Transport Encryption)

## Description

This is a docker-compose setup which will spin up a Docker container with MongoDB. A root user will be initialized, as well as an app (`readWrite`) and Data Scientist (`read`) role. Furthermore, authentication is enabled and a self-signed certificate will be created and enable transport encryption.

## What do I need to do?

Clone the repo to your chosen host. Change the following things:

### Make `data/log/` directory readable, writeable and executable by everyone

This is needed if you want the Docker container to mount out the log file. Run the following command

```bash
sudo chmod 777 data/log/
```

_[What does the command do?](https://explainshell.com/explain?cmd=sudo+chmod+777+data%2Flog%2F)_

### Create self-signed certificate

**Step 1**

Change the Common Name (`CN`) property from `xx.xx.xx.xx` to the public IP address of your host (`127.0.0.1` if you only plan to access your MongoDB from the same host) in the `create_self_signed_certificate.sh` file

```sh
-subj "/CN=xx.xx.xx.xx"
```

**Step 2**

Make `create_self_signed_certificate.sh` executable

```sh
chmod +x create_self_signed_certificate.sh
```

_[What does the command do?](https://explainshell.com/explain?cmd=chmod+%2Bx+create_self_signed_certificate.sh)_

**Step 3**

Create certificate by executing `create_self_signed_certificate.sh`

```sh
./create_self_signed_certificate.sh
```

### Change usernames and password

**Step 1: root user**

Change `root` and `secret` to your desired username and password in `mongo.env`

```yaml
MONGO_INITDB_ROOT_USERNAME=root
MONGO_INITDB_ROOT_PASSWORD=secret
```

... and in `config/init-mongo-users.sh`

```sh
mongo -u root -p secret --authenticationDatabase admin <<EOF
```

**Step 2: app and Data Scientist users**

Change `secret` to your desired passwords for `app` and `dataScientist` users in `config/init-mongo-users.sh`

```sh
db.createUser({
    user: "app",
    pwd: "secret",
    roles: ["readWriteAnyDatabase"]
});

db.createUser({
    user: "dataScientist",
    pwd: "secret",
    roles: ["readAnyDatabase"]
});
```

## Build it 🏗

```sh
docker-compose up
```
