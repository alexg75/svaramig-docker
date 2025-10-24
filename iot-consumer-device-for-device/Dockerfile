# FROM python:3.9-slim
FROM python:3.13.9-slim
COPY ./target/*.py .
COPY ./target/requirements.txt .
COPY ./target/*.sh .

RUN chmod 775 ./start-consumers.sh

RUN mkdir /iot
RUN chmod 775 /iot
RUN touch /iot/config.json

# RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt

# Install cron
RUN apt-get update && apt-get install -y cron && apt-get install -y vim && apt-get install bash

CMD ["./start-consumers.sh"]