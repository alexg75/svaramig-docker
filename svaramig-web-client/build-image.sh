if [ -z "$1" ]
  then
    echo "No svaramig-web-client version supplied"
    exit 1
fi
readonly IMAGE_VERSION=1

rm -fR svaramig
cp -a . ../../svaramig-web-client/svaramig .

docker build --tag=svaramig-web-client:$1.$IMAGE_VERSION .

docker image tag svaramig-web-client:$1.$IMAGE_VERSION rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker image push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION
