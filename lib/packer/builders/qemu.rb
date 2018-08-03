# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class Qemu < Builder
      def initialize
        super
        self.data['type'] = QEMU
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

      def boot_command(commands)
        self.__add_array_of_strings('boot_command', commands)
      end

      def boot_wait(time)
        self.__add_string('boot_wait',time)
      end

      def disk_size(megabytes)
        self.__add_integer('disk_size', megabytes)
      end

      def accelerator(accelerator)
        self.__add_string('accelerator', accelerator)
      end

      def format(format)
        self.__add_string('format', format)
      end

      def net_device(net_device)
        self.__add_string('net_device', net_device)
      end

      def floppy_files(files)
        self.__add_array_of_strings('floppy_files', files)
      end

      def qemu_binary(qemu_binary)
        self.__add_string('qemu_binary', qemu_binary)
      end

      def disk_interface(disk_interface)
        self.__add_string('disk_interface', disk_interface)
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

      def qemuargs(array_of_commands)
        self.__add_array_of_array_of_strings('qemuargs', array_of_commands)
      end

      def vm_name(name)
        self.__add_string('vm_name', name)
      end
    end
  end
end
