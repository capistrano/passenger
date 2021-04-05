# Not released yet

# 0.2.1 (5 Apr 2021)
* Made passenger-status use the same Command Map prefixes as passenger and passenger-config.
  Even though it's not used in this project by default, it may be useful in some cases,
  such as when someone needs to determine the passenger instance ID
* Only run passenger commands from the release_path if passenger is in the Gemfile.
  Otherwise, it may be in a gemset that conflicts with a .ruby-gemset file in release_path.

# 0.2.0 (8 Dec 2015)
* Added support for passenger versions > 5.0.20

# 0.1.1 (30 June 2015)
* Bug fixes:
  * When detecting passenger version, we account for the fact the the version may not be on the first line of the captured output (@pzgz, capistrano/passenger#20)
  * When executing the restart command without sudo, we make sure the first argument to execute is still a Symbol so that the command is executed in the appropriate directory (@FooBarWidget, capistrano/passenger#27)

# 0.1.0 (3 June 2015)

* BREAKING CHANGES
  * On version of passenger that support both restarting by touch and restarting with passenger-config, the default is to use passenger-config.  set :passenger_restart_with_touch to true to opt out of this.
* Bug fixes:
  * Restored support for CHRuby (@aeons, capistrano/passenger#16)
  * Restored support for passenger installed by bundle (@betesh, capistrano/passenger#10)

# 0.0.5 (12 Apr 2015)

* Bug fixes:
  * When restarting passenger without sudo, made it nevertheless use command map (@betesh, capistrano/passenger#8)
  * We now check whether passenger is installed outside of RVM and use the system installation if it is found.  Otherwise, the user can specify which version of RVM passenger was installed with if it is not the default.

* Command map prefixes for rbenv are automatically added now

# 0.0.4 (26 Mar 2015)

* Bug fixes:
  * rvm:hook task was being called even if it wasn't defined (@betesh, capistrano/passenger#5)

# 0.0.3 (25 Mar 2015)

* Passenger 5 support (@pjkelly, capistrano/passenger#4)

# 0.0.2 (10 Feb 2015)

Bugfixes:
  * If directory doesn't exist, it's created during task (@powertoaster, capistrano/passenger#1)

# 0.0.1 (7 Aug 2014)

Initial release
