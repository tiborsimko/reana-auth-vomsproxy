FROM cern/cc7-base:20191107

ARG DATE
ARG VERSION

LABEL org.opencontainers.image.created="${DATE}"
LABEL org.opencontainers.image.authors='team@reanahub.io'
LABEL org.opencontainers.image.url='https://github.com/reanahub/reana-auth-vomsproxy'
LABEL org.opencontainers.image.documentation='https://github.com/reanahub/reana-auth-vomsproxy/blob/master/README.md'
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.vendor='reanahub'
LABEL org.opencontainers.image.title='Image to obtain a VOMS proxy'
LABEL org.opencontainers.image.description='Requires valid grid certificate to be mounted'

ADD ca.repo /etc/yum.repos.d/ca.repo
ADD wlcg-centos7.repo /etc/yum.repos.d/wlcg-centos7.repo
ADD RPM-GPG-KEY-wlcg /etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg

RUN yum install -y \
    libffi-devel openssl-devel \
    python-pip gfal2-all gfal2-util \
    CERN-CA-certs voms-clients-java \
    ca-policy-egi-core wlcg-voms-cms \
    wlcg-voms-atlas wlcg-voms-alice \
    wlcg-voms-lhcb
