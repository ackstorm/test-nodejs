FROM ackstorm/minimal-nodejs

# Download App (Always exec docker build with --no-cache to ensure last code)
RUN if [ -d /var/www ]; then rm -rf /var/www; fi; mkdir /var/www
WORKDIR /var/www
RUN git clone https://github.com/ackstorm/test-nodejs . && \
  git log --pretty=format:'{"commit":"%h", "who": "%an", "when": "%ad", "message": "%s"}'|head -n1 > ./info.json

# Run
WORKDIR /var/www
ENTRYPOINT ["pm2","start","server.js","-i","0","--no-daemon"]

