FROM jenkins/jenkins:2.479.1-lts-jdk17
ENV JENKINS_HOME="/var/lib/jenkins"
USER root
RUN apt-get -qq update && apt-get -qq install -y lsb-release curl wget iputils-ping telnet
RUN mkdir ${JENKINS_HOME}
RUN useradd jenklins
RUN chown -R jenkins:root ${JENKINS_HOME}

RUN apt update
RUN apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt update
RUN apt-cache policy docker-ce
RUN apt install -y docker-ce

RUN curl -sL https://deb.nodesource.com/setup_23.x -o /tmp/nodesource_setup.sh
RUN bash /tmp/nodesource_setup.sh 
RUN apt install -y nodejs

RUN usermod -aG docker root
RUN usermod -aG docker jenkins
RUN usermod -aG root jenkins

RUN jenkins-plugin-cli --plugins cloudbees-bitbucket-branch-source
RUN jenkins-plugin-cli --plugins blueocean-autofavorite
RUN jenkins-plugin-cli --plugins blueocean-bitbucket-pipeline
RUN jenkins-plugin-cli --plugins blueocean
RUN jenkins-plugin-cli --plugins blueocean-core-js
RUN jenkins-plugin-cli --plugins blueocean-pipeline-editor
RUN jenkins-plugin-cli --plugins blueocean-commons
RUN jenkins-plugin-cli --plugins blueocean-config
RUN jenkins-plugin-cli --plugins blueocean-dashboard
RUN jenkins-plugin-cli --plugins blueocean-display-url
RUN jenkins-plugin-cli --plugins docker-workflow
RUN jenkins-plugin-cli --plugins email-ext
RUN jenkins-plugin-cli --plugins blueocean-events
RUN jenkins-plugin-cli --plugins cloudbees-folder
RUN jenkins-plugin-cli --plugins pipeline-maven
RUN jenkins-plugin-cli --plugins badge
RUN jenkins-plugin-cli --plugins sonar
RUN jenkins-plugin-cli --plugins pipeline-utility-steps
RUN jenkins-plugin-cli --plugins pipeline-stage-view
RUN jenkins-plugin-cli --plugins github-autostatus
RUN jenkins-plugin-cli --plugins nodejs
RUN jenkins-plugin-cli --plugins all-changes
RUN jenkins-plugin-cli --plugins last-changes