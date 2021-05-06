set +x

mongo -u root -p secret --authenticationDatabase admin <<EOF

use admin

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