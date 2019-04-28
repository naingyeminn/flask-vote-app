# Using centos image with python
FROM centos:7

LABEL Version 1.0

MAINTAINER Naing Ye Minn <naingyeminn@gmail.com>

# By default, the app uses an internal sqlite db
# Use env variable to force an external SQL engine, e.g. MySQL
# ENV DB_TYPE "mysql"
# ENV DB_HOST "localhost"
# ENV DB_PORT "3306"
# ENV DB_NAME "votedb"
# ENV DB_USER "user"
# ENV DB_PASS "password"

# Set the application directory
WORKDIR /app

# Update OS and install pip
RUN yum install epel-release -y && yum install python-pip -y && yum clean all -y

# Install dependencies
RUN yum install MySQL-python -y && yum clean all -y

# Install requirements.txt
ADD requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

# Copy code from the current folder to /app inside the container
ADD . /app

# clean up local db data
RUN rm -f /app/data/app.db

# Expose the port server listen to
EXPOSE 8080

# run as non-root
RUN chmod -R 777 /app
USER 1001

# Define command to be run when launching the container
CMD ["python", "app.py"]
