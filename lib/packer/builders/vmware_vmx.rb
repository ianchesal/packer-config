module Packer
  class Builder
    class VMWareVMX < Builder
      def initialize
        super
        data['type'] = VMWARE_VMX
        add_required(
          'source_path',
          'communicator'
        )
        self.communicators = %w(none ssh winrm)
      end

      def source_path(path)
        __add_string('source_path', path)
      end

      def boot_command(commands)
        __add_array_of_strings('boot_command', commands)
      end

      def boot_wait(wait)
        __add_string('boot_wait', wait)
      end

      def floppy_files(files)
        __add_array_of_strings('floppy_files', files)
      end

      def fusion_app_path(app_path)
        __add_string('fusion_app_path', app_path)
      end

      def headless(bool)
        __add_boolean('headless', bool)
      end

      def http_directory(path)
        __add_string('http_directory', path)
      end

      def http_port_min(port)
        __add_integer('http_port_min', port)
      end

      def http_port_max(port)
        __add_integer('http_port_max', port)
      end

      def output_directory(path)
        __add_string('output_directory', path)
      end

      def shutdown_command(command)
        __add_string('shutdown_command', command)
      end

      def shutdown_timeout(timeout)
        __add_string('shutdown_timeout', timeout)
      end

      def skip_compaction(bool)
        __add_boolean('skip_compaction', bool)
      end

      def vm_name(name)
        __add_string('vm_name', name)
      end

      def vmx_data(data_hash)
        __add_hash('vmx_data', data_hash)
      end

      def vmx_data_post(data_hash)
        __add_hash('vmx_data_post', data_hash)
      end

      def vnc_port_min(port)
        __add_integer('vnc_port_min', port)
      end

      def vnc_port_max(port)
        __add_integer('vnc_port_max', port)
      end
    end
  end
end
