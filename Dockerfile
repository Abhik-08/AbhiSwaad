# =====================================================
# 🐳 AbhiSwaad Dockerfile - Java JSP + Servlet + MongoDB
# =====================================================

# 1️⃣ Use the latest Tomcat 10 with JDK 21 (supports Jakarta EE 10)
FROM tomcat:10-jdk21

# 2️⃣ Set working directory
WORKDIR /usr/local/tomcat

# 3️⃣ Remove default ROOT webapp (Tomcat’s welcome page)
RUN rm -rf webapps/ROOT

# 4️⃣ Copy your built WAR file into Tomcat’s webapps folder
#    Maven creates it inside target/ as AbhiSwaad.war (see <finalName> in pom.xml)
COPY ./target/AbhiSwaad.war ./webapps/ROOT.war

# 5️⃣ Expose the port your web app runs on
EXPOSE 8080

# 6️⃣ Start Tomcat
CMD ["catalina.sh", "run"]
