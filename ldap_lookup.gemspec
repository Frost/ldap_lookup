Gem::Specification.new do |s|
  s.name = "ldap_lookup"
  s.version = "0.0.5"
  s.date = "2012-04-17"
  s.authors = ["Martin Frost"]
  s.email = "frost+github@ceri.se"
  s.summary = "Lookup various stuff from LDAP"
  s.homepage = "https://github.com/Frost/ldap_lookup"
  s.description = "Lookup various stuff from LDAP, for example user information"
  s.files = ["lib/ldap_lookup.rb"]
  s.require_paths = ["lib"]
  s.add_dependency("net-ldap")
  s.add_development_dependency("ruby-debug19")
end
