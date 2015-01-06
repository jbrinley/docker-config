#
# ElasticSearch Dockerfile
#
# Based on:
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM dockerfile/java:oracle-java7

ENV ES_PKG_NAME elasticsearch-1.3.7

# Install ElasticSearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# install analysis plugins
RUN /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-icu/2.3.0
RUN /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-kuromoji/2.3.0
RUN /elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-smartcn/2.3.0


# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300


