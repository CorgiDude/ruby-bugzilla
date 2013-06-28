# -*- encoding: utf-8 -*-
lib = File.expand_path('lib/', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)
require 'bugzilla/version'

Gem::Specification.new do |s|
  s.name        = "freer-ruby-bugzilla"
  s.version     = Bugzilla::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Wilcox"]
  s.email       = ["awilcox AT wilcox-techcom"]
  s.homepage    = "https://github.com/CorgiDude/ruby-bugzilla"
  s.summary = %Q{Ruby binding for Bugzilla WebService APIs (Not LGPLv3)}
  s.description = %Q{Provide access to Bugzilla from Ruby}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency("bundler", [">= 1.0"])

  s.add_runtime_dependency "gruff"
  s.add_runtime_dependency "highline"
  s.add_runtime_dependency "rmagick"

  bindir = 'bin'
  s.executables = Dir.glob('bin/*').reject {|x| x =~ /~\Z/}.map {|x| File.basename x}
  s.default_executable = 'bzconsole'

  s.files        = Dir.glob("lib/**/*") + %w(README.rdoc COPYING)
  s.require_path = 'lib'
end
