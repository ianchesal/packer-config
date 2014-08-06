# Encoding: utf-8
require 'packer/builder'

module Packer
  class Builder
    class VirtualBox < Builder
      class ISO < VirtualBox
      end
    end
  end
end