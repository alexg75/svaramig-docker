from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
import logger
import tokenUtils

log = logger.setup_logger("social-message-consumer")

def send(topic, message):
    access_token = tokenUtils.load_access_token()
    send_with_token(access_token, topic, message)

def send_with_token(access_token, topic, message):
    client = WebClient(token=access_token)
    log.info("Slack Client created")
    m = str(message)
    channel_name = topic
    if ("error" in m):
        channel_name = "errors"

    try:
        client.chat_postMessage(
            channel=channel_name,
            text=m
        )
    except SlackApiError as e:
        log.error(f"Error: {e}")