FROM openjdk:8

RUN apt-get update && apt-get install -y apt-utils && apt-get install -y lib32stdc++6 gcc-multilib procps
RUN mkdir -p /required_files
COPY aim-installer-x.y.z.jar /required_files/aim-installer.jar
WORKDIR /required_files
RUN java -jar aim-installer.jar -console -silentmode -install "-solution/usr/local/docpath/AccessIdentityManagement" "-solnameDocPath Access Identity Management Pack" -adminusernameadmin -adminpasswordadmin -databaseserverMySQL -databasenameaim -databasehostlocalhost -databaseport3306 -databaseuserroot -databasepasswordroot -installlicenseserver "-licserverpath/usr/local/docpath/licenseserver" -licserverport1765 -databasecheckconnectionfalse
WORKDIR /
RUN rm -rf /required_files
COPY licenseserver.ini /usr/local/docpath/licenseserver/licenseserver/Configuration/
COPY license.olc /usr/local/docpath/Licenses/
COPY run.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh
EXPOSE 8080
CMD ["/usr/local/bin/run.sh"]

