
# ---------- Build stage ----------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- Run stage ----------
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar bookservice-0.0.1-SNAPSHOT.jar
EXPOSE 10000
ENTRYPOINT ["java","-jar","bookservice-0.0.1-SNAPSHOT.jar"]