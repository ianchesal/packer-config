# packer-config

[![Gem Version](https://badge.fury.io/rb/packer-config.svg)](http://badge.fury.io/rb/packer-config)

[![Build Status](https://travis-ci.org/ianchesal/packer-config.svg?branch=master)](https://travis-ci.org/ianchesal/packer-config)

A Ruby model that lets you build [Packer](http://packer.io) configurations in Ruby.

Building the Packer JSON configurations in raw JSON can be quite an adventure.
There's limited facilities for variable expansion and absolutely no support for
nice things like comments. I decided it would just be easier to have an object
model to build the Packer configurations in that would easily write to the
correct JSON format. It also saved me having to remember the esoteric Packer
syntax for referencing variables and whatnot in the JSON.

Bonus: you can really go to town with templates when it's all done it Ruby.

## Installation

    gem install packer-config

## Use

    require 'packer-config'

## Requires

* [Packer](http://packer.io) version 0.8.5 or higher

### Builders

The following [Packer builders](http://www.packer.io/docs/templates/builders.html) are currently implemented:

* [amazon-ebs](http://www.packer.io/docs/builders/amazon-ebs.html)
* [amazon-instance](http://www.packer.io/docs/builders/amazon-instance.html)
* [docker](http://www.packer.io/docs/builders/docker.html)
* [virtualbox-iso](http://www.packer.io/docs/builders/virtualbox-iso.html)
* [vmware-vmx](https://www.packer.io/docs/builders/vmware-vmx)
* [vmware-iso](https://www.packer.io/docs/builders/vmware-iso)
* [null](https://www.packer.io/docs/builders/null.html)

[Communicators](https://www.packer.io/docs/templates/communicator.html) are supported as options on Builders in `packer-config`. The `none`, `ssh`, and `winrm` communicators are all available as is the `docker` communicator on the Docker-type builders. `packer-config` will raise an error if you try to use a Communicator type that isn't valid for the Builder.

### Provisioners

The following [Packer provisioners](http://www.packer.io/docs/templates/provisioners.html) are currently implemented:

* [file](http://www.packer.io/docs/provisioners/file.html)
* [shell](http://www.packer.io/docs/provisioners/shell.html)
* [ansible](https://www.packer.io/docs/provisioners/ansible-local.html)
* [chef-client](https://www.packer.io/docs/provisioners/chef-client.html)
* [chef-solo](https://www.packer.io/docs/provisioners/chef-solo.html)
* [salt](https://www.packer.io/docs/provisioners/salt-masterless.html)
* [puppet server](https://www.packer.io/docs/provisioners/puppet-server.html)
* [puppet masterless](https://www.packer.io/docs/provisioners/puppet-masterless.html)
* [windows-restart](https://www.packer.io/docs/provisioners/windows-restart.html)

### Post-Processors

The following [Packer post-processors](http://www.packer.io/docs/templates/post-processors.html) are currently implemented:

* [docker-import](http://www.packer.io/docs/post-processors/docker-import.html)
* [docker-push](http://www.packer.io/docs/post-processors/docker-push.html)
* [docker-save](http://www.packer.io/docs/post-processors/docker-save.html)
* [docker-tag](http://www.packer.io/docs/post-processors/docker-tag.html)
* [vagrant](http://www.packer.io/docs/post-processors/vagrant.html)

## Examples

### Packing a Vagrant Basebox from a CentOS ISO Using VirtualBox

This example is based on the integration test [spec/integration/centos_vagrant_spec.rb](spec/integration/centos_vagrant_spec.rb). It produces a Vagrant Basebox that's provisionable with [Chef](http://www.getchef.com/) and the packer config and provisioning is taken from the [Bento](https://github.com/opscode/bento) project from the OpsCode crew.

    OS = 'centos-6.6'

    pconfig = Packer::Config.new "#{OS}-vagrant.json"
    pconfig.description "#{OS} VirtualBox Vagrant"
    pconfig.add_variable 'mirror', 'http://mirrors.sonic.net/centos/'
    pconfig.add_variable 'my_version', '0.0.1'
    pconfig.add_variable 'chef_version', 'latest'

    builder = pconfig.add_builder Packer::Builder::VIRTUALBOX_ISO
    builder.boot_command ["<tab> text ks=http://#{pconfig.macro.HTTPIP}:#{pconfig.macro.HTTPPort}/#{OS}-ks.cfg<enter><wait>"]
    builder.boot_wait '10s'
    builder.disk_size 40960
    builder.guest_additions_path "VBoxGuestAdditions_#{pconfig.macro.Version}.iso"
    builder.guest_os_type "RedHat_64"
    builder.http_directory "scripts/kickstart"
    builder.iso_checksum '7bb8c1c23a4fdef93e6f0a6347d570e5764d0b38'
    builder.iso_checksum_type 'sha1'
    builder.iso_url "#{pconfig.variable 'mirror'}/6.7/isos/x86_64/CentOS-6.7-x86_64-bin-DVD1.iso"
    builder.output_directory "#{OS}-x86_64-virtualbox"
    builder.shutdown_command "echo 'vagrant'|sudo -S /sbin/halt -h -p"
    builder.communicator "ssh"
    builder.ssh_password "vagrant"
    builder.ssh_port 22
    builder.ssh_username "vagrant"
    builder.ssh_timeout "10000s"
    builder.vboxmanage [
      [
        "modifyvm",
        pconfig.macro.Name,
        "--memory",
        "480"
      ],
      [
        "modifyvm",
        pconfig.macro.Name,
        "--cpus",
        "1"
      ]
    ]
    builder.virtualbox_version_file ".vbox_version"
    builder.vm_name "packer-#{OS}-x86_64"

    provisioner = pconfig.add_provisioner Packer::Provisioner::FILE
    provisioner.source 'scripts/hello.sh'
    provisioner.destination '/home/vagrant/hello.sh'

    provisioner = pconfig.add_provisioner Packer::Provisioner::SHELL
    provisioner.scripts [
      'scripts/fix-slow-dns.sh',
      'scripts/sshd.sh',
      'scripts/vagrant.sh',
      'scripts/vmtools.sh',
      'scripts/chef.sh',
      'scripts/cleanup.sh',
      'scripts/minimize.sh'
    ]
    provisioner.environment_vars [
      "CHEF_VERSION=#{pconfig.variable 'chef_version'}",
      "MY_VERSION=#{pconfig.variable 'my_version'}"
    ]
    provisioner.execute_command "echo 'vagrant' | #{pconfig.macro.Vars} sudo -S -E bash '#{pconfig.macro.Path}'"

    postprocessor = pconfig.add_postprocessor Packer::PostProcessor::VAGRANT
    postprocessor.output File.join('builds', pconfig.macro.Provider, "#{OS}-x86_64-#{pconfig.variable 'my_version'}.box")

    pconfig.validate
    pconfig.build

## Development

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/packer-config/

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

**PLEASE OPEN PULL REQUESTS AGAINST `develop` AND NOT `master`! THANK YOU!**

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `packer-config`? Hit me up at ian.chesal@gmail.com or ianc@squareup.com.
