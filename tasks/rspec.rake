require 'rspec/core/rake_task'

namespace :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir['spec/**/*_spec.rb'].reject{ |f| f['/integration'] }
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/*_spec.rb"
  end
end

