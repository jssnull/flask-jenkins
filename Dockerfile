FROM jenkins/jenkins:lts

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY secrets/jenkins-user /run/secrets/jenkins-user
COPY secrets/jenkins-pass /run/secrets/jenkins-pass
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

USER root
RUN apt-get update && \
apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
apt-get update && \
apt-get -y install docker-ce

#install sudo
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*

#Adding jenkins to sudoers list and making an alias for sudo docker
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers \
      && printf '#!/bin/bash\nsudo /usr/bin/docker "$@"' > /usr/local/bin/docker \
      && chmod +x /usr/local/bin/docker
USER jenkins
