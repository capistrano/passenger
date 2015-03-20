# Capistrano::Passenger

Adds a task to restart your application after deployment via Capistrano:

   * cap production deploy:restart

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-passenger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-passenger

## Usage

Adding this line to your `Capfile` will load the default configuration and make the task run after `deploy:publishing`:

    require 'capistrano/passenger'

You can also run the task in isolation:

    $ cap production deploy:restart

Configurable options:

    set :passenger_roles, :app                  # this is default
    set :passenger_restart_runner, :sequence    # this is default
    set :passenger_restart_wait, 5              # this is default
    set :passenger_restart_limit, 2             # this is default

`passenger_restart_wait` and `passenger_restart_limit` are passed to the `on` block when restarting the application:

    on roles(fetch(:passenger_roles)), in: fetch(:passenger_restart_runner), wait: fetch(:passenger_restart_wait), limit: fetch(:passenger_restart_limit) do
      execute :touch, release_path.join('tmp/restart.txt')
    end

Note that `passenger_restart_limit` has no effect if you are using the default `passenger_restart_runner` of `:sequence`.  sshkit only looks at it when the runner is `:group`.

## Contributing

1. Fork it ( https://github.com/capistrano/passenger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
