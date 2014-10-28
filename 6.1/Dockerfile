FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r atlassian && useradd -r -g atlassian atlassian

# grab gosu for easy step-down from root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
  && curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
  && chmod +x /usr/local/bin/gosu \
  && apt-get purge -y --auto-remove curl

# grab the jira dependencies
RUN apt-get update && apt-get install -y \
    openjdk-7-jre-headless \
    libtcnative-1 \
  && rm -rf /var/lib/apt/lists/*

ENV JIRA_VERSION 6.1.9

# extract jira
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /opt/atlassian \
  && curl -o /opt/atlassian/atlassian-jira.tar.gz -SL 'http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.1.9.tar.gz' \
  && tar xf /opt/atlassian/atlassian-jira.tar.gz -C /opt/atlassian --strip-components=1 \
  && rm -f /opt/atlassian/atlassian-jira.tar.gz \
  && chown -R atlassian /opt/atlassian \
  && apt-get purge -y --auto-remove curl

ENV JIRA_HOME /var/atlassian/jira
VOLUME /var/atlassian/jira

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
CMD ["jira"]