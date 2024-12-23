FROM grafana/grafana-oss:11.3.2-ubuntu

RUN grafana cli plugins install yesoreyeram-infinity-datasource && \
curl -fsSL -o /tmp/victiametrics-logs-datasource.tar.gz https://github.com/VictoriaMetrics/victorialogs-datasource/releases/download/v0.13.2/victoriametrics-logs-datasource-v0.13.2.tar.gz && \
    tar -xzf /tmp/victiametrics-logs-datasource.tar.gz -C /var/lib/grafana/plugins/ && \
    rm -f /tmp/victiametrics-logs-datasource.tar.gz
