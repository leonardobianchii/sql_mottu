FROM mysql:8
ENV MYSQL_ROOT_PASSWORD=mottu123
ENV MYSQL_DATABASE=mottuchal
COPY ProjetoSQLChallenge.sql /docker-entrypoint-initdb.d/
EXPOSE 3306