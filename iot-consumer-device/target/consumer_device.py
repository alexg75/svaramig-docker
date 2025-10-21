from kafka import KafkaConsumer
from json import loads
import messageService
import logger

log = logger.setup_logger("cosnumer-device")

TOPIC_NAME = 'action'
CHANNEL_NAME = 'devices'

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
    log.info(f"sending {message} to {CHANNEL_NAME}")