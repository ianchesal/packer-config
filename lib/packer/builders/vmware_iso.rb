# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class VMWareISO < Builder
      def initialize
        super
        self.data['type'] = VMWARE_ISO
        self.add_required(
          'iso_checksum',
          'iso_checksum_type',
          'iso_url',
          'ssh_username'
        )
      end

      def iso_checksum(checksum)
        self.__add_string('iso_checksum', checksum)
      end

      def iso_checksum_type(type)
        self.__add_string('iso_checksum_type', type)
      end

      def iso_url(url)
        self.__add_string('iso_url', url, %w[iso_urls])
      end

      def iso_urls(urls)
        self.__add_array_of_strings('iso_urls', urls, %[iso_url])
      end

      def ssh_username(username)
        self.__add_string('ssh_username', username)
      end

      def boot_command(commands)
        self.__add_array_of_strings('boot_command', commands)
      end

      def boot_wait(time)
        self.__add_string('boot_wait',time)
      end

      def disk_size(megabytes)
        self.__add_integer('disk_size', megabytes)
      end

      # 0 - create a growable virtual disk contained in a single file (monolithic sparse).
      # 1 - create a growable virtual disk split into 2GB files (split sparse).
      # 2 - create a preallocated virtual disk contained in a single file (monolithic flat).
      # 3 - create a preallocated virtual disk split into 2GB files (split flat).
      # 4 - create a preallocated virtual disk compatible with ESX server (VMFS flat).
      # 5 - create a compressed disk optimized for streaming.
      def disk_type_id(tid)
        self.__add_string('disk_type_id',tid)
      end

      def floppy_files(files)
        self.__add_array_of_strings('floppy_files', files)
      end

      def fusion_app_path(app_path)
        self.__add_string('fusion_app_path',app_path)
      end

      def guest_os_type(ostype)
        self.__add_string('guest_os_type', ostype)
      end

      def headless(bool)
        self.__add_boolean('headless', bool)
      end

      def http_directory(directory)
        self.__add_string('http_directory', directory)
      end

      def http_port_min(port_number)
        self.__add_integer('http_port_min', port_number)
      end

      def http_port_max(port_number)
        self.__add_integer('http_port_max', port_number)
      end

      def output_directory(directory)
        self.__add_string('output_directory', directory)
      end

      def remote_cache_datastore(cache)
        self.__add_string('remote_cache_datastore', cache)
      end

      def remote_cache_directory(cache_directory)
        self.__add_string('remote_cache_directory', cache_directory)
      end

      def remote_datastore(datastore)
        self.__add_string('remote_datastore', datastore)
      end

      def remote_host(host)
        self.__add_string('remote_host', host)
      end

      def remote_password(passwd)
        self.__add_string('remote_password', passwd)
      end

      def remote_type(typ)
        self.__add_string('remote_type', typ)
      end

      def remote_username(username)
        self.__add_string('remote_username', username)
      end

      def shutdown_command(command)
        self.__add_string('shutdown_command', command)
      end

      def shutdown_timeout(time)
        self.__add_string('shutdown_timeout', time)
      end

      def skip_compaction(bool)
        self.__add_boolean('skip_compaction', bool)
      end

      def ssh_host(host)
        self.__add_string('ssh_host', host)
      end

      def ssh_host_port_min(port_number)
        self.__add_integer('ssh_host_port_min', port_number)
      end

      def ssh_host_port_max(port_number)
        self.__add_integer('ssh_host_port_max', port_number)
      end

      def ssh_key_path(path)
        self.__add_string('ssh_key_path', path)
      end

      def ssh_password(password)
        self.__add_string('ssh_password', password)
      end

      def ssh_port(port_number)
        self.__add_integer('ssh_port', port_number)
      end

      def ssh_skip_request_pty(bool)
        self.__add_boolean('ssh_skip_request_pty', bool)
      end

      def ssh_wait_timeout(time)
        self.__add_string('ssh_wait_timeout', time)
      end

      def tools_upload_flavor(flavor)
        self.__add_string('tools_upload_flavor', flavor)
      end

      def tools_upload_path(path)
        self.__add_string('tools_upload_path', path)
      end

      def version(version)
        self.__add_string('version', version)
      end

      def vm_name(name)
        self.__add_string('vm_name', name)
      end

      def vmdk_name(name)
        self.__add_string('vmdk_name', name)
      end

      def vmx_data(data)
        self.__add_hash('vmx_data', data)
      end

      def vmx_data_post(data)
        self.__add_hash('vmx_data_post', data)
      end

      def vmx_template_path(path)
        self.__add_string('vmx_template_path', path)
      end

      def vnc_port_min(port)
        self.__add_integer('vnc_port_min', port)
      end

      def vnc_port_max(port)
        self.__add_integer('vnc_port_max', port)
      end
    end
  end
end
