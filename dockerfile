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

# Create a new user so we don't have to run as root.
RUN useradd -m 6502ASMUser

USER 6502ASMUser

# We will be running in prod by default
ENV NODE_ENV=production

RUN chmod +x /usr/src/app/entrypoint.sh

EXPOSE 3001

CMD ["node", "server.js"]
