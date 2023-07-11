FROM docker.io/cern/cc7-base:20220601-1

ARG DATE
ARG VERSION

LABEL org.opencontainers.image.created="${DATE}"
LABEL org.opencontainers.image.authors='team@reanahub.io'
LABEL org.opencontainers.image.url='https://github.com/reanahub/reana-auth-vomsproxy'
LABEL org.opencontainers.image.documentation='https://github.com/reanahub/reana-auth-vomsproxy/blob/master/README.md'
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.vendor='reanahub'
LABEL org.opencontainers.image.title='Image to either set up VOMS proxy or optionally create it'
LABEL org.opencontainers.image.description='Requires either VOMS proxy file or a valid Grid certificate to create it'

COPY ca.repo /etc/yum.repos.d/ca.repo
COPY wlcg-centos7.repo /etc/yum.repos.d/wlcg-centos7.repo
COPY RPM-GPG-KEY-wlcg /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg

# hadolint ignore=DL3033
RUN yum install -y \
    wget libffi-devel openssl-devel \
    python-pip gfal2-all gfal2-util \
    CERN-CA-certs voms-clients-java \
    ca-policy-egi-core wlcg-voms-cms \
    wlcg-voms-atlas wlcg-voms-alice \
    wlcg-voms-lhcb && \
    yum clean all

# Add support for ESCAPE VOMS
RUN wget https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.vomses -O /etc/vomses/voms-escape.cloud.cnaf.infn.it.vomses
RUN mkdir -p /etc/grid-security/vomsdir/escape \
    && wget https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.lsc -O /etc/grid-security/vomsdir/escape/voms-escape.cloud.cnaf.infn.it.lsc
