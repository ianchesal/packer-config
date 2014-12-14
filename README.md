# packer-config

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

### Builders

The following [Packer builders](http://www.packer.io/docs/templates/builders.html) are currently implemented:

* [amazon-ebs](http://www.packer.io/docs/builders/amazon-ebs.html)
* [amazon-instance](http://www.packer.io/docs/builders/amazon-instance.html)
* [docker](http://www.packer.io/docs/builders/docker.html)
* [virtualbox-iso](http://www.packer.io/docs/builders/virtualbox-iso.html)

### Provisioners

The following [Packer provisioners](http://www.packer.io/docs/templates/provisioners.html) are currently implemented:

* [file](http://www.packer.io/docs/provisioners/file.html)
* [shell](http://www.packer.io/docs/provisioners/shell.html)

### Post-Processors

The following [Packer post-processors](http://www.packer.io/docs/templates/post-processors.html) are currently implemented:

* [docker-import](http://www.packer.io/docs/post-processors/docker-import.html)
* [docker-push](http://www.packer.io/docs/post-processors/docker-push.html)
* [vagrant](http://www.packer.io/docs/post-processors/vagrant.html)

## Examples

### Packing a Vagrant Basebox from a CentOS ISO Using VirtualBox

This example is based on the integration test [spec/integration/centos_vagrant_spec.rb](spec/integration/centos_vagrant_spec.rb). It produces a Vagrant Basebox that's provisionable with [Chef](http://www.getchef.com/) and the packer config and provisioning is taken from the [Bento](https://github.com/opscode/bento) project from the OpsCode crew.

    OS = 'centos-6.5'

    pconfig = Packer::Config.new "#{OS}-vagrant.json"
    pconfig.description "#{OS} VirtualBox Vagrant"
    pconfig.add_variable 'mirror', 'http://mirrors.kernel.org/centos'
    pconfig.add_variable 'my_version', '0.0.1'
    pconfig.add_variable 'chef_version', 'latest'

    builder = pconfig.add_builder 'virtualbox-iso'
    builder.boot_command ["<tab> text ks=http://#{pconfig.macro.HTTPIP}:#{pconfig.macro.HTTPPort}/#{OS}-ks.cfg<enter><wait>"]
    builder.boot_wait '10s'
    builder.disk_size 40960
    builder.guest_additions_path "VBoxGuestAdditions_#{pconfig.macro.Version}.iso"
    builder.guest_os_type "RedHat_64"
    builder.http_directory "scripts/kickstart"
    builder.iso_checksum '32c7695b97f7dcd1f59a77a71f64f2957dddf738'
    builder.iso_checksum_type 'sha1'
    builder.iso_url "#{pconfig.variable 'mirror'}/6.5/isos/x86_64/CentOS-6.5-x86_64-bin-DVD1.iso"
    builder.output_directory "#{OS}-x86_64-virtualbox"
    builder.shutdown_command "echo 'vagrant'|sudo -S /sbin/halt -h -p"
    builder.ssh_password "vagrant"
    builder.ssh_port 22
    builder.ssh_username "vagrant"
    builder.ssh_wait_timeout "10000s"
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

    provisioner = pconfig.add_provisioner 'file'
    provisioner.source 'scripts/hello.sh'
    provisioner.destination '/home/vagrant/hello.sh'

    provisioner = pconfig.add_provisioner 'shell'
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

    postprocessor = pconfig.add_postprocessor 'vagrant'
    postprocessor.output File.join('builds', pconfig.macro.Provider, "#{OS}-x86_64-#{pconfig.variable 'my_version'}.box")

    pconfig.validate
    pconfig.build

## Development

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/packer-config/

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `packer-config`? Hit me up at ian.chesal@gmail.com or ianc@squareup.com.