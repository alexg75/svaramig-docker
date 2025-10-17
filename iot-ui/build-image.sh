readonly IMAGE_VERSION=2
readonly SERVICE_NAME=iot-ui
readonly REGISTRY_HOST=rp-db
readonly REGISTRY_PORT=5000
REMOTE_SERVICE_HOST=rp-lights
REMOTE_SERVICE_PORT=8080

if [ -z "$1" ]; then
  echo "No ${SERVICE_NAME} version supplied"
  exit 1
fi

if [ -z "$2" ]; then
  echo "No environment specified. Default to LIVE"
elif [[ "${2}" = "LOCAL" ]]; then
  echo "setting local values"
  REMOTE_SERVICE_HOST=192.168.178.177
  REMOTE_SERVICE_PORT=8080    
fi
echo Building for backend $REMOTE_SERVICE_HOST:$REMOTE_SERVICE_PORT

rm -fR iot-ui
cp -a . ../../iot-ui  .

rm -fR $PWD/iot-ui/.git
rm $PWD/iot-ui/.gitignore

sed -i.bak "s/XXX_HOST_XXX/${REMOTE_SERVICE_HOST}/g" ./iot-ui/src/utils/remote-properties.json
sed -i.bak "s/XXX_PORT_XXX/${REMOTE_SERVICE_PORT}/g" ./iot-ui/src/utils/remote-properties.json

docker build --tag=$SERVICE_NAME:$1.$IMAGE_VERSION .

if [[ "${2}" = "LOCAL" ]]; then
  docker image tag $SERVICE_NAME:$1.$IMAGE_VERSION $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION.LOCAL
  echo "Local images do not get pushed to the registry"
  exit 0
fi

docker image tag $SERVICE_NAME:$1.$IMAGE_VERSION $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION

docker image push $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION

docker push $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION
