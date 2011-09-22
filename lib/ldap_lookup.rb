require 'ostruct'
require 'net-ldap'
module LDAPLookup
  module Importable

    def self.included(base)
      base.extend(ClassMethods)
    end

    def self.settings=(settings = {})
      @@settings = OpenStruct.new(settings)
      @@settings.fields = OpenStruct.new(settings['fields'])
    end

    def self.settings
      @@settings
    end

    module ClassMethods
      def from_ldap(filters = {})
        filter = filters.map do |key, value|
          Net::LDAP::Filter.eq(LDAPLookup::Importable.settings.fields.send(key), value)
        end.inject {|x,y| x&y }

        puts filter

        ldap = Net::LDAP.new(
          host: LDAPLookup::Importable.settings.server,
          port: LDAPLookup::Importable.settings.port,
          base: LDAPLookup::Importable.settings.base_dn)

        ldap.search(:filter => filter) do |match|
          puts match
          item = new()
          LDAPLookup::Importable.settings.fields.send(:table).map do |key, value|
            item.send("#{key}=", match.send(value).first)
          end
          return item
        end
        return nil
      end
    end
  end
end


