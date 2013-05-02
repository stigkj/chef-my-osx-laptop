package 'zsh'
package 'lesspipe'
package 'gradle'                # TODO use gvmtool.net instead and also look at find-gradle (https://github.com/cbeams/shell-scripts)
package 'groovy'
package 'ruby-build'
package 'git-flow'
package 'tig'
package 'tree'
# TODO fix installation
#package 'httpry'
package 'sslscan'
package 'ssldump'
package 'ack'
package 'gecode'
package 'p7zip'
package 'mmv'
package 'mr'                    # Multiple Repository management tool
package 'jnettop'               # Network traffic visualiser
package 'jq'                    # Lightweight and flexible command-line JSON processor
package 'the_silver_searcher'   # Ag, a very fast code-searching tool, faster than ack 
package 'socat'                 # A multipurpose network tool
package 'gist'                  # Pastes text into a new gist on gist.github.com
package 'rest-shell'            # Command-line shell for interacting with Spring HATEOAS-compliant REST resources
package 'task-spooler'          # Easily queue jobs from the terminal
package 'trash'                 # Moves files/folders to the OS X trash (TODO alias to rm?)
package 'osxutils'              # Utilities for OS X specific settings, meta-data and information
package 'proctools'             # Scans for and sends signals to processes
package 'encfs'                 # Encrypted files through FUSE
package 'vcprompt'              # Prints a string describing the current directory's version control state
package 'agedu'                 # Reports on disk space used, together with the age of these files
package 'fasd'                  # Quickly reference files/folders used on command line (TODO installation in shell)
package 'brew-pip'              # Install python packages through brew pip .... NB! Must link pip into /usr/bin for this to work
package 'drip'                  # A faster JVM launcher

# Use chruby (https://github.com/postmodern/chruby) instead?
node['rbenv']['user_installs'] = [
  { 'user'    => 'gits',
    'rubies'  => ['1.9.3-p194'],
    'global'  => '1.9.3-p194',
    'gems'    => {
      '1.9.3-p194' => [
        { 'name' => 'git-up' },
        { 'name' => 'github' },               # Command line accesss to GitHub
        { 'name' => 'ghi' },                  # Command line accesss to GitHub Issues
        { 'name' => 'git-pulls' },            # Command line accesss to GitHub pull requests
        { 'name' => 'bundler' },
        { 'name' => 'berkshelf' },
        { 'name' => 'librarian-puppet' },
        { 'name' => 'tres' },
        { 'name' => 'showoff' },
        { 'name' => 'bcat' },                 # a pipe-to-browser utility
        { 'name' => 'pry' },                  # a great Ruby REPL (irb on steriods)
        { 'name' => 'shaft' },                # an SSH tunnel assistant for the command line
        { 'name' => 'tux' },                  # an interactive console for Sinatra (https://github.com/cldwalker/tux)
        { 'name' => 't' },                    # great command line twitter client
        { 'name' => 'omglog' }                # very nice realtime git log graph
      ]
    }
  }
]

#include_recipe 'npm'
include_recipe 'ruby_build'
include_recipe 'rbenv::user'

# TODO need sudo rights
#user node[:nisgits][:user] do
#  shell '/usr/local/bin/zsh'
#  action :manage
#end

# TODO checkout VIM stuff: http://skwp.github.com/dotfiles/

link "#{ENV['HOME']}/.zshrc" do
  to "#{ENV['HOME']}/Dropbox/.zshrc"
end
link "#{ENV['HOME']}/.zsh_history" do
  to "#{ENV['HOME']}/Dropbox/.zsh_history"
end

git "#{ENV['HOME']}/.oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  reference 'master'
  user node[:nisgits][:user]
  group 'staff'
  action :checkout
  not_if "test -d #{ENV['HOME']}/.oh-my-zsh"
end

# For scripts not handled through Homebrew
directory "#{ENV['HOME']}/bin"

dmg_package 'Google Chrome' do
  dmg_name 'googlechrome'
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg'
  checksum '7daa2dc5c46d9bfb14f1d7ff4b33884325e5e63e694810adc58f14795165c91a'
end

dmg_package 'Dropbox' do
  volumes_dir 'Dropbox Installer'
  source 'http://www.dropbox.com/download?plat=mac'
  checksum 'b4ea620ca22b0517b75753283ceb82326aca8bc3c86212fbf725de6446a96a13'
end

zip_app_package '1Password' do
  source 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac/1Password-3.8.20.zip'
end

dmg_package 'Alfred' do
  volumes_dir 'Alfred.app'
  source 'http://cachefly.alfredapp.com/alfred_1.3_249.dmg'
end

dmg_package 'Sublime Text 2' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg'  
end
link "#{ENV['HOME']}/bin/subl" do
  to '/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'
end

# TODO plugins for Sublime
#  - emmet-sublime
#  - floobits (Cross-editor real-time collaboration)

dmg_package 'Texts' do
  source 'http://www.texts.io/Texts-0.13.dmg'
end

zip_app_package 'Stay' do
  source 'http://cordlessdog.com/stay/versions/Stay%201.2.1.zip'
end

dmg_package 'WineBottler' do
  volumes_dir 'WineBottler Combo'
  source 'http://mirrors.nolabelstudios.com/mikesmassivemess/files/WineBottlerCombo_1.2.5.dmg'
end

dmg_package 'Wine' do
  volumes_dir 'WineBottler Combo'
  source 'http://mirrors.nolabelstudios.com/mikesmassivemess/files/WineBottlerCombo_1.2.5.dmg'
end

dmg_package 'Slink' do
  source 'http://slinkware.com/slink/download.php'
end

# Does not handle having another name for the installer inside the dmg
#dmg_package 'Fitbit' do
#  volumes_dir 'Fitbit-FitbitTracker-v1.8.2.10-2012-04-19'
#  source 'http://cache.fitbit.com/uploader/Install_Fitbit-1.8.2.10.dmg'
#  type 'mpkg'
#end

dmg_package 'IntelliJ IDEA 12.1' do
  source 'http://download.jetbrains.com/idea/ideaIU-12.1.dmg'
  destination '/Applications/Development/'
end

# TODO install themes for editors, tomorrow-theme or solarized

zip_app_package 'GitX' do
  source 'http://cloud.github.com/downloads/brotherbard/gitx/GitX%20Nov-17-2010.zip'
  destination '/Applications/Development/'
end

dmg_package 'VirtualBox' do
  source 'http://download.virtualbox.org/virtualbox/4.1.18/VirtualBox-4.1.18-78361-OSX.dmg'
  type 'mpkg'
end

# TODO Use brew cask install vagrant
dmg_package 'Vagrant' do
  source 'http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/Vagrant-1.0.3.dmg'
  type 'pkg'
  package_id 'com.vagrant.vagrant'
end

directory '/Applications/Network'
dmg_package 'JollysFastVNC' do
  volumes_dir 'JollysFastVNC.1.42.(1221501).10.7'
  source 'http://www.jinx.de/JollysFastVNC_files/JollysFastVNC.current.dmg'
  destination '/Applications/Network/'
end

dmg_package 'IPSecuritas' do
  accept_eula true
  source 'http://www.lobotomo.com/products/downloads/IPSecuritas%203.5rc.dmg'
  destination '/Applications/Network/'
end

zip_app_package 'CoRD' do
  source 'http://downloads.sourceforge.net/project/cord/cord/0.5.7/CoRD_0.5.7.zip?r=http%3A%2F%2Fcord.sourceforge.net%2F&ts=1343992316&use_mirror=dfn'
  destination '/Applications/Network/'
end

# TODO Remove extra directory!
#zip_app_package 'sshuttle' do
#  source 'https://github.com/apenwarr/sshuttle/zipball/sshuttle-0.61-macos-bin'
#  destination '/Applications/Network/'
#end

# TODO problems with download because of spaces?
#zip_app_package 'Post Grabber' do
#  source 'https://github.com/downloads/michaeltyson/PostGrabber/Post%20Grabber%201.2.zip'
#  destination '/Applications/Network/'
#end

# TODO pdanet for using wifi on android
# http://www.junefabrics.com/bin/PdaNetA243.pkg

# TODO add dotfiles for ack, tigrc and others, look at a dotfile repo
# for example https://github.com/mathiasbynens/dotfiles

# TODO Move ssh agent password stuff in Keychain Access to their own
# keychain link?

# TODO install groovy 1.8.x to go with gradle plugins development

# TODO Make printing as black/white default

directory '/Applications/Media'
dmg_package 'Spotify' do
  source 'http://download.spotify.com/Spotify.dmg'
  destination '/Applications/Media/'
end

# TODO install:
#   * MPlayer OSX extended (zipapp)
#   * Beyond Compare via WineBottler
#     * alias bc3='open -n -a /Applications/Beyond\ Compare.app'
#     * Remove this key from its Info.plist:
#       <key>WineProgramArguments</key>
#       <string></string>
#   * http://lokiware.info/Attachment-Tamer
#   * Look at all bought software and in old backups of installed software
#   * resty (curl -L http://github.com/micha/resty/raw/master/resty > resty)
#   * Gmvault (http://gmvault.org)
#   * Yeoman (yeoman.io)
#   * Play (brew install play)
#   * Scala/sbt (brew install *)
#   * Fantastical
#   * Send to Kindle
#   * Kindle for Mac
#   * CloudApp (file sharing http://getcloudapp.com also in App Store)
#     * install cli too
#     * gifify was also interesting (mov -> gif -> cloud, on github), is placed in ~/Dropbox/bin
#   * Synergy (synergy-foss.org)
#   * Java (1.6 & 1.7) with source
#     * Download from Developer Connection with adc_download.sh
#   * Shortcat (http://updates.shortcatapp.com/v0.3.6/Shortcat.app.zip)
#   * Prey (preyproject.com) for tracking devices (phones, computers, etc)
#   * localtunnel (expose local web server on internet https://github.com/progrium/localtunnel)
#   * Little Snitch (application firewall http://www.obdev.at/products/littlesnitch/index.html)
#   * MailPlane
#   * git-sweep (remove remote branches merged into master)
#   * maid (cleans up files, Hazel for hackers)
#   * httpie (command line http client)
#   * brunch (a lightweight approach to building HTML5 applications, http://brunch.io)
#   * deployd (Easy API development: http://deployd.com)
#   * pup (DataDog's statsd server in development mode, http://www.datadoghq.com/2012/08/easy-app-metrics-with-pup)
#   * HoRNDIS: USB tethering driver for Mac OS X (http://joshuawise.com/horndis)
#   * Choosy (choose which browser to open a link in at "runtime")
#   * Postgres.app (http://postgresapp.com)
#   * Look at direnv (https://github.com/zimbatm/direnv)
#   * xiproxy (Transparent HTTP proxy for using the xip.io domain https://github.com/rashidkpc/xiproxy)
#   * vimpager (a better pager, replacement for less.sh https://github.com/rkitover/vimpager)
#   * jsonpipe (Converts JSON to to a line-based format) https://github.com/dvxhouse/jsonpipe)
#   * jsawk (awk for JSON https://github.com/micha/jsawk)
#   * selfspy (tool for recording all keystrokes, mouse clicks, window title, etc. https://github.com/gurgeh/selfspy)
#     Must patch:
#     if self.args['showtext']:
#       print row.decrypt_text().**decode('utf-8')**
#     pyobjc-core==**2.5.1**
#     pyobjc==**2.5.1**
#   * Other OS X cookbooks
#     * https://github.com/josh/osx-cookbooks
#   * Mosh (mobile shell, more robust than ssh)
#   * ssh-argv0 (http://news.ycombinator.com/item?id=3012139)
#     This is the content:
#     #!/bin/sh
#     exec ssh "${0##*/}" "$@"
#   * ssh-chain (easy ssh chaining https://github.com/ryancdotorg/ssh-chain)
#   * redsocks (transparent socks redirector http://darkk.net.ru/redsocks)
#   * toggle-extra (toggles OSX menu icons on/off https://github.com/adamv/toggle-extra)
#   * GitHub notifier (https://github.com/ctshryock/GithubNotifier, https://github.com/psionides/gitifier)
#   * slate (window manager https://github.com/jigish/slate)
#   * Create VirtualBox VMs for each IE version (https://github.com/xdissent/ievms)
#   * bunyip (Automate client-side unit testing in real browsers http://ryanseddon.github.com/bunyip)
#   * pagekite (tunneling service for local server https://pagekite.net)
#   * git-playback (visual playback of git commits https://github.com/mmozuras/git-playback)
#   * BoxCryptor/encfs (for encrypting of single files https://www.boxcryptor.com)
#   * ControlPlane (change machine setup for each context (home, work, etc) http://www.controlplaneapp.com)
#     or others: http://airportlocation.wordpress.com, http://oomphalot.com/sidekick
#   * codetag (attach tags to development files automatically https://github.com/mk-fg/codetag)
#   * mysql using "bash <(curl -Ls http://git.io/eUx7rg)"
#   * Sequel Pro (nice mysql gui http://www.sequelpro.com)
#   * PostgreSQL (http://postgresapp.com)
#   * Shortcat ("click" buttons with the keyboard http://shortcatapp.com)
#   * Sidestep (on unknown wireless networks route web traffic through proxy http://chetansurpur.com/projects/sidestep/)
#   * Mouse and keyboard sharing:
#     * http://www.keyboard-and-mouse-sharing.com
#     * http://avatron.com/apps/air-display
#     * Synergy (http://synergy-foss.org)
#     * Teleport (http://www.abyssoft.com/software/teleport)
#   * Brew plugins
#     * Look at https://github.com/mxcl/homebrew/wiki/External-Commands
#     * brew-cask (https://github.com/phinze/homebrew-cask)
#     * brew-pip (https://github.com/josh/brew-pip)
#     * brew-gem (https://github.com/josh/brew-gem)
#     * brew-growl (https://github.com/secondplanet/brew-growl)
#     * brew-more (https://gist.github.com/4622747)
#     * brew-refresh (https://gist.github.com/4622743)
#     * brew-services (https://gist.github.com/4622739)
#   * Magic Launch (launch rules for files http://www.metakine.com/products/magiclaunch)
#   * pass (command line password manager http://zx2c4.com/projects/password-store)
#   * QuickLook plugins
#     * QLColorCode (github/n8grey/QLColorCode)
#     * MMD-QuickLook (github/ttscoff/MMD-QuickLook)
#
# TODO look at http://babushka.me
# TODO improve cookbook by following http://vialstudios.com/guide-authoring-cookbooks.html
# TODO improve cookbook by following http://devopsanywhere.blogspot.no/2012/10/a-year-with-chef.html
# TODO improve cookbook by using http://acrmp.github.com/foodcritic
# TODO test cookbook with Chefspec/minitest-chef-handler (@ github.com/acrmp)

# TODO dmg_package does not handle a .pkg; do it "manually"
#dmg_package 'Graphviz' do
#  source 'http://www.graphviz.org/pub/graphviz/stable/macos/lion/graphviz-2.28.0.pkg'
#  destination '/Applications/Media/'
#  type "pkg"
#end

link "#{ENV['HOME']}/.ssh" do
  to "#{ENV['HOME']}/Dropbox/.ssh"
end
Dir.glob("#{ENV['HOME']}/.ssh/*") do |ssh_file|
  file ssh_file do
    mode '600'
  end
end

link "#{ENV['HOME']}/.gitconfig" do
  to "#{ENV['HOME']}/Dropbox/.gitconfig"
end
link "#{ENV['HOME']}/.gitignore" do
  to "#{ENV['HOME']}/Dropbox/.gitignore"
end

# TODO
# gems:
#   exchanger
#   jazor
#   github_cli (Complete API v3 coverage from command line: https://github.com/peter-murach/github_cli)

# TODO
# npms:
#   underscore-cli
#   jsonlint
#   madge             # Module dependency graph for CommonJS and AMD module deps
#   jwalk             # Inspect JSON object trees on the command line
#   buster.js         # A node/browser testing toolkit
#   recess            # Twitter's code quality tool for CSS
#   testem            # A nice test runner for javascript
#   http-console      # HTTP REPL :-)
#   http-server       # A simple http server
#   nvm               # A node version manager, ala rvm (https://github.com/creationix/nvm)

# TODO
# python: NB! Use brew pip to install these
#   pip / virtualenv / mkvirtualenv (http://gillesfabio.com/blog/2011/03/01/rvm-for-pythonistas-virtualenv-for-rubyists)
#   littlechef
#   mercurial         # Version control system
#   glances           # Curses based monitoring tool

include_recipe 'nisgits::hacks'
include_recipe 'nisgits::nos_git_repos'
include_recipe 'nisgits::framework_git_repos'
