# Encoding: utf-8
require "json"
require 'packer/builder'
require 'packer/provisioner'

class Packer::Config
  def initialize
    @data = {}
  end
end
