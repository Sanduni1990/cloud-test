FROM openjdk:8u212-jdk-slim
ENV PORT 8080
COPY knote-java-master/*.jar /opt/app.jar
WORKDIR /opt
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar
