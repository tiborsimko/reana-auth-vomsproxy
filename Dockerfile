FROM docker.io/cern/alma9-base:20240801-1

ARG DATE
ARG VERSION

COPY ca.repo /etc/yum.repos.d/ca.repo
COPY wlcg-el9.repo /etc/yum.repos.d/wlcg-el9.repo
COPY RPM-GPG-KEY-wlcg /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg

# hadolint ignore=DL3033
RUN yum install -y epel-release && \
    yum clean all

# hadolint ignore=DL3033
RUN yum install -y \
      ca-policy-egi-core \
      gfal2-all \
      python3-gfal2-util \
      libffi-devel \
      openssl-devel \
      python-pip \
      voms-clients-java \
      wget \
      wlcg-iam-lsc-alice \
      wlcg-iam-lsc-atlas \
      wlcg-iam-lsc-cms \
      wlcg-iam-lsc-lhcb \
      wlcg-iam-vomses-alice \
      wlcg-iam-vomses-atlas \
      wlcg-iam-vomses-cms \
      wlcg-iam-vomses-lhcb && \
    yum clean all

# Add support for ESCAPE VOMS
RUN wget -q https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.vomses -O /etc/vomses/voms-escape.cloud.cnaf.infn.it.vomses
RUN mkdir -p /etc/grid-security/vomsdir/escape \
    && wget -q https://indigo-iam.github.io/escape-docs/voms-config/voms-escape.cloud.cnaf.infn.it.lsc -O /etc/grid-security/vomsdir/escape/voms-escape.cloud.cnaf.infn.it.lsc

LABEL org.opencontainers.image.created="${DATE}"
LABEL org.opencontainers.image.authors='team@reanahub.io'
LABEL org.opencontainers.image.url='https://github.com/reanahub/reana-auth-vomsproxy'
LABEL org.opencontainers.image.documentation='https://github.com/reanahub/reana-auth-vomsproxy/blob/master/README.md'
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.vendor='reanahub'
LABEL org.opencontainers.image.title='Image to either set up VOMS proxy or optionally create it'
LABEL org.opencontainers.image.description='Requires either VOMS proxy file or a valid Grid certificate to create it'
