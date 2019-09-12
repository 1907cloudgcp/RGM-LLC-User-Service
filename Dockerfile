FROM openjdk:8

RUN mkdir app

COPY target/RGM-User-Service-0.0.1-SNAPSHOT.jar app/RGM-User-Service-0.0.1-SNAPSHOT.jar

WORKDIR app

CMD ["java", "-jar", "RGM-User-Service-0.0.1-SNAPSHOT.jar"]
