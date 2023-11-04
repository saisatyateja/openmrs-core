FROM maven:3.6.3-openjdk-11-slim as build
RUN  apt update 
WORKDIR /openmrs-core
COPY .  /openmrs-core/
RUN mvn package


FROM tomcat:9.0.82-jdk11
COPY --from=build /openmrs-core/webapp/target/openmrs.war /usr/local/tomcat/webapps/
EXPOSE 8080
WORKDIR /usr/local/tomcat/bin
CMD ["catalina.sh","run"]
