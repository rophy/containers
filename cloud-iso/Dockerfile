FROM alpine AS fetch
ARG ISO_URL
RUN if [ -z "${ISO_URL}" ]; then \
      echo "ERROR: ISO_URL build arg is required" && exit 1; \
    fi && \
    wget -O /iso "${ISO_URL}"

FROM scratch
COPY --from=fetch /iso /
