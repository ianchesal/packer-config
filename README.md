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

## Examples

### Packing a Vagrant Basebox from a CentOS ISO Using VirtualBox

    require packer-config

    pconfig = Packer::Config.new 'my_config.json'
    pconfig.description "My VirtualBox-ISO build"
    pconfig.add_variable 'mirror', 'http://mirrors.kernel.org/centos'
    pconfig.add_variable 'my_version', '0.0.1'
    pconfig.add_variable 'chef_version', 'provisionerless'

    builder = pconfig.add_builder Packer::Builder::VIRTUALBOX_ISO
    builder.iso_checksum '32c7695b97f7dcd1f59a77a71f64f2957dddf738'
    builder.iso_checksum_type 'sha1'
    builder.iso_url "#{pconfig.variable 'mirror'}/6.5/isos/x86_64/CentOS-6.5-x86_64-bin-DVD1.iso"
    builder.ssh_username 'vagrant'
    builder.ssh_password 'vagrant'
    builder.boot_command ["<tab> text ks=http://#{pconfig.macro 'HTTPIP'}:#{pconfig.macro 'HTTPPort'}/centos-6.5/ks.cfg<enter><wait>"]

    provisioner = pconfig.add_provisioner Packer::Provisioner::FILE
    provisioner.source 'tmp/.bash_profile'
    provisioner.destination '/home/vagrant/.bash_profile'

    provisioner = pconfig.add_provisioner Packer::Provisioner::SHELL
    provisioner.scripts [
        'tmp/vagrant.sh',
        'tmp/runchefsolo.sh',
        'tmp/vmtools.sh',
        'tmp/cleanup.sh',
        'tmp/minimize.sh'
    ]
    provisioner.environment_vars [
        "CHEF_VERSION=\"#{pconfig.variable 'chef_version'}\"",
        "MY_VERSION=\"#{pconfig.variable 'my_version'}\"",
        "MY_NAME"=\"#{pconfig.envvar 'USER'}\""
    ]
    provisioner.execute_command "echo 'vagrant' | #{pconfig.macro 'Vars'} sudo -S -E bash '#{pconfig.macro 'Path'}'"

    postprocessor = pconfig.new_postprocessor Packer::PostProcessor::VAGRANT
    postprocessor.output File.join('builds', pconfig.macro 'Provider', "centos-6.5-x86_64-#{pconfig.variable 'my_version'}.box")

    pconfig.build # Does a #validate and #write

## Development

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/packer-config/

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `packer-config`? Hit me up at ian.chesal@gmail.com or ianc@squareup.com.