from kafka import KafkaConsumer
from json import loads
import messageService
import logger
import configUtils

log = logger.setup_logger("consnumer_config")

TOPIC_NAME = 'config'
CHANNEL_NAME = 'config'

consumer = KafkaConsumer(
    TOPIC_NAME,
    bootstrap_servers=['rp-queue2:29092'],
    # auto_offset_reset='earliest',
    auto_offset_reset='latest',
    enable_auto_commit=True,
    # group_id='my-group',
    value_deserializer=lambda x: loads(x.decode('utf-8')))

for message in consumer:
    message = message.value
    messageService.publish_message(CHANNEL_NAME, message)
    configUtils.persist_config_as_json(message)
    log.info(f"sending {message} to {CHANNEL_NAME}")