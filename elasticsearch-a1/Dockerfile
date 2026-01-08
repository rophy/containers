FROM elasticsearch:8.18.8

RUN bin/elasticsearch-plugin install --batch \
        analysis-icu \
        analysis-kuromoji \
        https://get.infini.cloud/elasticsearch/analysis-ik/8.18.8
