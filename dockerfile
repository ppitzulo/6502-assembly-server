FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY server.js entrypoint.sh config.cfg ./

# Install ca65 and ld65 from cc65 package
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libncurses5-dev \
    libncursesw5-dev \
    git \
    && git clone https://github.com/cc65/cc65.git \
    && cd cc65 \
    && make \
    && make install

RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 3001

CMD ["node", "server.js"]
