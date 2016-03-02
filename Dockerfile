FROM gitlab/dind:latest
MAINTAINER Michaël Arnauts <michael.arnauts@destiny.be>

# Change mirror to NL
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/nl.archive.ubuntu.com/g' /etc/apt/sources.list

# Install packages
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
    curl \
    git \
    make \
    php5-cli \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Environmental variables
ENV COMPOSER_HOME /root/composer
ENV COMPOSER_CACHE_DIR=/cache
ENV PATH /root/composer/vendor/bin:$PATH

# Install Composer Asset Plugin
RUN composer global require fxp/composer-asset-plugin:~1

