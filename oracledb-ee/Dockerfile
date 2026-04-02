FROM container-registry.oracle.com/database/enterprise:19.3.0.0

USER root

# Fix CVE-2021-44228, CVE-2021-45046 (log4j-core in TFA)
# Remove log4j-core-2.9.1.jar from TFA WAR and jlib directory
ENV JAVA_HOME=/opt/oracle/product/19c/dbhome_1/jdk
ENV PATH=$JAVA_HOME/bin:$PATH
RUN yum install -y zip && yum clean all && \
    zip -d /opt/oracle/product/19c/dbhome_1/suptools/tfa/release/tfa_home/jlib/tfa.war \
      WEB-INF/lib/log4j-core-2.9.1.jar && \
    rm -f /opt/oracle/product/19c/dbhome_1/suptools/tfa/release/tfa_home/jlib/log4j-core-2.9.1.jar

# Fix CVE-2021-44228, CVE-2021-45046 (log4j-core in PGX WAR)
# Fix CVE-2025-31651, CVE-2025-24813, CVE-2024-56337, CVE-2024-52316,
#     CVE-2024-50379, CVE-2020-1938, CVE-2025-66614 (tomcat-embed-core)
# Property Graph (PGX) is not used; removing the entire component
RUN rm -rf /opt/oracle/product/19c/dbhome_1/md/property_graph

# Fix CVE-2022-0839 (liquibase-core in SQL Developer)
# SQL Developer is a GUI tool not needed in a container
RUN rm -rf /opt/oracle/product/19c/dbhome_1/sqldeveloper

# Fix CVE-2018-3183 (OPatch JRE 1.8.0_181)
# Replace with DB home JDK 1.8.0_201 which includes the fix
RUN rm -rf /opt/oracle/product/19c/dbhome_1/OPatch/jre && \
    ln -s /opt/oracle/product/19c/dbhome_1/jdk/jre \
          /opt/oracle/product/19c/dbhome_1/OPatch/jre

USER oracle
