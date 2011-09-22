require 'ostruct'
require 'net-ldap'
module LDAPLookup
  module Importable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_accessor :ldap_options
      def importable_from_ldap(options)
        @ldap_options = OpenStruct.new(options)
        @ldap_options.fields = OpenStruct.new(options['fields'])
      end

      def from_ldap(filters = {})
        filter = filters.map do |key, value|
          Net::LDAP::Filter.eq(@ldap_options.fields.send(key), value)
        end.inject {|x,y| x&y }

        puts filter

        ldap = Net::LDAP.new(
          host: @ldap_options.server,
          port: @ldap_options.port,
          base: @ldap_options.base_dn)

        ldap.search(:filter => filter) do |match|
          puts match
          item = new()
          @ldap_options.fields.send(:table).map do |key, value|
            item.send("#{key}=", match.send(value).first)
          end
          return item
        end
        return nil
      end
    end
  end
end


