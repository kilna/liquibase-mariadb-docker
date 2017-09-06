FROM kilna/liquibase
LABEL maintainer="Kilna kilna@kilna.com"

ARG mariadb_jdbc_version=2.1.1
ARG mariadb_jdbc_download_url=https://downloads.mariadb.com/Connectors/java/connector-java-${mariadb_jdbc_version}

ENV LIQUIBASE_PORT=${LIQUIBASE_PORT:-3306}\
    LIQUIBASE_CLASSPATH=${LIQUIBASE_CLASSPATH:-/opt/jdbc/mariadb-jdbc.jar}\
    LIQUIBASE_DRIVER=${LIQUIBASE_DRIVER:-org.mariadb.jdbc.Driver}\
    LIQUIBASE_URL=${LIQUIBASE_URL:-'jdbc:mariadb://${HOST}:${PORT}/${DATABASE}'}

COPY test/ /opt/test/
RUN set -e -o pipefail;\
    cd /opt/jdbc;\
    chmod +x /opt/test/run_test.sh;\
    jarfile=mariadb-java-client-${mariadb_jdbc_version}.jar;\
    curl -SOLs ${mariadb_jdbc_download_url}/${jarfile};\
    ls -lA;\
    ln -s ${jarfile} mariadb-jdbc.jar;\
    ls -lA;\
    set | grep -F LIQUIBASE_

