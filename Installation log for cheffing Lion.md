Installation log for chef'ed Lion:

1. Install Lion and create regular user
2. Install GCC with https://github.com/kennethreitz/osx-gcc-installer
   * Look at the GUI-less GCC-installer provided by Apple
3. Install rbenv and ruby-build
4. Install ruby 1.9.2-p290 through rbenv install 1.9.2-p290
5. Install chef (gem install)
6. Setup chef-client against Hosted Chef
   - download client.rb and stigkj-validator.pem
   - put these into /etc/chef

Alternatively, run something like this: https://gist.github.com/2919305