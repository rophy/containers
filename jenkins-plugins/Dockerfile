FROM jenkins/jenkins:2.422-alpine-jdk17 AS builder
COPY plugins.yaml /usr/share/jenkins/plugins.yaml
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.yaml -d /usr/share/jenkins/ref/plugins

FROM scratch
COPY --from=builder /usr/share/jenkins/ref/plugins /var/jenkins_home/plugins/
