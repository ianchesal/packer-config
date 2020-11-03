# Encoding: utf-8

module Packer
  class Macro
    def method_missing(method_name, *args)
      name = method_name.to_s.slice(0,1).capitalize + method_name.to_s.slice(1..-1)
      "{{ .#{name} }}"
    end


    def respond_to_missing?(method_name, include_private = false)
      true
    end

    def respond_to?(symbol, include_private: false)
      # We literally respond to everything...
      true
    end
  end
end
