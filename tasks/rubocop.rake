require 'rubocop/rake_task'

RuboCop::RakeTask.new(:lint) do |tsk|
  tsk.options = ['-D'] # display cop name
end
