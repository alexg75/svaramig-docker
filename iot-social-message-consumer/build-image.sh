readonly IMAGE_VERSION=1
readonly SERVICE_NAME=iot-social-message-consumer
readonly REGISTRY_HOST=rp-db
readonly REGISTRY_PORT=5000


if [ -z "$1" ]; then
  echo "No ${SERVICE_NAME} version supplied"
  exit 1
fi

rm -fR target
mkdir target
cp -p ../../iot-social-message-consumer/consumer-slack-token.py  ./target
cp -p ../../iot-social-message-consumer/consumer-social-message.py  ./target
cp -p ../../iot-social-message-consumer/slackClient.py  ./target
cp -p ../../iot-social-message-consumer/start-consumers.sh  ./target
cp -p ../../iot-social-message-consumer/requirements.txt  ./target
cp -p ../../iot-social-message-consumer/token.json  ./target
cp -p ../../iot-common/logger.py ./target
cp -p ../../iot-common/tokenUtils.py ./target

chmod 775 ./target/start-consumers.sh

docker build --tag=$SERVICE_NAME:$1.$IMAGE_VERSION .

if [[ "${2}" = "LOCAL" ]]; then
  docker image tag $SERVICE_NAME:$1.$IMAGE_VERSION $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION.LOCAL
  echo "Local images do not get pushed to the registry"
  exit 0
fi

docker image tag $SERVICE_NAME:$1.$IMAGE_VERSION $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION

docker image push $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION

docker push $REGISTRY_HOST:$REGISTRY_PORT/$SERVICE_NAME:$1.$IMAGE_VERSION
