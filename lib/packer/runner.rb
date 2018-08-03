require 'open3'
require 'shellwords'

module Packer
  class Runner
    class CommandExecutionError < StandardError
    end

    def self.run!(*args, quiet: false)
      cmd = Shellwords.shelljoin(args.flatten)
      status = 0
      stdout = ''
      stderr = ''
      if quiet
        # Run without streaming std* to any screen
        stdout, stderr, status = Open3.capture3(cmd)
      else
        # Run but stream as well as capture stdout to the screen
        # see: http://stackoverflow.com/a/1162850/83386
        Open3.popen3(cmd) do |_std_in, std_out, std_err, thread|
          # read each stream from a new thread
          Thread.new do
            until (raw = std_out.getc).nil? do
              stdout << raw
              $stdout.write raw.to_s
            end
          end
          Thread.new do
            until (raw_line = std_err.gets).nil? do
              stderr << raw_line
            end
          end

          thread.join # don't exit until the external process is done
          status = thread.value
        end
      end
      # rubocop:disable Style/NumericPredicate
      raise CommandExecutionError.new(stderr) unless status == 0
      stdout
      # rubocop:enable Style/NumericPredicate
    end

    def self.exec!(*args)
      cmd = Shellwords.shelljoin(args.flatten)
      logger.debug "Exec'ing: #{cmd}, in: #{Dir.pwd}"
      Kernel.exec cmd
    end
  end
end
