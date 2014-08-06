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

Note: This is subject to change!

    require packer-config

    config = Packer::Config.new
    config.new_variable('boxbuilder_version', '0.0.1')
    builder = config.new_builder('virtualbox-iso')
    builder.boot_command = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos-6.5/ks.cfg<enter><wait>"]
    ...
    config.new_postprocessor(type: "vagrant", "../builds/#{Packer::Config::PROVIDER}/centos-6.5-x86_64-#{config.variable_ref('boxbuilder_version')}.box",)
    ...
    config.validate
    config.dump('config.json')

## Development

### Continuous Integration

I'm using Travis CI to build and test on every push to the public github repository. You can find the Travis CI page for this project here: https://travis-ci.org/ianchesal/packer-config/

### Branching in Git

I'm using [git-flow](http://nvie.com/posts/a-successful-git-branching-model/) for development in git via github. I've loved the branching model git-flow proposed from day one and the addon to git makes it very intuitive and easy to follow. I generally don't push my `feature/*` branches to the public repository; I do keep `development` and `master` up to date here though.

### TODO Work

Please see [TODO.md](TODO.md) for the short list of big things I thought worth writing down.

## Contact Me

Questions or comments about `packer-config`? Hit me up at ian.chesal@gmail.com or ianc@squareup.com.