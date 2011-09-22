# LDAP Lookup
A small gem used for looking up stuff from an LDAP server.

## Example:

    # ldap.yml
    server:  localhost
    port: 9999
    base_dn: ou=Addressbook,dc=localhost,dc=local
    fields:
      first_name: givenName
      last_name: sn
      email: mail

    # ldap_user.rb
    require 'yaml'
    class LdapUser
      include LDAPLookup::Importable
      importable_from_ldap(YAML.load(File.read('./ldap.yml')))

      attr_accessor :first_name, :last_name, :email
    end

    LdapUser.from_ldap(email: 'some.one@example.org')
     => #<LdapUser:0xdeadbeef @first_name="some", @last_name="one", @email="some.one@example.org">
