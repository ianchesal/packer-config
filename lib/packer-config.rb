# Encoding: utf-8
require "json"
require 'packer/builder'
require 'packer/provisioner'
require 'packer/postprocessor'

class Packer::Config
  def initialize
    @data = {}
  end
end
