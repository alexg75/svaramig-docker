# FROM python:3.9-slim
FROM python:3.13.9-slim
COPY ./target/*.py .
COPY ./target/requirements.txt .

# RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt

# Install cron
RUN apt-get update && apt-get install -y cron && apt-get install -y vim && apt-get install bash

RUN (crontab -l ; echo "0 */6 * * * /usr/local/bin/python3 /iot_producer_config.py") | sort - | uniq - | crontab -
# RUN (crontab -l ; echo "* * * * * /usr/local/bin/python3 /iot_producer_config.py") | sort - | uniq - | crontab -

CMD ["cron","-f"]
