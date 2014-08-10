# Integration Testing packer-config

You can run the integration tests via the Rakefile with:

    bundle exec rake test:integration

The integration tests actually run Packer builds and can take some time to run. As of now I've only run them on an OS X system but, in theory, they should run on any system where the `packer` command and VirtualBox are available.

The provisioning and kickstart scripts are largely taken from the [OpsCode Bento](https://github.com/opscode/bento) project which is most awesome and you should check it out.

## Requirements

* [Packer.io](http://www.packer.io/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)