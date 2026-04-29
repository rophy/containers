FROM grafana-oss-custom:main-3b7b8bb7ed

ENV GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=victoriametrics-logs-datasource

RUN grafana cli plugins install yesoreyeram-infinity-datasource

COPY --chown=grafana:root victoriametrics-logs-datasource /var/lib/grafana/plugins/victoriametrics-logs-datasource
