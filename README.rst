==============================
REANA Authentication VOMSproxy
==============================

.. image:: https://github.com/reanahub/reana-auth-vomsproxy/workflows/Docker%20Image%20CI/badge.svg
   :target: https://github.com/reanahub/reana-auth-vomsproxy/actions

.. image:: https://badges.gitter.im/Join%20Chat.svg
   :target: https://gitter.im/reanahub/reana?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge

.. image:: https://img.shields.io/github/license/reanahub/reana-auth-vomsproxy.svg
   :target: https://github.com/reanahub/reana-auth-vomsproxy/blob/master/LICENSE

About
=====

``reana-auth-vomsproxy`` provides a container image for creating and renewing a VOMS proxy certificate. The container image
includes no additional logic or libraries, just the bare minimum to support the VOMS client.
The image is configured to support authentication for the four experiments at CERN's Large Hadron Collider (ALICE, ATLAS, CMS, LHCb), as well as `ESCAPE <https://projectescape.eu/>`_ Virtual Organization.

``reana-auth-vomsproxy`` was developed for use in the `REANA <http://www.reana.io/>`_ reusable research data analysis platform.

Usage
=====

You can use ``reana-auth-vomsproxy`` as a base image, however it was built
to be used as a sidecar container with the single purpose of refreshing the proxy certificate.
Once obtained, the certificate is shared with the main container using common namespaces.

The end users can ask for VOMS authentication by means of declaring `voms_proxy: true`, more information `here <http://docs.reana.io/advanced-usage/access-control/voms-proxy/#setting-voms-proxy-requirement>`_.

If you would like to try it locally, you can run:

.. code-block:: console

   $ docker run -i -t --rm -v $HOME/foo:/root/.globus/ reanahub/reana-auth-vomsproxy:1.0.0 /bin/bash

Your local directory ``/foo`` should contain your ``usertcert.pem`` and ``userkey.pem`` files. By default the VOMS client
checks the directory ``/$HOME/.globus`` for the files needed. In this image that path results in ``/root/.globus/``.

Inside the container a proxy can be obtained by specifying the Virtual Organization, for example via:

.. code-block:: console

  $ voms-proxy-init --voms cms

Configuration
=============

Running the container and successfully obtaining a VOMS proxy certificate requires additional information and inputs:

- Grid user certificate: ``${HOME}/.globus/usercert.pem``
- Grid user key: ``${HOME}/.globus/userkey.pem``
- Grid user password
- Virtual organisation membership (e.g. for CMS: ``cms``)

Changes
=======

Version 1.0.0 (2020-08-05)

- Initial release

Development
===========

You can build the ``reana-auth-vomsproxy`` image by passing the build arguments ``DATE`` in
the format "YYYY-MM-DD" and ``VERSION`` as either a semantic versioning and/or the git SHA.

More information
================

For more information about `REANA <http://www.reana.io/>`_ reusable research data
analysis platform, please see `its documentation
<http://docs.reana.io/>`_.

Contributors
============

The list of contributors in alphabetical order:

- `Adelina Lintuluoto <https://orcid.org/0000-0002-0726-1452>`_ <adelina.eleonora.lintuluoto@cern.ch>
- `Clemens Lange <https://orcid.org/0000-0002-3632-3157>`_ <clemens.lange@cern.ch>
- `Elena Gazzarrini <https://orcid.org/0000-0001-5772-5166>`_ <elena.gazzarrini@cern.ch>
