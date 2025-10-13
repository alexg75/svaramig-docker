if [ -z "$1" ]
  then
    echo "No svaramig-web-client version supplied"
    exit 1
fi
readonly IMAGE_VERSION=2
readonly REMOTE_SERVICE_HOST=rp-app
readonly REMOTE_SERVICE_PORT=8080

rm -fR svaramig
cp -a . ../../svaramig-web-client/svaramig .

sed -i.bak "s/XXX_HOST_XXX/${REMOTE_SERVICE_HOST}/g" ./svaramig/src/utils/remote-properties.json
sed -i.bak "s/XXX_PORT_XXX/${REMOTE_SERVICE_PORT}/g" ./svaramig/src/utils/remote-properties.json

docker build --tag=svaramig-web-client:$1.$IMAGE_VERSION .

docker image tag svaramig-web-client:$1.$IMAGE_VERSION rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker image push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION

docker push rp-db:5000/svaramig-web-client:$1.$IMAGE_VERSION
