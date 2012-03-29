# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'rake'
require 'jeweler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "hashyhash"
  gem.homepage = "http://github.com/marktabler/hashyhash"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "mark.tabler@fallingmanstudios.net"
  gem.authors = ["Mark Tabler"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |t|
end

task :default => :spec

