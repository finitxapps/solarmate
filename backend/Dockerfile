FROM gradle:9.4.0-jdk25 AS builder

WORKDIR /app

COPY . .
RUN gradle bootJar --no-daemon

FROM eclipse-temurin:25-jre
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]