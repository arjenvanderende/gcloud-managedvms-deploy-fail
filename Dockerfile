# Google NodeJS 0.10.x base Docker image
FROM gcr.io/google_appengine/base
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates && \
    apt-get clean && rm /var/lib/apt/lists/*_*
RUN mkdir /nodejs && curl https://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin
ENV NODE_ENV=production

# Install and start the sample app
WORKDIR /app
ADD package.json start.sh /app/
RUN npm install --production
ADD src /app/src
EXPOSE 8080
ENTRYPOINT /bin/bash start.sh
