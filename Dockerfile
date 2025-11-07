# Use Tomcat with the latest JDK (close to 24)
FROM tomcat:10-jdk21

# Copy your WAR file into Tomcat's webapps folder
COPY ./target/AbhiSwaad.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
