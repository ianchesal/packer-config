# Encoding: utf-8
require 'packer/builder'
require 'packer/dataobject'

module Packer
  class Builder < Packer::DataObject
    class Amazon < Builder
      def initialize
        super
        self.add_required(
          'ami_name',
          'instance_type',
          'region',
          'source_ami',
          'communicator'
        )
        self.communicators = %w(none ssh winrm)
      end

      def access_key(key)
        self.__add_string('access_key', key)
      end

      def ami_name(name)
        self.__add_string('ami_name', name)
      end

      def instance_type(type)
        self.__add_string('instance_type', type)
      end

      def region(name)
        self.__add_string('region', name)
      end

      def source_ami(name)
        self.__add_string('source_ami', name)
      end

      def secret_key(key)
        self.__add_string('secret_key', key)
      end

      def ami_block_device_mappings(mappings)
        self.__add_array_of_hashes('ami_block_device_mappings', mappings)
      end

      def ami_description(description)
        self.__add_string('ami_description', description)
      end

      def ami_groups(groups)
        self.__add_array_of_strings('ami_groups', groups)
      end

      def ami_product_codes(codes)
        self.__add_array_of_strings('ami_product_codes', codes)
      end

      def ami_regions(regions)
        self.__add_array_of_strings('ami_regions', regions)
      end

      def ami_users(users)
        self.__add_array_of_strings('ami_users', users)
      end

      def ami_virtualization_type(type)
        self.__add_string('ami_virtualization_type', type)
      end

      def associate_public_ip_address(bool)
        self.__add_boolean('associate_public_ip_address', bool)
      end

      def availability_zone(zone)
        self.__add_string('availability_zone', zone)
      end

      def enhanced_networking(bool)
        self.__add_boolean('enhanced_networking', bool)
      end

      def iam_instance_profile(profile)
        self.__add_string('iam_instance_profile', profile)
      end

      def launch_block_device_mappings(mappings)
        self.__add_array_of_hashes('launch_block_device_mappings', mappings)
      end

      def run_tags(tags)
        self.__add_hash('run_tags', tags)
      end

      def security_group_id(id)
        self.__add_string('security_group_id', id, %w[security_group_ids])
      end

      def security_group_ids(ids)
        self.__add_array_of_strings('security_group_ids', ids, %w[security_group_id])
      end

      def subnet_id(id)
        self.__add_string('subnet_id', id)
      end

      def tags(tags)
        self.__add_hash('tags', tags)
      end

      def temporary_key_pair_name(name)
        self.__add_string('temporary_key_pair_name', name)
      end

      def user_data(data)
        self.__add_string('user_data', data)
      end

      def user_data_file(file)
        self.__add_string('user_data_file', file)
      end

      def vpc_id(id)
        self.__add_string('vpc_id', id)
      end

      class EBS < Amazon
        def initialize
          super
          self.data['type'] = AMAZON_EBS
        end
      end

      class Instance < Amazon
        def initialize
          super
          self.data['type'] = AMAZON_INSTANCE
          self.add_required(
            'account_id',
            's3_bucket',
            'x509_cert_path',
            'x509_key_path'
          )
        end

        def account_id(id)
          self.__add_string('account_id', id)
        end

        def s3_bucket(bucket)
          self.__add_string('s3_bucket', bucket)
        end

        def x509_cert_path(path)
          self.__add_string('x509_cert_path', path)
        end

        def x509_key_path(path)
          self.__add_string('x509_key_path', path)
        end

        def bundle_destination(directory)
          self.__add_string('bundle_destination', directory)
        end

        def bundle_prefix(prefix)
          self.__add_string('bundle_prefix', prefix)
        end

        def bundle_upload_command(command)
          self.__add_string('bundle_upload_command', command)
        end

        def bundle_vol_command(command)
          self.__add_string('bundle_vol_command', command)
        end

        def x509_upload_path(path)
          self.__add_string('x509_upload_path', path)
        end
      end
    end
  end
end
