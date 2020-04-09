# reana-auth-vomsproxy

Required information and inputs:

- Grid user certificate: `${HOME}/.globus/usercert.pem`
- Grid user key: `${HOME}/.globus/userkey.pem`
- Grid user password
- Virtual organisation membership (e.g. for CMS: `cms`)

A proxy can then be obtained via:

```shell
voms-proxy-init --voms cms
```

## Building the image

Please provide the following `ARG`s:

- `DATE`: should be in the format "YYYY-MM-DD"
- `VERSION`: either semantic versioning and/or git SHA
