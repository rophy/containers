FROM bitnami/java:17.0.8-7-debian-11-r49

ADD https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.13/jenkins-plugin-manager-2.12.13.jar /jenkins/jenkins-plugin-manager.jar

COPY plugins.yaml /usr/share/jenkins/plugins.yaml

ENV JENKINS_VERSION=2.422
RUN java -jar /jenkins/jenkins-plugin-manager.jar -f /usr/share/jenkins/plugins.yaml -d /usr/share/jenkins/ref/plugins
