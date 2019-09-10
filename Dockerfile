FROM openjdk:8

COPY . .

CMD ["java", "-jar", "/target/RGM-User-Service-0.0.1-SNAPSHOT.jar"]
