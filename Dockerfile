FROM iron/base:edge

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk update && apk upgrade
RUN apk add git nodejs@community

# Install pm2 
RUN npm install -g pm2

# Clean up: keep things small
RUN npm uninstall -g npm
RUN rm -rf /var/cache/apk/*

# Download App
RUN if [ -d /var/www ]; then rm -rf /var/www; fi; mkdir /var/www
WORKDIR /var/www
RUN git clone https://github.com/ackstorm/test-nodejs . && \
  git log --pretty=format:'{"commit":"%h", "who": "%an", "when": "%ad", "message": "%s"}'|head -n1 > ./info.json

# Run
WORKDIR /var/www
ENTRYPOINT ["pm2","start","server.js","-i","0","--no-daemon"]

