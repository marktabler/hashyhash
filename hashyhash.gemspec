# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "hashyhash"
  s.version     = "0.6"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mark Tabler"]
  s.email       = ["mark.tabler@livingsocial.com"]
  s.homepage    = "http://github.com/marktabler/hashyhash"
  s.summary     = "Data organization and lookup system using Ruby hashes"
  s.description = "Data organization and lookup system using Ruby hashes"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"

  s.files        = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
end
