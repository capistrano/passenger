# Capistrano::Passenger

Adds a task to restart your application after deployment via Capistrano. Supports Passenger versions 6 and lower.

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'capistrano-passenger'
```

And then execute:

``` bash
$ bundle
```

Or install it yourself as:

``` bash
$ gem install capistrano-passenger
```

## Usage

Add this line to your `Capfile` and `deploy:restart` will be setup to automatically run after `:publishing` is complete:

``` ruby
require 'capistrano/passenger'
```

You can also run the underlying task in isolation:

``` bash
# Restart your Passenger application.
# The restart mechanism used is based on the version of Passenger installed on your server.
$ cap production passenger:restart
# Alternatively:
$ cap production deploy:restart
```

If you want the task to run at a different point in your deployment, require `capistrano/passenger/no_hook` instead of `capistrano/passenger` and then add your own hook in `config/deploy.rb`.  When using this gem in this way, you must use `passenger:restart`--the `deploy:restart` alias is not available.  Example:

``` ruby
# Capfile
require 'capistrano/passenger/no_hook'

# config/deploy.rb
after :some_other_task, :'passenger:restart'
```

Configurable options and their defaults:

``` ruby
set :passenger_roles, :app
set :passenger_restart_runner, :sequence
set :passenger_restart_wait, 5
set :passenger_restart_limit, 2
set :passenger_restart_with_sudo, false
set :passenger_environment_variables, {}
set :passenger_restart_command, 'passenger-config restart-app'
set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }
```

### Restarting Your Passenger Application

In most cases, the default settings should just work for most people. This plugin checks the version of passenger you're running on your server(s) and invokes the appropriate restart mechanism based on that.

`passenger_restart_wait` and `passenger_restart_limit` are passed to the `on` block when restarting the application:

``` ruby
on roles(fetch(:passenger_roles)), in: fetch(:passenger_restart_runner), wait: fetch(:passenger_restart_wait), limit: fetch(:passenger_restart_limit) do
  with fetch(:passenger_environment_variables) do
    # Version-specific restart happens here.
  end
end
```

Note that `passenger_restart_limit` has no effect if you are using the default `passenger_restart_runner` of `:sequence`.  sshkit only looks at it when the runner is `:groups`.

`:passenger_environment_variables` is available if anything about your environment is not available to the user deploying your application. One use-case for this is when `passenger-config` isn't available in your user's `PATH` on the server. You could override it like so:

``` ruby
set :passenger_environment_variables, { :path => '/your/path/to/passenger/bin:$PATH' }
```

### Note for RVM users

https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#_when_the_system_has_multiple_ruby_interpreters descibes how "Once installed, you can run Phusion Passenger’s Ruby parts under any Ruby interpreter you want, even if that Ruby interpreter was not the one you originally installed Phusion Passenger with. [...] There is however one caveat if you happen to be using RVM or RVM gemsets. When you gem install Phusion Passenger using RVM," it is available only to the Ruby version where it was installed.  Therefore, if you are using RVM **AND** passenger was installed via RVM **AND** it was installed under a different version of RVM than `fetch(:rvm_ruby_version)`, you need to `set :passenger_rvm_ruby_version` in your `config/deploy.rb`.

### Note for Standalone Passenger users

If you are running passenger in standalone mode, it is possible for you to put passenger in your Gemfile and rely on capistrano-bundler to install it with the rest of your bundle.  If you are installing passenger during your deployment **AND** you are using the new restart method (see below), you need to set `:passenger_in_gemfile` to `true` in your `config/deploy.rb`.

### Restarting Passenger >= 4.0.33 Applications

Passenger 4.0.33 introduced a new way to restart your application, and thus has some additional configuration options to accomodate for various server environments.

If you need to pass additional/different options to `:passenger_restart_command`, simply override `:passenger_restart_options`.

If you require `sudo` when restarting passenger, set `:passenger_restart_with_sudo` to `true`. **Note**: This option has no effect when restarting Passenger <= 4.0.32 applications.

To opt out of the new way to restart, and use the deprecated approach instead, set `:passenger_restart_with_touch` to `true`.

## Contributing

1. Fork it ( https://github.com/capistrano/passenger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
