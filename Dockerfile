FROM iron/base:edge

RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk update && apk upgrade
RUN apk add git curl nodejs@community

# Install pm2 
RUN npm install -g pm2

# Download App
RUN if [ -d /var/www ]; then rm -rf /var/www; fi
RUN mkdir /var/www && \ 
  cd /var/www && \
  git clone https://github.com/ackstorm/test-nodejs .

# Clean up: keep things small
RUN npm uninstall -g npm
RUN rm -rf /var/cache/apk/*

# Run
WORKDIR /var/www
EXPOSE 8080

ENTRYPOINT ["pm2","start","server.js","-i","0","--no-daemon"]


