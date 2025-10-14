Mongo
=====
set users:
- start container using the docker-compose.yml in this directoru
- docker exec -it mongo sh
- mongosh --port 27017
- use admin
-  db.createUser(
   {
     user: "root",
     pwd: "example"
     roles: [ 
       { role: "userAdminAnyDatabase", db: "admin" },
       { role: "readWriteAnyDatabase", db: "admin" } 
     ]
   }
 )

- db.system.users.find() to make sure that the user has been created correctly
- exit
- exit
