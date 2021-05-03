FROM alpine:3.13.5

ENV AWS_CLI_VERSION 1.19.62
ENV CFN_LINT_VERSION v0.49.0
ENV CFRIPPER_VERSION 1.0.3
ENV CHECKOV_VERSION 2.0.95
ENV CFN_NAG_VERSION 0.7.12

RUN apk update && apk upgrade

ENV PYTHONUNBUFFERED=1
RUN apk --update add --no-cache python3
RUN python3 -m ensurepip
RUN pip3 install --no-compile --no-cache awscli==${AWS_CLI_VERSION}
RUN pip3 install --no-compile --no-cache cfn-lint==${CFN_LINT_VERSION}
RUN pip3 install --no-compile --no-cache cfripper==${CFRIPPER_VERSION}
RUN pip3 install --no-compile --no-cache checkov==${CHECKOV_VERSION}

RUN apk --update add --no-cache \
    ruby ruby-json \
    && echo 'gem: --no-document' > /etc/gemrc
RUN gem install cfn-nag -v ${CFN_NAG_VERSION}