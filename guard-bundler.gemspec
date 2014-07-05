# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'guard/berkshelf/version'

Gem::Specification.new do |s|
  s.name        = 'guard-berkshelf'
  s.version     = Guard::BerkshelfVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['Fallon Dobson']
  s.email       = ['fdobson@articulate.com']
  s.homepage    = 'https://rubygems.org/gems/guard-berkshelf'
  s.summary     = 'Guard gem for Berkshelf'
  s.description = 'Guard::Berkshelf automatically install/update your berkshelf when needed'

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'guard',   '~> 2.3'
  s.add_dependency 'berkshelf', '~> 3.1'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.md]
  s.require_path = 'lib'
end

