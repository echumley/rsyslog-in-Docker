# rsyslog-in-Docker

I created this Docker image through sheer necessity since rsyslog hasn't updated their official Docker images for a fully featured rsyslog container in over 6 years. It's built on a Debian Bullseye Slim OS and runs the rsyslogd service. Enjoy!

## How to Build this Container from Source

```
git clone https://github.com/echumley/rsyslog-in-Docker.git

docker build -t rsyslog-in-docker .
```

## How to Run this Container in Docker

### Docker Pull
```
docker pull echumley/rsyslog-in-docker
```

#### Docker Run
```
docker run -d \
  --name rsyslog-container \
  -p 514:514/udp \
  -p 514:514/tcp \
  -v rsyslog-logs:/var/log \
  --restart unless-stopped \
  echumley/rsyslog-in-docker:latest
```
#### One-liner:
```
docker run -d --name rsyslog-container -p 514:514/udp -p 514:514/tcp -v rsyslog-logs:/var/log --restart unless-stopped rsyslog-in-docker:latest
```

#### Docker Compose
```
services:
  rsyslog-in-docker:
    image: echumley/rsyslog-in-docker:latest  # Use a pre-built image from Docker Hub
    container_name: rsyslog-container  # Optional: Add a custom container name
    ports:
      - "514:514/udp"
      - "514:514/tcp"
    volumes:
      - ./logs:/var/log  # Use Docker volume
    restart: unless-stopped
```

## How to Test this Container

To test if rsyslog collection is working correctly, send it a test log. This command may vary depending on your OS and your method of testing, but it should work with these 2 commands across the board.

```
echo "Test log from remote system" | nc -u -w1 localhost 514
```

Follow this up by checking the volume `rsyslog-logs` for rsyslog entries

```
docker exec -it rsyslog-container cat /var/log/syslog
```
You should see your test message pop up in the logs. If you do, it's working!
