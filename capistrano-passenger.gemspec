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
  spec.post_install_message = <<PIM
==== Release notes for capistrano-passenger ====
passenger once had only one way to restart: `touch tmp/restart.txt`
Beginning with passenger v4.0.33, a new way was introduced: `passenger-config restart-app`

The new way to restart was not initially practical for everyone,
since for versions of passenger prior to v5.0.10,
it required your deployment user to have sudo access for some server configurations.

capistrano-passenger gives you the flexibility to choose your restart approach, or to rely on reasonable defaults.

If you want to restart using `touch tmp/restart.txt`, add this to your config/deploy.rb:

    set :passenger_restart_with_touch, true

If you want to restart using `passenger-config restart-app`, add this to your config/deploy.rb:

    set :passenger_restart_with_touch, false # Note that `nil` is NOT the same as `false` here

If you don't set `:passenger_restart_with_touch`, capistrano-passenger will check what version of passenger you are running
and use `passenger-config restart-app` if it is available in that version.

If you are running passenger in standalone mode, it is possible for you to put passenger in your
Gemfile and rely on capistrano-bundler to install it with the rest of your bundle.
If you are installing passenger during your deployment AND you want to restart using `passenger-config restart-app`,
you need to set `:passenger_in_gemfile` to `true` in your `config/deploy.rb`.
================================================
PIM
end
