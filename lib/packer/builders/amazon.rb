require 'packer/builder'

module Packer
  class Builder
    class Amazon < Builder
      class EBS < Amazon
      end

      class Instance < Amazon
      end
    end
  end
end