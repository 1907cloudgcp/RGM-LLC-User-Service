FROM maven:3.6.1-jdk-8-alpine

ENV DATABASE_NAME="postgres"
ENV JDBC_SCHEMA="userservice"
ENV JDBC_URL="34.67.56.227"
ENV JDBC_USERNAME="postgres"
ENV JDBC_PASSWORD="yL4afwJexnAlg7OA"

COPY . .

CMD ["java", "-jar", "/target/RGM-User-Service-0.0.1-SNAPSHOT.jar"]
