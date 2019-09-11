FROM openjdk:8
ARG db
ARG schema
ARG url
ARG username
ARG password

ENV DATABASE_NAME=$db
ENV JDBC_SCHEMA=$schema
ENV JDBC_URL=$url
ENV JDBC_USERNAME=$username
ENV JDBC_PASSWORD=$password

RUN mkdir app

COPY target/RGM-User-Service-0.0.1-SNAPSHOT.jar app/RGM-User-Service-0.0.1-SNAPSHOT.jar

WORKDIR app

CMD ["java", "-jar", "RGM-User-Service-0.0.1-SNAPSHOT.jar"]
