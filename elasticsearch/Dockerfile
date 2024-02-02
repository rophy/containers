FROM elasticsearch:7.16.1

RUN bin/elasticsearch-plugin install --batch \
        analysis-icu \
        analysis-kuromoji \
        ingest-attachment \
        repository-s3 \
        https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.16.1/elasticsearch-analysis-ik-7.16.1.zip
