# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'herokulogs/version'

Gem::Specification.new do |spec|
  spec.name          = "herokulogs"
  spec.version       = Herokulogs::VERSION
  spec.authors       = ["Thorben Schröder"]
  spec.email         = ["info@thorbenschroeder.de"]
  spec.description   = %q{A tool to get a clear view on log tails of heroku apps}
  spec.summary       = %q{A tool to get a clear view on log tails of heroku apps}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
