from kafka import KafkaConsumer
from json import loads
import logger
import slackClient

TOPIC_NAME = 'social-message'
log = logger.setup_logger("social-message-consumer")

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
    log.info(message)
    slackClient.send(message)