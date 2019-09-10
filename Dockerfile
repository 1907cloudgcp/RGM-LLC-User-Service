FROM openjdk:8
ARG db
ARG schema
ARG url
ARG username
ARG password

ENV DATABASE_NAME $db
ENV JDBC_SCHEMA $schema
ENV JDBC_URL $url
ENV JDBC_USERNAME $username
ENV JDBC_PASSWORD $password

COPY /target/RGM-User-Service-0.0.1-SNAPSHOT.jar .

CMD ["java", "-jar", "/target/RGM-User-Service-0.0.1-SNAPSHOT.jar"]
