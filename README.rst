docker-openssh-win
==================

OpenSSH for Windows running as a Docker container.

This repo aims to run OpenSSH for Windows in a Nano Server container,
without a dependency of PowerShell (Core) and with only 64bit executables.

Since NanoServer has no support for services, for now it runs inside a
Core Server container.

It has all the binaries already in the repo, as a way to remove the
PowerShell dependency.

This is only for testing inside private networks and uses RSA keys.

A new account is created with credentials: test-user/SuperPass123

Generate a new key using::

    ssh-keygen -t rsa -b 1024 storage/ssh_host_rsa_key

To reuse the same key for client authentication::
    cp storage/ssh_host_rsa_key.pub storage/test_user_public_keys
