# Encoding: utf-8
require 'spec_helper'

RSpec.describe Packer::Config do
  it 'can build a centos-6.7 Vagrant base box' do
    CENTOS_VERSION = '6.8'

    pconfig = Packer::Config.new "centos-#{CENTOS_VERSION}-vagrant.json"
    pconfig.description "CentOS #{CENTOS_VERSION} VirtualBox Vagrant"
    pconfig.add_variable 'mirror', 'http://mirrors.sonic.net/centos/'
    pconfig.add_variable 'my_version', '0.0.1'
    pconfig.add_variable 'chef_version', 'latest'

    builder = pconfig.add_builder Packer::Builder::VIRTUALBOX_ISO
    builder.boot_command ["<tab> text ks=http://#{pconfig.macro.HTTPIP}:#{pconfig.macro.HTTPPort}/centos-#{CENTOS_VERSION}-ks.cfg<enter><wait>"]
    builder.boot_wait '10s'
    builder.disk_size 40_960
    builder.guest_additions_path "VBoxGuestAdditions_#{pconfig.macro.Version}.iso"
    builder.guest_os_type "RedHat_64"
    builder.http_directory "scripts/kickstart"
    builder.iso_checksum 'afab3a588cda94cd768826e77ad4db2b5ee7c485'
    builder.iso_checksum_type 'sha1'
    builder.iso_url "#{pconfig.variable 'mirror'}/6/isos/x86_64/CentOS-#{CENTOS_VERSION}-x86_64-bin-DVD1.iso"
    builder.output_directory "centos-#{CENTOS_VERSION}-x86_64-virtualbox"
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
    builder.vm_name "packer-centos-#{CENTOS_VERSION}-x86_64"

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
      "MY_CENTOS_VERSION=#{pconfig.variable 'my_version'}"
    ]
    provisioner.execute_command "echo 'vagrant' | #{pconfig.macro.Vars} sudo -S -E bash '#{pconfig.macro.Path}'"

    postprocessor = pconfig.add_postprocessor Packer::PostProcessor::VAGRANT
    postprocessor.output File.join('builds', pconfig.macro.Provider, "centos-#{CENTOS_VERSION}-x86_64-#{pconfig.variable 'my_version'}.box")

    Dir.chdir('spec/integration')
    expect(pconfig.validate).to be_truthy
    expect(pconfig.build).to be_truthy
    Dir.chdir('../..')
  end
end

