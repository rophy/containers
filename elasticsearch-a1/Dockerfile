FROM elasticsearch:8.18.2

RUN bin/elasticsearch-plugin install --batch \
        analysis-icu \
        analysis-kuromoji \
        ingest-attachment \
        repository-s3 \
        https://get.infini.cloud/elasticsearch/analysis-ik/8.18.2
