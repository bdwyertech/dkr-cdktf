FROM node:alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="bdwyertech/cdktf" \
      org.opencontainers.image.version=$VCS_REF \
      org.opencontainers.image.description="Infrastructure as Code with Terraform Cloud Development Kit" \
      org.opencontainers.image.authors="Broadridge - Cloud Platform Engineering <oss@broadridge.com>" \
      org.opencontainers.image.url="https://hub.docker.com/r/bdwyertech/cdktf" \
      org.opencontainers.image.source="https://github.com/bdwyertech/dkr-cdktf.git" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE \
      org.label-schema.name="bdwyertech/cdktf" \
      org.label-schema.description="Infrastructure as Code with Terraform Cloud Development Kit" \
      org.label-schema.url="https://hub.docker.com/r/bdwyertech/cdktf" \
      org.label-schema.vcs-url="https://github.com/bdwyertech/dkr-cdktf.git"\
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE

RUN yarn global add cdktf-cli

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# RUN adduser cdktf -Dh /home/cdktf
# USER cdktf
WORKDIR /cdktf

CMD ["cdktf"]
