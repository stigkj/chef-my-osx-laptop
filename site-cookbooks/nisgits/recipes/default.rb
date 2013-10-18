package 'zsh'
package 'lesspipe'
package 'groovy'
package 'python'
package 'ruby-build'
package 'git'                   # Install a newer version than the one bundled with OS X
package 'git-flow'
package 'git-extras'
package 'tig'
package 'tree'
# TODO fix installation
package 'httpry'
package 'sslscan'
package 'ssldump'
package 'wget'
package 'ack'
package 'gecode'
package 'p7zip'
package 'mmv'
package 'maven'                 # Maven, the build tool (TODO: install through jenv?)
package 'mr'                    # Multiple Repository management tool
package 'jnettop'               # Network traffic visualiser
package 'jq'                    # Lightweight and flexible command-line JSON processor
package 'the_silver_searcher'   # Ag, a very fast code-searching tool, faster than ack
package 'socat'                 # A multipurpose network tool
package 'gist'                  # Pastes text into a new gist on gist.github.com
package 'hub'                   # Wrapper for git that makes it easier to work with github.com from command line
package 'rest-shell'            # Command-line shell for interacting with Spring HATEOAS-compliant REST resources
package 'task-spooler'          # Easily queue jobs from the terminal
package 'trash'                 # Moves files/folders to the OS X trash (TODO alias to rm?)
package 'osxutils'              # Utilities for OS X specific settings, meta-data and information
package 'proctools'             # Scans for and sends signals to processes
package 'encfs'                 # Encrypted files through FUSE
package 'vcprompt'              # Prints a string describing the current directory's version control state
# Wrong SHA1 in Homebrew package
package 'agedu'                 # Reports on disk space used, together with the age of these files
package 'fasd'                  # Quickly reference files/folders used on command line (TODO installation in shell)
package 'brew-pip'              # Install python packages through brew pip .... NB! Must link pip into /usr/bin for this to work
package 'drip'                  # A faster JVM launcher
# TODO nvm or n - node version managers, ala rvm (https://github.com/creationix/nvm, https://github.com/visionmedia/n)
package 'npm'                   # The node.js package manager, will also install node.js
package 'phantomjs'             # A headless WebKit scriptable with JavaScript, very good for headless website testing
package 'sbt'                   # The Scala build tool
package 'pstree'                # Show running processes in a hierarchy
package 'exiftool'              # Reads and writes media metadata (http://www.sno.phy.queensu.ca/~phil/exiftool)

## TODO

#WARNING: The locate database (/var/db/locate.database) does not exist.
#To create the database, run the following command:

#  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# TODO install ruby 1.9.x with rbenv/ruby_build first before running chef-solo
# Use chruby (https://github.com/postmodern/chruby) instead?

git "#{ENV['HOME']}/.rbenv/plugins/rbenv-gem-rehash" do
  repository 'git://github.com/sstephenson/rbenv-gem-rehash.git'
  reference 'master'
  action :checkout
  not_if "test -d #{ENV['HOME']}/.rbenv/plugins/rbenv-gem-rehash"
end

# Setup the gem command configuration
link "#{ENV['HOME']}/.gemrc" do
  to "#{ENV['HOME']}/Dropbox/.gemrc"
end

# TODO do not install docs via gem, make a ~/.gemrc or something

# TODO install these CLI gems through brew gem:
# git-up,
# git-pulls,            # Command line accesss to GitHub pull requests (https://github.com/schacon/git-pulls)
# ghi,                  # Command line accesss to GitHub issues (https://github.com/stephencelis/ghi)
# git-pr,               # Command line accesss to GitHub pull requests (https://metacpan.org/module/App::GitHubPullRequest)
# bundler,
# berkshelf,
# librarian-puppet,
# tres,
# showoff,
# bcat,                 # a pipe-to-browser utility
# pry,                  # a great Ruby REPL (irb on steriods)
# shaft,                # an SSH tunnel assistant for the command line
# tux,                  # an interactive console for Sinatra (https://github.com/cldwalker/tux)
# t,                    # great command line twitter client
# omglog                # very nice realtime git log graph

# TODO install java 1.7 with chef
#include_recipe 'java::oracle'

bash 'setup Homebrew zsh as default shell' do
  code <<-EOH
    echo 'setup Homebrew zsh as default shell'
    echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
    EOH
  not_if { ENV['SHELL'] == '/usr/local/bin/zsh' }
end

# TODO checkout VIM stuff: http://skwp.github.com/dotfiles/

link "#{ENV['HOME']}/.zshrc" do
  to "#{ENV['HOME']}/Dropbox/.zshrc"
end
link "#{ENV['HOME']}/.zsh_history" do
  to "#{ENV['HOME']}/Dropbox/.zsh_history"
end

# Setup gradle configuration
directory "#{ENV['HOME']}/.gradle"
link "#{ENV['HOME']}/.gradle/init.gradle" do
  to "#{ENV['HOME']}/Dropbox/Gradle/init.gradle"
end
link "#{ENV['HOME']}/.gradle/gradle.properties" do
  to "#{ENV['HOME']}/Dropbox/Gradle/gradle.properties"
end

git "#{ENV['HOME']}/.oh-my-zsh" do
  repository 'https://github.com/robbyrussell/oh-my-zsh.git'
  reference 'master'
  action :checkout
  not_if { ::File.exists?("#{ENV['HOME']}/.oh-my-zsh") }
end

directory "#{ENV['HOME']}/.sbt/plugins" do
  recursive true
end
file "#{ENV['HOME']}/.sbt/plugins/build.sbt" do
  content <<-EOH
    addSbtPlugin("com.github.mpeltonen" % "sbt-idea" % "1.4.0")
    EOH
  action :create_if_missing
end

%w{Development Network Media}.each do |dir|
  directory "/Applications/#{dir}"
end

dmg_package 'Google Chrome' do
  dmg_name 'googlechrome'
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg'
  checksum '7daa2dc5c46d9bfb14f1d7ff4b33884325e5e63e694810adc58f14795165c91a'
end

zip_app_package 'Fantastical' do
  source 'http://cdn.flexibits.com/Fantastical_1.3.9.zip'
end

dmg_package 'Dropbox' do
  volumes_dir 'Dropbox Installer'
  source 'http://www.dropbox.com/download?plat=mac'
  checksum 'b4ea620ca22b0517b75753283ceb82326aca8bc3c86212fbf725de6446a96a13'
end

ruby_block 'stop chef run if Dropbox is not setup' do
  block do
    Chef::Application.fatal!('Setup Dropbox before going further', 100)
  end
  not_if { ::File.exists?('/Users/stiklepp/Dropbox') }
end

remote_file "#{Chef::Config[:file_cache_path]}/slate-latest.tar.gz" do
  source 'http://slate.ninjamonkeysoftware.com/versions/slate-latest.tar.gz'
  action :create_if_missing
  not_if { ::File.exists?('/Applications/Slate.app') }
end
bash 'extract slate to /Applications' do
  code <<-EOH
    echo 'extract slate to /Applications'
    tar -C /Applications/ -x -f #{Chef::Config[:file_cache_path]}/slate-latest.tar.gz
    EOH
  not_if { ::File.exists?('/Applications/Slate.app') }
end

dmg_package 'handyLock' do
  volumes_dir 'handyLock v1.0.5.01'
  source 'https://s3.amazonaws.com/netputing/handyLock/handyLock+v1.0.5.dmg'
end

dmg_package 'A Better Finder Rename 9' do
  source 'http://www.publicspace.net/download/ABFRX9.dmg'
  accept_eula true
end

zip_app_package '1Password' do
  source 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac/1Password-3.8.20.zip'
end

zip_app_package 'Alfred 2' do
  source 'http://cachefly.alfredapp.com/Alfred_2.0.3_187.zip'
end

dmg_package 'Sublime Text' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203021.dmg'
end
link "#{ENV['HOME']}/Dropbox/bin/subl" do
  to '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
end

# TODO plugins for Sublime
#  - emmet-sublime (Improves HTML & CSS workflow, https://github.com/sergeche/emmet-sublime)
#  - floobits (Cross-editor real-time collaboration)
#  - SublimeXiki (Xiki in the editor, https://github.com/lunixbochs/SublimeXiki)
#  - Tern (JavaScript code completion server, https://github.com/marijnh/tern_for_sublime)

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

dmg_package 'Disk Order' do
  source 'http://likemac.ru/download/disk-order_ub.dmg'
end

# Canon MP760 printer driver
dmg_package 'PrinterDriver_MP760_105102' do
  volumes_dir 'PrinterDriver_MP760'
  source 'http://gdlp01.c-wss.com/gds/7/0100003867/01/mcpd-mac-mp760-10_51_2-ea11.dmg'
  type 'pkg'
  package_id 'jp.co.canon.pkg.MP760-105102'
end

intellij_name = 'Cardea'
intellij_version = '132.637'
dmg_package "#{intellij_name}-IU-#{intellij_version}" do
  source "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.dmg"
  destination '/Applications/Development/'
end
file "/Applications/Development/#{intellij_name}-IU-#{intellij_version}.app/Contents/Info.plist" do
  replace(/-agentlib.*-X/, "-X") if include? "-agentlib:yjpagent"
end

dmg_package 'RubyMine' do
  source 'http://download-ln.jetbrains.com/ruby/RubyMine-5.4.3.dmg'
  destination '/Applications/Development/'
end

dmg_package 'TriggerToolkit' do
  source 'https://toolkit-installer.s3.amazonaws.com/3.3.54/TriggerToolkit.dmg'
  destination '/Applications/Development/'
end

osx_pkg_package 'Heroku' do
  source 'http://assets.heroku.com/heroku-toolbelt/heroku-toolbelt.pkg'
  package_id 'com.heroku.toolbelt'
end

# TODO install themes for editors, tomorrow-theme or solarized
# https://raw.github.com/tomislav/osx-lion-terminal.app-colors-solarized/master/Solarized%20Dark.terminal

zip_app_package 'GitX' do
  source 'https://github.com/downloads/rowanj/gitx/GitX-dev-57.zip'
  destination '/Applications/Development/'
end

dmg_package 'VirtualBox' do
  source 'http://download.virtualbox.org/virtualbox/4.2.16/VirtualBox-4.2.16-86992-OSX.dmg'
  type 'pkg'
end

# TODO Use brew cask install vagrant
dmg_package 'Vagrant' do
  source 'http://files.vagrantup.com/packages/7ec0ee1d00a916f80b109a298bab08e391945243/Vagrant-1.2.7.dmg'
  type 'pkg'
  package_id 'com.vagrant.vagrant'
end

remote_file "#{Chef::Config[:file_cache_path]}/Mailplane_3_676.tbz" do
  source 'http://dist.mailplaneapp.com/builds/Mailplane_3_676.tbz'
  action :create_if_missing
  not_if { ::File.exists?('/Applications/Network/Mailplane 3.app') }
end
bash 'extract Mailplane to /Applications/Network' do
  code <<-EOH
    echo 'extract Mailplane to /Applications/Network'
    tar -C /Applications/Network/ -x -f #{Chef::Config[:file_cache_path]}/Mailplane_3_676.tbz
    EOH
  not_if { ::File.exists?('/Applications/Network/Mailplane 3.app') }
end

dmg_package 'Charles' do
  volumes_dir 'Charles Proxy v3.7'
  source 'http://www.charlesproxy.com/assets/release/3.7/charles-proxy-3.7-legacy.dmg'
  destination '/Applications/Network/'
  accept_eula true
end

zip_app_package 'AirMail Beta' do
  source 'https://rink.hockeyapp.net/api/2/apps/84be85c3331ee1d222fd7f0b59e41b04?format=zip'
  destination '/Applications/Network/'
end

zip_app_package 'Fluid' do
  source 'http://fluidapp.com/dist/Fluid_1.7.2.zip'
  destination '/Applications/Network/'
end

zip_app_package 'HipChat' do
  source 'http://downloads.hipchat.com.s3.amazonaws.com/mac-beta/HipChat-0.33-01uennzomg01wmg.zip'
  destination '/Applications/Network/'
end

zip_app_package 'CloudPull' do
  source 'http://downloads.goldenhillsoftware.com/cloudpull/CloudPull.zip'
  destination '/Applications/Network/'
end

dmg_package 'Slink' do
  source 'http://slinkware.com/slink/download.php'
  destination '/Applications/Network/'
end

dmg_package 'JollysFastVNC' do
  volumes_dir 'JollysFastVNC.1.44.(1234001).10.7'
  source 'http://www.jinx.de/JollysFastVNC_files/JollysFastVNC.current.dmg'
  destination '/Applications/Network/'
end

zip_app_package 'CoRD' do
  source 'http://downloads.sourceforge.net/project/cord/cord/0.5.7/CoRD_0.5.7.zip?r=http%3A%2F%2Fcord.sourceforge.net%2F&ts=1343992316&use_mirror=dfn'
  destination '/Applications/Network/'
end

zip_app_package 'ScuttlebuttPro' do
  source 'http://gallery.mailchimp.com/108ddaa3514b9271b563155a8/files/ScuttlebuttPro_0.3.1.zip?utm_source=Scuttlebutt+-+The+native+Yammer+client+for+OS+X&utm_campaign=43af7ed14e-Scuttlebutt_Beta_0_3_04_28_2013&utm_medium=email&utm_term=0_28a01c9ab0-43af7ed14e-58271825'
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

dmg_package 'Spotify' do
  source 'http://download.spotify.com/Spotify.dmg'
  destination '/Applications/Media/'
end

dmg_package 'Picturelife' do
  source 'https://s3.amazonaws.com/download.picturelife.com/mac/Picturelife.dmg'
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
#   * Automatic complete-word and list-choices for zsh (https://github.com/hchbaw/auto-fu.zsh)
#   * Yoke (http://cziko.github.io/yoke)
#   * PopClip (select text and do many things with it (http://pilotmoon.com/popclip))
#   * Play (brew install play)
#   * Scala/sbt (brew install *)
#   * Fantastical
#   * na ('next actions', looking up actions from todo.taskpaper files, etc http://brettterpstra.com/projects/na)
#   * Haroopad (markdown editor w/live preview++) http://pad.haroopress.com/user.html)
#   * planter (intended text file --> directory tree with files, http://brettterpstra.com/projects/planter)
#   * qq (archive of files with questions and answers, http://brettterpstra.com/projects/quickquestion)
#   * What to use for photos: Picturelife, Adobe Revel, Flickr or Google Drive?
#   * foundapp.com (search across the local machine and cloud services like gmail, dropbox, evernote, etc)
#   * Send to Kindle
#   * Kindle for Mac
#   * gcalcli Chttps://github.com/insanum/gcalcli)
#   * CloudApp (file sharing http://getcloudapp.com also in App Store)
#     * install cli too
#     * gifify was also interesting (mov -> gif -> cloud, on github), is placed in ~/Dropbox/bin
#   * Mou (Nice Markdown editor http://mouapp.com)
#   * Synergy (synergy-foss.org)
#   * Java (1.6 & 1.7) with source
#     * Download from Developer Connection with adc_download.sh
#   * Shortcat (http://updates.shortcatapp.com/v0.3.6/Shortcat.app.zip)
#   * Prey (preyproject.com) for tracking devices (phones, computers, etc)
#   * localtunnel (expose local web server on internet https://github.com/progrium/localtunnel)
#   * Little Snitch (application firewall http://www.obdev.at/products/littlesnitch/index.html)
#   * git-sweep (remove remote branches merged into master)
#   * maid (cleans up files, Hazel for hackers)
#   * httpie (command line http client)
#   * setup environment variables in /etc/launchd.conf (look at http://apple.stackexchange.com/questions/64916/defining-environment-variables-with-launchd-launchctl/64917#64917)
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
#   * GitHub cli (https://github.com/myusuf3/octogit)
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
#   * Inpaint (Easily remove unwanted elements from pictures, have license for v3.0 http://www.theinpaint.com/)
#   * Shortcat ("click" buttons with the keyboard http://shortcatapp.com)
#   * Sidestep (on unknown wireless networks route web traffic through proxy http://chetansurpur.com/projects/sidestep/)
#   * Cloud Mate (control the files in iCloud http://www.rwe-uk.com/app/cloud-mate)
#   * Mouse and keyboard sharing:
#     * http://www.keyboard-and-mouse-sharing.com
#     * http://avatron.com/apps/air-display
#     * Synergy (http://synergy-foss.org)
#     * Teleport (http://www.abyssoft.com/software/teleport)
#   * Brew plugins
#     * Look at https://github.com/mxcl/homebrew/wiki/External-Commands
#     * Install extra homebrew repositories through homebrew_tap, look at http://community.opscode.com/cookbooks/applications
#     * brew-cask (https://github.com/phinze/homebrew-cask)
#       * Use brew cask alfred link to let Alfred know about apps installed through brew-cask
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
# TODO look at these OS X cookbooks: https://github.com/josh/osx-cookbooks

# TODO dmg_package does not handle a .pkg; do it "manually"
#dmg_package 'Graphviz' do
#  source 'http://www.graphviz.org/pub/graphviz/stable/macos/lion/graphviz-2.28.0.pkg'
#  destination '/Applications/Media/'
#  type "pkg"
#end

link "#{ENV['HOME']}/.ssh" do
  to "#{ENV['HOME']}/Dropbox/.ssh"
end
# Directory used for caching ssh sessions
directory "#{ENV['HOME']}/.ssh/sockets"

Dir.glob("#{ENV['HOME']}/.ssh/*") do |ssh_file|
  fileMode = File.file?(ssh_file) ? '600' : '700'
  file ssh_file do
    mode fileMode
  end
end

link "#{ENV['HOME']}/.gitconfig" do
  to "#{ENV['HOME']}/Dropbox/.gitconfig"
end
link "#{ENV['HOME']}/.gitignore" do
  to "#{ENV['HOME']}/Dropbox/.gitignore"
end

%w{buster buster-lint}.each do |pkg|
  bash "install npm package #{pkg}" do
    code <<-EOH
      npm -g install #{pkg}
      EOH
    not_if {
      %x[npm -g list #{pkg} | grep #{pkg}]
      $?.exitstatus == 0
    }
  end
end

# TODO look at find-gradle (https://github.com/cbeams/shell-scripts)

bash 'install jenv' do
  code <<-EOH
    curl -L -s get.jenv.io | bash
    EOH
  not_if { ::File.exists?("#{ENV['HOME']}/.jenv")}
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
#   replace           # A search&replace tool (https://github.com/harthur/replace)

# TODO
# python: NB! Use brew pip to install these
#   pip / virtualenv / mkvirtualenv (http://gillesfabio.com/blog/2011/03/01/rvm-for-pythonistas-virtualenv-for-rubyists)
#   littlechef        # Use chef-solo with extensions on remote machines
#   mercurial         # Version control system
#   glances           # Curses based monitoring tool
#   mitmproxy         # Interactive console program to inspect and edit network flows on the fly
#   mitmdump          # An improved tcpdump for HTTP

include_recipe 'nisgits::hacks'
include_recipe 'nisgits::framework_git_repos'
