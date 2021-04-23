FROM adoptopenjdk/openjdk11:alpine as builder
ADD . /src
WORKDIR /src
RUN ./mvnw package -DskipTests

FROM adoptopenjdk/openjdk11:alpine-jre
COPY --from=builder /src/target/*.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "/app.jar"]