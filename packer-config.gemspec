# Encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'packer/version'

Gem::Specification.new do |spec|
  spec.name          = "packer-config"
  spec.version       = Packer::VERSION
  spec.authors       = ["Ian Chesal", "Fraser Cobb", "Greg Poirier", "Matasano Security", "Greg Diamond"]
  spec.email         = ["ian.chesal@gmail.com"]
  spec.summary       = 'An object model to build packer.io configurations in Ruby.'
  spec.description   = <<-END
Building the Packer JSON configurations in raw JSON can be quite an adventure.
There's limited facilities for variable expansion and absolutely no support for
nice things like comments. I decided it would just be easier to have an object
model to build the Packer configurations in that would easily write to the
correct JSON format. It also saved me having to remember the esoteric Packer
syntax for referencing variables and whatnot in the JSON.
END
  spec.homepage      = "https://github.com/ianchesal/packer-config"
  spec.license       = "Apache 2.0"
  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lowered-expectations", '~> 0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks", "~> 3.0"
  spec.add_development_dependency "fakefs", "~> 0.5"
  spec.add_development_dependency "rubocop", "~> 0.24"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
end
