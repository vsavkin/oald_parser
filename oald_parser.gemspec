# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "oald_parser"
  s.version     = '0.2.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Victor Savkin"]
  s.email       = ["avix1000@gmail.com"]
  s.summary     = "Simple parser for online oxford dictionary"
  s.description = "Simple parser for online oxford dictionary"
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rspec"
  s.add_dependency "nokogiri"
  s.files        = Dir.glob("lib/**/*") + %w(README.rdoc Rakefile)
  s.require_path = 'lib'
end