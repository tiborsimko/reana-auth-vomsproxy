# REANA Authentication VOMSproxy

[![image](https://github.com/reanahub/reana-auth-vomsproxy/workflows/CI/badge.svg)](https://github.com/reanahub/reana-auth-vomsproxy/actions)
[![image](https://img.shields.io/badge/discourse-forum-blue.svg)](https://forum.reana.io)
[![image](https://img.shields.io/github/license/reanahub/reana-auth-vomsproxy.svg)](https://github.com/reanahub/reana-auth-vomsproxy/blob/master/LICENSE)

## About

`reana-auth-vomsproxy` provides a container image for either setting up or creating a
VOMS proxy certificate. The container image includes no additional logic or libraries,
just the bare minimum to support the VOMS client. The image is configured to support
authentication for the four experiments at CERN's Large Hadron Collider (ALICE, ATLAS,
CMS, LHCb), as well as [ESCAPE](https://projectescape.eu/) Virtual Organization.

`reana-auth-vomsproxy` was developed for use in the [REANA](http://www.reana.io/)
reusable research data analysis platform.

## Usage

You can use `reana-auth-vomsproxy` as a base image, however it was built to be used as a
sidecar container for user jobs generated via `reana-job-controller` with the single
purpose of establishing the VOMS proxy authentication. The VOMS proxy file set up by the
sidecar is shared with the main job container using common namespace.

The end users can ask for VOMS authentication by means of declaring `voms_proxy:
true` workflow hints. For more information, please see
[here](https://docs.reana.io/advanced-usage/access-control/voms-proxy/#setting-voms-proxy-requirement).

If you would like to try it out locally, you can run:

```console
$ docker run -i -t --rm -v $HOME/foo:/root/.globus/ docker.io/reanahub/reana-auth-vomsproxy:1.0.0 /bin/bash
```

Your local directory `/foo` should contain your `usercert.pem` and `userkey.pem` files.
By default the VOMS client checks the directory `/$HOME/.globus` for the files needed. In
this image that path results in `/root/.globus/`.

Inside the container a VOMS proxy can be obtained by specifying the Virtual Organization,
for example via:

```console
[root@b4d354b65688 /]# voms-proxy-init --voms cms
```

## Configuration

If you would like to use the sidecar to simply expose the VOMS proxy file generated on
the client-side by the user, there is nothing to configure.

If you would like to use the sidecar to create a VOMS proxy certificate from user Grid
credentials, this requires additional information and inputs:

- Grid user certificate: `${HOME}/.globus/usercert.pem`
- Grid user key: `${HOME}/.globus/userkey.pem`
- Grid user password
- Virtual organisation membership (e.g. `cms`)

## Changes

### Version 1.2.1 (2022-07-04)

- Fixes WLCG VOMS support now that WLCG IAM instance is in production.

### Version 1.2.0 (2022-10-11)

- Changes documentation to better expose two usage modes, the client-side and the
  server-side generation of VOMS proxy file.

### Version 1.1.0 (2022-08-10)

- Adds support for ESCAPE VOMS.
- Changes base image to use latest CC7.

### Version 1.0.0 (2020-08-05)

- Initial release

## Development

You can build the `reana-auth-vomsproxy` image by passing the build arguments `DATE` in
the format "YYYY-MM-DD" and `VERSION` as either a semantic versioning and/or the git SHA.

## More information

For more information about [REANA](https://www.reana.io/) reusable research data analysis
platform, please see [its documentation](https://docs.reana.io/).
