FROM ubuntu:16.04
MAINTAINER Michaël Arnauts <michael.arnauts@destiny.be>

# Install packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
    curl \
    git \
    make \
    nodejs \
    npm \
    php-cli \
    php-curl \
    php-xml \
    php-zip \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*

# Install docker
RUN curl -fsSL https://get.docker.com/ | sh

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Fix node link to nodejs
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 99
