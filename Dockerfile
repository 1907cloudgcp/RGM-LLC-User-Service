FROM openjdk:8-alpine

ARG URL
ARG PASSWORD

ENV DATABASE_NAME=postgres
ENV JDBC_SCHEMA=userservice
ENV JDBC_URL=${URL}
ENV JDBC_USERNAME=postgres
ENV JDBC_PASSWORD=${PASSWORD}

COPY target/RGM-User-Service-0.0.1-SNAPSHOT.jar .

CMD ["java", "-jar", "RGM-User-Service-0.0.1-SNAPSHOT.jar"]
