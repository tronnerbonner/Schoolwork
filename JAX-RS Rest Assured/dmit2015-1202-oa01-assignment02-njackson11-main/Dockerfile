FROM openliberty/open-liberty:kernel-java11-openj9-ubi

COPY --chown=1001:0  target/dmit2015-assignment02-norrisjackson.war /config/dropins/
COPY --chown=1001:0  server.xml /config

RUN configure.sh