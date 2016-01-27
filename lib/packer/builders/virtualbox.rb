# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class VirtualBoxISO < Builder
      def initialize
        super
        self.data['type'] = VIRTUALBOX_ISO
        self.add_required(
          'iso_checksum',
          'iso_checksum_type',
          'iso_url',
          'communicator'
        )
        self.communicators = %w(none ssh winrm)
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

      def boot_command(commands)
        self.__add_array_of_strings('boot_command', commands)
      end

      def boot_wait(time)
        self.__add_string('boot_wait',time)
      end

      def disk_size(megabytes)
        self.__add_integer('disk_size', megabytes)
      end

      def export_opts(vboxmanage_export_options)
        self.__add_array_of_strings('export_opts', vboxmanage_export_options)
      end

      def floppy_files(files)
        self.__add_array_of_strings('floppy_files', files)
      end

      def format(format)
        self.__add_string('format', format)
      end

      def guest_additions_mode(mode)
        self.__add_string('guest_additions_mode', mode)
      end

      def guest_additions_path(path)
        self.__add_string('guest_additions_path', path)
      end

      def guest_additions_sha256(checksum)
        self.__add_string('guest_additions_sha256', checksum)
      end

      def guest_additions_url(url)
        self.__add_string('guest_additions_url', url)
      end

      def guest_os_type(ostype)
        self.__add_string('guest_os_type', ostype)
      end

      def hard_drive_interface(controllertype)
        self.__add_string('hard_drive_interface', controllertype)
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

      def shutdown_command(command)
        self.__add_string('shutdown_command', command)
      end

      def shutdown_timeout(time)
        self.__add_string('shutdown_timeout', time)
      end

      def vboxmanage(array_of_commands)
        self.__add_array_of_array_of_strings('vboxmanage', array_of_commands)
      end

      def vboxmanage_post(array_of_commands)
        self.__add_array_of_array_of_strings('vboxmanage_post', array_of_commands)
      end

      def virtualbox_version_file(file)
        self.__add_string('virtualbox_version_file', file)
      end

      def vm_name(name)
        self.__add_string('vm_name', name)
      end
    end
  end
end
