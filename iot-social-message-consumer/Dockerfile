# FROM python:3.9-slim
FROM python:3.13.9-slim
COPY ./target/*.py .
COPY ./target/*.sh .
COPY ./target/requirements.txt .

RUN mkdir /slack
RUN chmod 775 /slack

# RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt

# Install cron
RUN apt-get update && apt-get install -y cron && apt-get install -y vim && apt-get install bash

CMD /start-consumers.sh
