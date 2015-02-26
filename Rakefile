# Encoding: utf-8
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'fileutils'

RuboCop::RakeTask.new(:lint)

task :default => [:lint, 'test:spec']

task :build => [:lint, 'test:spec', :clean] do
  `gem build packer-config.gemspec`
end

namespace :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir['spec/**/*_spec.rb'].reject{ |f| f['/integration'] }
  end

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/integration/**/*_spec.rb"
  end
end

CLEAN = FileList['deployment_dir/**/*'].exclude('*.txt')

task :clean do
  FileList['spec/integration/packer_cache/*'].each do |f|
    FileUtils.rm_f(f)
  end
  Dir.glob('spec/integration/builds/*').select {|f| File.directory? f}.each do |d|
    FileUtils.rm_rf(d)
  end
end
