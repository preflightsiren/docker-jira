FROM base
MAINTAINER Sebastian Cole, sebastian.paris@gmail.com

# Get utilities and update packages
RUN apt-get update
RUN apt-get install -y curl
RUN curl http://downloads.atlassian.com/software/jira/downloads/atlassian-jira-6.1.3-x64.bin > /tmp/jira-6.1.3-x64.bin
# atlassian binary installer
RUN chmod 755 /tmp/jira-6.1.3-x64.bin
# add our response file to the container
ADD ./response.varfile /tmp/response.varfile
# make our data persistent
# -- I'll come back to this
# VOLUME ["/var/atlassian/application-data/jira/data/attachments"]
# run the installer
RUN /tmp/jira-6.1.3-x64.bin -q -varfile /tmp/response.varfile
# ports so we can talk to the container
EXPOSE 8080
EXPOSE 8005

WORKDIR "/opt/atlassian/jira/bin"
ENTRYPOINT ["/opt/atlassian/jira/bin/start-jira.sh","-fg"]
