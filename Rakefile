require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:lint)
RSpec::Core::RakeTask.new(:spec)

task :default => [:test]

desc "Run all tests and validations"
task :test => [:lint, :spec]

task :build => [:test] do
  `gem build packer-config.gemspec`
end