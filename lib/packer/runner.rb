require 'open3'
require 'shellwords'
require 'pty'

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
        status = pty(cmd) do |r,w,pid|
          while !r.eof?
            c = r.getc
            stdout << c
            $stdout.write "#{c}"
          end
          Process.wait(pid)
        end
      end
      raise CommandExecutionError.new(stderr) unless status == 0
      stdout
    end

    def self.exec!(*args)
      cmd = Shellwords.shelljoin(args.flatten)
      logger.debug "Exec'ing: #{cmd}, in: #{Dir.pwd}"
      Kernel.exec cmd
    end

    def self.pty(cmd, &block)
      PTY.spawn(cmd, &block)
      $?.exitstatus
    end
  end
end
