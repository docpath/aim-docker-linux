# Docker Configuration Files for DocPath Access and Identity Management (AIM)

This is a complete example about how to deploy DocPath ® Access and Identity Management in Linux using Docker. The example must be completed with the following files in the same directory as the repositorized files:

- `aim-installer-2.X.Y.jar`: DocPath ® Access and Identity Management Installer.
- `DocPath License File.olc`: License file.
 
## Steps 
To successfully perform the example, follow the steps as indicated below:
- Use the `openjdk:8` image. This is a Linux Debian image with OpenJDK 8 pre-installed.
- Install DocPath ® Access and Identity Management.
- Copy the license file into the image.
- Use port 8080 to receive generation requests.
- Run the `run.sh` file on the container entrypoint. `run.sh` is performed as follows:
  - Starts the license server to allow DocPath ® Access and Identity Management 2 execution.
  - Deploys DocPath ® Access and Identity Management 2.

## Necessary changes
- Change the `aim-installer-2.X.Y.jar` with the corresponding version of DocPath ® Access and Identity Management 2.
- Change the `DocPath_License_File.olc` file with the corresponding license filename.

## How to build and deploy
Now we are going to build the container by executing the following sentence in the same directory where the dockerfile file is located:

`docker build -t docpath/aim .`

**IMPORTANT!** the full stop at the end indicates the directory where the container is located. This is mandatory.

In the installation, the following values has been taken by default:
- -adminusername**admin**
- -adminpassword**admin**
- -databaseserver**MySQL/MariaDB** 
- -databasename**tmp** 
- -databasehost**mysql** 
- -databaseport**3306** 
- -databaseuser**root**
- -databasepassword**root**
- -installlicenseserver 
- -licserverpath **/usr/local/docpath/licenseserver**
- -licserverport**1765**
- -databasecheckconnection**false**

Run the container once it has been built, using the following sentence:

`docker run --name aim --hostname <container_hostname> --detach -p 8080:8080 -e DB_HOST=<db_ip> -e DB_PORT=<db_port> -e DB_USER=<db_user> -e DB_PASS=<db_pass> -e DB_NAME=<db_name> docpath/aim`

The used parameters are:
- `--name`: this parameter indicates the name of the container, in this case dge.
- `--hostname`: this parameter indicates the hostname of the machine with the license.
- `--detach`: this parameter indicates that no messages are displayed in the execution console, silent mode.
- `-p 8080:8080`: this parameter indicates the port of both host machine and aim.
- `docpath/aim`: this is the name assigned previously while building the container.
- `db_port`: Port of the database.
- `db_user`: User with privileges to connect to the database.
- `db_pass`: Password of the user with privileges.
- `db_name`: Name of the database or schema where AIM is installed.
