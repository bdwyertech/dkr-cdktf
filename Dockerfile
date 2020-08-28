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

ENV DEFAULT_TERRAFORM_VERSION=0.13.0

# Install Terraform
RUN apk add curl unzip && AVAILABLE_TERRAFORM_VERSIONS="0.12.29 ${DEFAULT_TERRAFORM_VERSION}" && \
    for VERSION in ${AVAILABLE_TERRAFORM_VERSIONS}; do curl -LOk https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip && \
    mkdir -p /usr/local/bin/tf/versions/${VERSION} && \
    unzip terraform_${VERSION}_linux_amd64.zip -d /usr/local/bin/tf/versions/${VERSION} && \
    ln -s /usr/local/bin/tf/versions/${VERSION}/terraform /usr/local/bin/terraform${VERSION};rm terraform_${VERSION}_linux_amd64.zip;done && \
    ln -s /usr/local/bin/tf/versions/${DEFAULT_TERRAFORM_VERSION}/terraform /usr/local/bin/terraform

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# RUN adduser cdktf -Dh /home/cdktf
# USER cdktf
WORKDIR /cdktf

CMD ["cdktf"]
