# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/passenger/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-passenger"
  spec.version       = Capistrano::Passenger::VERSION
  spec.authors       = ["Isaac Betesh"]
  spec.email         = ["iybetesh@gmail.com"]
  spec.summary       = %q{Passenger support for Capistrano 3.x}
  spec.description   = %q{Passenger support for Capistrano 3.x}
  spec.homepage      = "https://github.com/capistrano/passenger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
