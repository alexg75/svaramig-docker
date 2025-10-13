if [ -z "$1" ]
  then
    echo "No svaramig-web-service version supplied"
    exit 1
fi
readonly IMAGE_VERSION=1

rm svaramig-web-services.jar 
cp -p /Users/alex/projects/svaramig-web-services/target/svaramig-web-services-$1-SNAPSHOT.jar svaramig-web-services.jar

docker build --tag=svaramig-web-services:$1.$IMAGE_VERSION .

# docker image tag svaramig-web-services:$1.$IMAGE_VERSION rp-db:5000/svaramig-web-services:$1.$IMAGE_VERSION

# docker image push rp-db:5000/svaramig-web-services:$1.$IMAGE_VERSION

# docker push rp-db:5000/svaramig-web-services:$1.$IMAGE_VERSION