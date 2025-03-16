# Use an official OpenJDK runtime as the base image
FROM openjdk:17-jdk-slim
# Set the working directory
WORKDIR /app
# Copy the built JAR file
COPY target/spring-petclinic-3.4.0-SNAPSHOT.jar app.jar
# Command to run the application
CMD ["java", "-jar", "app.jar"]
