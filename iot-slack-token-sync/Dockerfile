# FROM python:3.9-slim
FROM python:3.13.9-slim
COPY ./target/*.py .
COPY ./target/requirements.txt .
COPY ./target/token.json .

# RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt

# Install cron
RUN apt-get update && apt-get install -y cron && apt-get install -y vim && apt-get install bash
# TODO see what line does and matbe append it to the line above 
# && rm -rf /var/lib/apt/lists/*

RUN (crontab -l ; echo "* * * * * /usr/local/bin/python3 /refresh-token.py") | sort - | uniq - | crontab -

CMD ["cron","-f"]