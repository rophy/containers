FROM elasticsearch:8.19.8

RUN bin/elasticsearch-plugin install --batch \
    analysis-smartcn \
    https://get.infini.cloud/elasticsearch/analysis-ik/8.19.8 \
    https://get.infini.cloud/elasticsearch/analysis-stconvert/8.19.8
