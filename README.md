# zeppelin-docker 
set password in launch.sh script, to setup the zeppelin password for admin, user1, user2, user3
Zeppelin will be launched without root privileges, to prevent any root access to the container from the notebook.
you can customise the root password by adding the SHA-256 hash to the build file.

## to generate a new root password  SHA512
openssl passwd -6 -salt XYZ password
