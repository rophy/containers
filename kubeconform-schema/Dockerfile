FROM python:3.9.18-alpine3.18 AS builder

RUN apk add --no-cache curl git

ENV KUBERNETES_VERSION=1.22.9
RUN mkdir kubernetes-json-schema && cd /tmp \
    && git clone --depth 1 --filter=blob:none --sparse https://github.com/yannh/kubernetes-json-schema \
    && cd kubernetes-json-schema \
    && git sparse-checkout set v${KUBERNETES_VERSION}-standalone-strict \
    && mv v${KUBERNETES_VERSION}-standalone-strict /kubernetes-json-schema/ \
    && git sparse-checkout set v1.23.17-standalone-strict \
    && mv v1.23.17-standalone-strict /kubernetes-json-schema/ \
    && rm -rf /tmp/kubernetes-json-schema

RUN cd /tmp \
    && git clone --depth 1 --filter=blob:none --sparse https://github.com/datreeio/CRDs-catalog.git \
    && cd CRDs-catalog \
    && git sparse-checkout set networking.istio.io \
    && mv networking.istio.io /kubernetes-json-schema/ \
    && git sparse-checkout set security.istio.io \
    && mv security.istio.io /kubernetes-json-schema/ \
    && rm -rf /tmp/CRDs-catalog

RUN cd /tmp \
    && git clone --depth 1 --filter=blob:none --sparse https://github.com/yannh/kubeconform.git \
    && cd kubeconform \
    && git sparse-checkout set scripts \
    && cd scripts \
    && pip install -r requirements.txt \
    && python ./openapi2jsonschema.py https://raw.githubusercontent.com/ricoberger/vault-secrets-operator/main/config/crd/bases/ricoberger.de_vaultsecrets.yaml \
    && mkdir -p /kubernetes-json-schema/ricoberger.de \
    && cp vaultsecret_v1alpha1.json /kubernetes-json-schema/ricoberger.de/

FROM scratch

COPY --from=builder /kubernetes-json-schema /schema
