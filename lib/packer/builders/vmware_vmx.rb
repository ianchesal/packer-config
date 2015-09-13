module Packer
  class Builder
    class VMWareVMX < Builder
      def initialize
        super
        data['type'] = VMWARE_VMX
        add_required(
          'source_path',
          ['ssh_username', 'communicator']
        )
      end

      def source_path(path)
        __add_string('source_path', path)
      end

      def ssh_username(username)
        __add_string('ssh_username', username)
      end

      def ssh_password(password)
        __add_string('ssh_password', password)
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

      def ssh_key_path(path)
        __add_string('ssh_key_path', path)
      end

      def ssh_port(port)
        __add_integer('ssh_port', port)
      end

      def ssh_skip_request_pty(bool)
        __add_boolean('ssh_skip_request_pty', bool)
      end

      def ssh_wait_timeout(timeout)
        __add_string('ssh_wait_timeout', timeout)
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

      def communicator(comm)
        self.__add_string('communicator', comm)
      end

      def winrm_host(host)
        self.__add_string('winrm_host', host)
      end

      def winrm_port(port)
        self.__add_string('winrm_port', port)
      end

      def winrm_username(username)
        self.__add_string('winrm_username', username)
      end

      def winrm_password(password)
        self.__add_string('winrm_password', password)
      end

      def winrm_timeout(timeout)
        self.__add_string('winrm_timeout', timeout)
      end
    end
  end
end
