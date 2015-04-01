# Encoding: utf-8
Dir.glob('tasks/**/*.rake').each(&method(:import))
task :default => [:lint, 'test:spec']
