FROM lscr.io/linuxserver/netbox:3.2.6

RUN \
  echo "**** UPGRADE PIP INSTALLER ****" && \
  pip install --upgrade pip && \
  echo "**** INSTALL BUILD PACKAGES ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    curl \
    cargo \
    gcc \
    git \
    jpeg-dev \
    libffi-dev \
    libxslt-dev \
    libxml2-dev \
    musl-dev \
    openssl-dev \
    postgresql-dev \
    python3-dev \
    zlib-dev && \
  echo "**** INSTALL RUNTIME PACKAGES ****" && \
  apk add --no-cache --upgrade \
    tiff \
    postgresql-client \
    py3-setuptools \
    python3 \
    uwsgi \
    uwsgi-python && \
  echo "**** INSTALL LDAP PACKAGES ****" && \
  apk add --upgrade \
    build-base \
    openldap-dev \
    python2-dev \
    libldap && \
  echo "**** INSTALL LDAP BACK END ****" && \
  pip install python-ldap && \
  pip install django-auth-ldap && \
  echo "**** INSTALL TOPOLOGY VIEWS PLUGIN ****" && \
  pip install netbox-topology-views && \
  echo "**** CLEANUP ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    ${HOME}/.cargo \
    ${HOME}/.cache && \
  echo "**** REMOVING DEFAULT CONFIGURATION FILES ****" && \
  rm -rf defaults 

# replace default configuration files
COPY root/ /
EXPOSE 8000

VOLUME /config
