FROM elasticsearch:7.17.1

RUN bin/elasticsearch-plugin install --batch \
        analysis-icu \
        analysis-kuromoji \
        ingest-attachment \
        repository-s3 \
        https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.17.1/elasticsearch-analysis-ik-7.17.1.zip
