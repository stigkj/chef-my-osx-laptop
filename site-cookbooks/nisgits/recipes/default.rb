# Tap for installing GUI applications (dmg, pkg, etc.)
homebrew_tap 'phinze/cask'
# Tap with alternative versions of Casks
homebrew_tap 'caskroom/versions'
# Tap for installing binary packages
homebrew_tap 'homebrew/binary'
# Tap for dvm
homebrew_tap 'fnichol/dvm'
# Needs both taps for sitespeed.io
homebrew_tap 'tobli/browsertime'
homebrew_tap 'sitespeedio/sitespeedio'
# Adds searchable descriptions for formulas
homebrew_tap 'telemachus/homebrew-desc'

package 'ack'
# Wrong SHA1 in Homebrew package
package 'agedu'                 # Reports on disk space used, together with the age of these files
package 'atdtool'               # Tool for checking spelling, grammar and style in texts
package 'brew-desc'             # Adds searchable descriptions for formulas
package 'brew-cask'             # Install GUI Mac applications
package 'brew-pip'              # Install python packages through brew pip .... NB! Must link pip into /usr/bin for this to work
package 'direnv'                # A shell extension that loads different environment variables depending on your path
package 'docker'                # Easily create lightweight containers
package 'drip'                  # A faster JVM launcher
package 'dvm'                   # Easily use docker on OS X or other OS's not being able to run docker natively
package 'encfs'                 # Encrypted files through FUSE
package 'exiftool'              # Reads and writes media metadata (http://www.sno.phy.queensu.ca/~phil/exiftool)
package 'fasd'                  # Quickly reference files/folders used on command line (TODO installation in shell)
package 'gecode'
package 'gist'                  # Pastes text into a new gist on gist.github.com
package 'git'                   # Installs a newer version than the one bundled with OS X
package 'git-extras'
package 'git-flow'
package 'groovy'
# TODO fix installation
package 'httpry'
package 'hub'                   # Wrapper for git that makes it easier to work with github.com from command line
package 'jnettop'               # Network traffic visualiser
package 'jq'                    # Lightweight and flexible command-line JSON processor
package 'lesspipe'
package 'mackup'                # Keeps your application settings in sync via Dropbox and linking (https://github.com/lra/mackup)
package 'maven'                 # Maven, the build tool (TODO: install through jenv?)
package 'mmv'
package 'mr'                    # Multiple Repository management tool
# TODO nvm or n - node version managers, ala rvm (https://github.com/creationix/nvm, https://github.com/visionmedia/n)
package 'npm'                   # The node.js package manager, will also install node.js
package 'osxutils'              # Utilities for OS X specific settings, meta-data and information
package 'p7zip'
package 'phantomjs'             # A headless WebKit scriptable with JavaScript, very good for headless website testing
package 'proctools'             # Scans for and sends signals to processes
package 'pstree'                # Show running processes in a hierarchy
package 'pv'                    # Terminal-based tool for monitoring the progress of data through a pipeline
package 'python'
package 'rest-shell'            # Command-line shell for interacting with Spring HATEOAS-compliant REST resources
package 'ruby-build'
package 'sbt'                   # The Scala build tool
package 'sitespeed.io'          # Analyze web sites for problems that makes them load slow in the browser (http://www.sitespeed.io)
package 'socat'                 # A multipurpose network tool
package 'ssldump'
package 'sslscan'
package 'task-spooler'          # Easily queue jobs from the terminal
# TODO use the_platinum_searcher instead? https://github.com/monochromegane/the_platinum_searcher
package 'the_silver_searcher'   # Ag, a very fast code-searching tool, faster than ack
package 'tig'
package 'trash'                 # Moves files/folders to the OS X trash (TODO alias to rm?)
package 'tree'
package 'vcprompt'              # Prints a string describing the current directory's version control state
package 'wget'
package 'zsh'

## TODO check out box.com's sync platform. Use the unlimited personal account from FINN

## TODO convert to use Kitchenplan (http://kitchenplan.github.io/kitchenplan)

## TODO use mackup for sync of application configuration

## TODO
# All git checkouts should get a specific user and email setup with git config

## TODO use an email management service (sanebox.com, mailstrom.co, altomail.com, unroll.me, )
# or a local one: blinkmail (http://www.blinkmailapp.com)

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
# TODO better to set HISTORY env variable in .zshrc instead?
#link "#{ENV['HOME']}/.zsh_history" do
#  to "#{ENV['HOME']}/Dropbox/.zsh_history"
#end
link "#{ENV['HOME']}/.gnupg" do
  to "#{ENV['HOME']}/Dropbox/.gnupg"
end

# Setup gradle configuration
directory "#{ENV['HOME']}/.gradle"
link "#{ENV['HOME']}/.gradle/init.gradle" do
  to "#{ENV['HOME']}/Dropbox/Gradle/init.gradle"
end
link "#{ENV['HOME']}/.gradle/gradle.properties" do
  to "#{ENV['HOME']}/Dropbox/Gradle/gradle.properties"
end

## TODO use prezto instead: (http://blog.jr0cket.co.uk/2013/09/hey-prezto-zsh-for-command-line-heaven.html?m=1)
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

jdk_filename = 'jdk-7u45-macosx-x64.dmg'
bash 'download JDK to chef file cache' do
  code <<-EOH
    echo #{Chef::Config[:file_cache_path]}/#{jdk_filename}
    wget -O #{Chef::Config[:file_cache_path]}/#{jdk_filename} --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u45-b18/#{jdk_filename}"
    EOH
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{jdk_filename}") || ::File.exists?("Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk") }
end
dmg_package 'JDK 7 Update 45' do
  dmg_name 'jdk-7u45-macosx-x64'
  type 'pkg'
  package_id 'com.oracle.jdk7u45'
end

%w{Development Network Media}.each do |dir|
  directory "/Applications/#{dir}" do
    not_if { ::File.exists?("/Applications/#{dir}") }
  end
end

dmg_package 'Google Chrome' do
  dmg_name 'googlechrome'
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg'
  checksum '7daa2dc5c46d9bfb14f1d7ff4b33884325e5e63e694810adc58f14795165c91a'
end

homebrew_cask 'dropbox'

ruby_block 'stop chef run if Dropbox is not setup' do
  block do
    Chef::Application.fatal!('Setup Dropbox before going further', 100)
  end
  not_if { ::File.exists?('/Users/stiklepp/Dropbox') }
end

dmg_package 'handyLock' do
  volumes_dir 'handyLock v1.0.5.01'
  source 'https://s3.amazonaws.com/netputing/handyLock/handyLock+v1.0.5.dmg'
end

homebrew_cask 'cakebrew'
homebrew_cask 'launchrocket'
homebrew_cask 'fantastical'
homebrew_cask 'slate'
# TODO other options instead of slate:
# * http://mjolnir.io
homebrew_cask 'a-better-finder-rename'
homebrew_cask 'onepassword3'
homebrew_cask 'alfred'
homebrew_cask 'sublime-text-dev'
link "#{ENV['HOME']}/Dropbox/bin/subl" do
  to '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
end

# TODO plugins for Sublime
#  - emmet-sublime (Improves HTML & CSS workflow, https://github.com/sergeche/emmet-sublime)
#  - floobits (Cross-editor real-time collaboration)
#  - SublimeXiki (Xiki in the editor, https://github.com/lunixbochs/SublimeXiki)
#  - Tern (JavaScript code completion server, https://github.com/marijnh/tern_for_sublime)
#  - CheckBounce (OS X spell checking https://github.com/phyllisstein/CheckBounce)
#  - Web Inspector (debug javascript in Sublime http://sokolovstas.github.io/SublimeWebInspector)
#  - Run javascript in browser (https://github.com/sindresorhus/sublime-jsrun)

homebrew_cask 'texts'
homebrew_cask 'stay'

dmg_package 'Disk Order' do
  source 'http://likemac.ru/download/disk-order_ub.dmg'
end

homebrew_cask 'freemind'
homebrew_cask 'appcleaner'

# Canon MP760 printer driver
dmg_package 'PrinterDriver_MP760_105102' do
  volumes_dir 'PrinterDriver_MP760'
  source 'http://gdlp01.c-wss.com/gds/7/0100003867/01/mcpd-mac-mp760-10_51_2-ea11.dmg'
  type 'pkg'
  package_id 'jp.co.canon.pkg.MP760-105102'
end

homebrew_cask 'java' do
  subdir 'Development'
end

intellij_name = 'IntelliJ IDEA'
intellij_version = '13'
intellij_url_name = 'ideaIU-'
intellij_url_version = '13.1.1'
intellij_volumes_dir = "#{intellij_name} 13"
dmg_package "#{intellij_name} #{intellij_version}" do
  volumes_dir "#{intellij_volumes_dir}"
  source "http://download.jetbrains.com/idea/#{intellij_url_name}#{intellij_url_version}.dmg"
  destination '/tmp/'
  not_if { ::File.exists?("/Applications/Development/#{intellij_name} #{intellij_url_version}.app") }
end
file "/tmp/#{intellij_name} #{intellij_version}.app/Contents/Info.plist" do
  replace(/-agentlib.*-X/, "-X") if include? "-agentlib:yjpagent"
  not_if { ::File.exists?("/Applications/Development/#{intellij_name} #{intellij_url_version}.app") }
end
ruby_block "move #{intellij_name} #{intellij_version} to /Applications/Development" do
  block do
    FileUtils.mv "/tmp/#{intellij_name} #{intellij_version}.app", "/Applications/Development/#{intellij_name} #{intellij_url_version}.app"
  end
  not_if { ::File.exists?("/Applications/Development/#{intellij_name} #{intellij_url_version}.app") }
end

## TODO IntelliJ plugins
# Gradle Dependencies Helper (http://plugins.jetbrains.com/plugin/7299?pr=idea)
# PegDown doclet renderer (http://plugins.jetbrains.com/plugin/7253)

dmg_package 'RubyMine' do
  source 'http://download-ln.jetbrains.com/ruby/RubyMine-5.4.3.dmg'
  destination '/Applications/Development/'
end

dmg_package 'JD-GUI' do
  volumes_dir 'JD-GUI 0.3.5'
  source 'http://jd.benow.ca/jd-gui/downloads/jd-gui-0.3.5.osx.i686.dmg'
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
# https://github.com/belluzj/cosmic-sans-neue
# http://kkga.github.io/spacegray

zip_app_package 'GitX' do
  source 'https://github.com/downloads/rowanj/gitx/GitX-dev-57.zip'
  destination '/Applications/Development/'
end

zip_app_package 'GitHub' do
  source 'https://central.github.com/mac/latest'
  destination '/Applications/Development/'
end

dmg_package 'VirtualBox' do
  source 'http://download.virtualbox.org/virtualbox/4.3.2/VirtualBox-4.3.2-90405-OSX.dmg'
  type 'pkg'
end

# TODO Use brew cask install vagrant
# TODO install plugins
#  * vagrant-caschier
dmg_package 'Vagrant' do
  source 'https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.2.dmg'
  type 'pkg'
  package_id 'com.vagrant.vagrant'
end

mp_version = '3_878'
remote_file "#{Chef::Config[:file_cache_path]}/Mailplane_#{mp_version}.tbz" do
  source "http://dist.mailplaneapp.com/builds/Mailplane_#{mp_version}.tbz"
  action :create_if_missing
  not_if { ::File.exists?('/Applications/Network/Mailplane 3.app') }
end
bash 'extract Mailplane to /Applications/Network' do
  code <<-EOH
    echo 'extract Mailplane to /Applications/Network'
    tar -C /Applications/Network/ -x -f #{Chef::Config[:file_cache_path]}/Mailplane_#{mp_version}.tbz
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

# TODO use gmvault instead? (http://gmvault.org)
zip_app_package 'CloudPull' do
  source 'http://downloads.goldenhillsoftware.com/cloudpull/CloudPull.zip'
  destination '/Applications/Network/'
end

dmg_package 'Slink' do
  source 'http://slinkware.com/slink/download.php'
  destination '/Applications/Network/'
end

dmg_package 'NZBVortex' do
  source 'http://www.nzbvortex.com/downloads/NZBVortex.dmg'
  destination '/Applications/Network/'
end

# TODO this is a zipped pkg
#dmg_package 'uTorrent' do
#  source 'http://download-new.utorrent.com/endpoint/utmac/os/osx/track/stable/'
#  destination '/Applications/Network/'
#end

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

homebrew_cask 'mplayer-osx-extended' do
  subdir 'Media'
end

homebrew_cask 'mpv' do
  subdir 'Media'
end

homebrew_cask 'miro-video-converter' do
  subdir 'Media'
end

homebrew_cask 'beamer' do
  subdir 'Media'
end
# TODO load license from ~/Dropbox/licenses.txt

dmg_package 'Narrative Uploader' do
  volumes_dir 'Narrative'
  source 'http://dl.getnarrative.com/appcast/installers/NarrativeUploader.dmg'
  destination '/Applications/Media/'
end

dmg_package 'Spotify' do
  source 'http://download.spotify.com/Spotify.dmg'
  destination '/Applications/Media/'
end

dmg_package 'Picturelife' do
  source 'https://s3.amazonaws.com/download.picturelife.com/mac/Picturelife.dmg'
  destination '/Applications/Media/'
end

dmg_package 'Minitube' do
  source 'http://flavio.tordini.org/files/minitube/minitube.dmg'
  destination '/Applications/Media/'
end
# TODO load license from ~/Dropbox/licenses.txt

zip_app_package 'Picturesque' do
  source 'https://paddle-static.s3.amazonaws.com/downloads/software/picturesque.zip'
  destination '/Applications/Media/'
end
# TODO load license from ~/Dropbox/licenses.txt

# TODO backup to cloud (or something)
#   * camlistore (http://camlistore.org)
#   * BitTorrent Sync (http://www.bittorrent.com/sync)
#   * Google Drive
#   * Space Monkey
#   * CrashPlan
#   * JottaCLoud
#   * Rsync.net
#   * http://syncthing.net
#   * http://sparkleshare.org
#   * What to use for photos: Picturelife, Adobe Revel, Flickr or Google Drive/G+ ?

# TODO install:
#   * Bonjour Browser (http://www.tildesoft.com/#BonjourBrowser)
#   * Video players
#     * MPlayer OSX (brew cask install mplayer-osx-extended/mplayerx)
#     * niceplayer (https://code.google.com/p/niceplayer)
#   * Little Snitch (firewall++ http://www.obdev.at/products/littlesnitch/index.html)
#   * Hands Off (monitor/prevent network/disk access https://www.oneperiodic.com/products/handsoff)
#   * http://lokiware.info/Attachment-Tamer
#   * flamingo (IM app supporting XMPP http://flamingo.im)
#   * Turn off local backup
#   * Look at all bought software and in old backups of installed software
#   * resty (curl -L http://github.com/micha/resty/raw/master/resty > resty)
#   * Yeoman (yeoman.io)
#   * App Tamer (slow down or stop apps http://www.stclairsoft.com/AppTamer)
#   * datamash (simple calculation on text files http://www.gnu.org/software/datamash)
#   * Automatic complete-word and list-choices for zsh (https://github.com/hchbaw/auto-fu.zsh)
#   * Zaw (zsh widget that can select from anything http://blog.patshead.com/2013/04/more-powerful-zsh-history-search-using-zaw.html)
#   * zsh-dwim (a do-what-I-mean plugin for zsh)
#   * shstack (peristent stacks of text that can be used in shell scripts https://github.com/oknowton/shstack)
#   * Yoke (run ruby code everywhere http://cziko.github.io/yoke)
#   * PopClip (select text and do many things with it (http://pilotmoon.com/popclip))
#   * Unarchiver (extracts a lot of file formats http://unarchiver.c3.cx/unarchiver)
#   * Play (brew install play)
#   * Scala/sbt (brew install *)
#   * fseventer (shows file system changes graphically http://fernlightning.com/doku.php?id=software%3afseventer%3astart)
#   * na ('next actions', looking up actions from todo.taskpaper files, etc http://brettterpstra.com/projects/na)
#   * Markdown editors/viewers
#     * Haroopad (markdown editor w/live preview++ http://pad.haroopress.com/user.html)
#     * Erato (markdown editor w/live preview http://9muses.se/erato)
#     * Mou (Nice Markdown editor http://mouapp.com)
#     * LightPaper (free kkkkdown editor with preview http://clockworkengine.com/lightpaper-mac)
#   * planter (intended text file --> directory tree with files, http://brettterpstra.com/projects/planter)
#   * qq (archive of files with questions and answers, http://brettterpstra.com/projects/quickquestion)
#   * Lyn (Image browser http://www.lynapp.com)
#   * Picasa (Image browser)
#   * Enable hack to get selection of text in Preview
#   * f-spot (Image browser http://f-spot.org)
#   * darktable (Image processing http://darkspot.org)
#   * How to handle photo syncing between all devices?
#     * http://andreadekker.com/our-digital-photo-albums-how-i-manage-photos/
#     * http://homegrownsw.com/camerasync
#     * http://www.macstories.net/tutorials/my-photo-management-workflow-early-2014
#     * Digital asset management solutions:
#       * http://notredam.org
#       * https://www.phraseanet.com
#       * http://community.southpawtech.com
#     * Get ideas from this: http://www.resourcespace.org
#   * foundapp.com (search across the local machine and cloud services like gmail, dropbox, evernote, etc)
#   * CatchApp (catch up with everything https://getcatchapp.com/hojoki)
#   * Send to Kindle
#   * MacCleanse 4 (http://www.koingosw.com/downloads/getmirrorfile.php?path=%2Fdownloads%2Fmacintosh%2Fmac_cleanse.dmg)
#   * Timing of application usage:
#     * http://timingapp.com
#     * http://timetrack.bloop.info
#     * http://www.timecamp.com/en/tour-desktop
#     * http://manytricks.com/timesink
#     * https://github.com/gurgeh/selfspy
#     * http://www.activetimer.com
#     * http://www.slifelabs.com
#     * https://www.rescuetime.com
#   * Permute (try out this media converter vs Miro Video Converter http://www.fuelcollective.com/permute)
#   * Finder replacement
#     * Forklift (http://www.binarynights.com/forklift)
#     * Path Finder
#     * Fast Commander (http://osx-fastcommander.appspot.com)
#     * Disk Order (http://www.likemac.ru/english)
#   * Kindle for Mac
#   * Repo manager for git (https://github.com/robertwahler/repo_manager)
#   * gcalcli Chttps://github.com/insanum/gcalcli)
#   * CloudApp (file sharing http://getcloudapp.com also in App Store)
#     * install cli too
#     * gifify was also interesting (mov -> gif -> cloud, on github), is placed in ~/Dropbox/bin
#   * Synergy (synergy-foss.org)
#   * HouseMD (jvm diagnosing tool ala BTrace, install through jenvjjkkjkkj https://github.com/CSUG/HouseMD)
#   * Java (1.6, 1.7, 1.8) with source
#     * Use brew cask install java6/java7/java8
#   * Shortcat (http://updates.shortcatapp.com/v0.3.6/Shortcat.app.zip)
#   * Prey (preyproject.com) for tracking devices (phones, computers, etc)
#   * localtunnel (expose local web server on internet https://github.com/progrium/localtunnel)
#   * Little Snitch (application firewall http://www.obdev.at/products/littlesnitch/index.html)
#   * git-sweep (remove remote branches merged into master https://github.com/arc90/git-sweep)
#   * git-spark (show git graphs as sparklines https://github.com/kablamo/git-spark)
#   * maid (cleans up files, Hazel for hackers)
#   * httpie (command line http client)
#   * profanity (command line xmpp client http://www.profanity.im)
#   * godiff (a file/directory diff-like comparision tool with HTML output https://github.com/spcau/godiff)
#   * setup environment variables in /etc/launchd.conf (look at http://apple.stackexchange.com/questions/64916/defining-environment-variables-with-launchd-launchctl/64917#64917)
#   * brunch (a lightweight approach to building HTML5 applications, http://brunch.io)
#   * deployd (Easy API development: http://deployd.com)
#   * pup (DataDog's statsd server in development mode, http://www.datadoghq.com/2012/08/easy-app-metrics-with-pup)
#   * HoRNDIS: USB tethering driver for Mac OS X (http://joshuawise.com/horndis)
#   * Choosy (choose which browser to open a link in at "runtime")
#   * Postgres.app (http://postgresapp.com)
#   * goreplace (search/replace written in go https://github.com/piranha/goreplace)
#   * boom (http load generator, ala ApacheBench https://github.com/rakyll/boom)
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
#   * SixtyFour (memory optimizer http://getsixtyfour.com)
#   * ssh-chain (easy ssh chaining https://github.com/ryancdotorg/ssh-chain)
#   * Infinit (easy and free file sharing using P2P https://www.infinit.io)
#   * Sinus (personal assistant http://raffael.me/sinus)
#   * Quicksand (sync 50 latest changed files to cloud http://www.zibity.com/quicksand.html)
#   * redsocks (transparent socks redirector http://darkk.net.ru/redsocks)
#   * toggle-extra (toggles OSX menu icons on/off https://github.com/adamv/toggle-extra)
#   * GitHub notifier (https://github.com/ctshryock/GithubNotifier, https://github.com/psionides/gitifier)
#   * GitHub cli (https://github.com/myusuf3/octogit)
#   * Create VirtualBox VMs for each IE version (https://github.com/xdissent/ievms)
#   * bunyip (Automate client-side unit testing in real browsers http://ryanseddon.github.com/bunyip)
#   * pagekite (tunneling service for local server https://pagekite.net)
#   * git-playback (visual playback of git commits https://github.com/mmozuras/git-playback)
#   * git-integration (manage integration of master and feature branches http://johnkeeping.github.io/git-integration)
#   * BoxCryptor/encfs (for encrypting of single files https://www.boxcryptor.com)
#   * ControlPlane (change machine setup for each context (home, work, etc) http://www.controlplaneapp.com)
#     or others: http://airportlocation.wordpress.com, http://oomphalot.com/sidekick
#   * codetag (attach tags to development files automatically https://github.com/mk-fg/codetag)
#   * mysql using "bash <(curl -Ls http://git.io/eUx7rg)"
#   * Sequel Pro (nice mysql gui http://www.sequelpro.com)
#   * Paw (great HTTP client for debugging HTTP request, on Paddle: https://www.paddle.com/locker/500361)
#      * License on ~/Dropbox/license.txt
#   * spring boot cli (fast creation of Spring apps http://projects.spring.io/spring-boot/docs/README.html)
#   * PostgreSQL (http://postgresapp.com)
#   * repl (gives a repl for any non-interactive command like git http://defunkt.io/repl)
#   * cheat (command line for printing out cheat sheets http://cheat.errtheblog.com)
#   * pulls/issues (GitHub pull request/issues utilities https://github.com/dotcloud/gordon)
#   * Pinegrow (looks like a good web editor http://pinegrow.com)
#   * sack (better ack/ag/grep https://github.com/sampson-chen/sack)
#   * nice setup of the shell (https://github.com/barryclark/bashstrap)
#   * Google Apps Manager (https://code.google.com/p/google-apps-manager/)
#   * atMonitor (http://www.atpurpose.com/atMonitor)
#   * Inpaint (Easily remove unwanted elements from pictures, have license for v3.0 http://www.theinpaint.com/)
#   * Shortcat ("click" buttons with the keyboard http://shortcatapp.com)
#   * Sidestep (on unknown wireless networks route web traffic through proxy http://chetansurpur.com/projects/sidestep/)
#   * Cloud Mate (control the files in iCloud http://www.rwe-uk.com/app/cloud-mate)
#   * ngrok (expose local http/tcp services to internet https://ngrok.com)
#   * Look at using Middleman for blog (http://middlemanapp.com)
#   * Look at using Hugo for blog (http://hugo.spf13.com)
#   * Maybe use livefyre for blog comments (http://web.livefyre.com/comments)
#   * Use devproxy/pow (https://github.com/myfreeweb/devproxy http://pow.cx)
#   * gost (gist client written in go https://github.com/MaximeD/gost)
#   * hub (makes git work better with github https://hub.github.com)
#   * Bartender (tidy up menu bar apps http://www.macbartender.com)
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
#   * A lot of free fonts (http://www.macappware.com/software/free-fonts https://s3.amazonaws.com/128bittech/free/update/FreeFonts-102updatedfonts.zip)
#   * Nice prompt for backgrounded jobs (http://micah.cowan.name/blog/projects/promptjobs)
#   * QuickLook plugins
#     * https://github.com/sindresorhus/quick-look-plugins
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

Dir.glob("#{ENV['HOME']}/.ssh/*") do |path|
  file path do
    mode '600'
  end if File.file?(path)
  directory path do
    mode '700'
  end if File.directory?(path)
end

link "#{ENV['HOME']}/.gitconfig" do
  to "#{ENV['HOME']}/Dropbox/.gitconfig"
end
link "#{ENV['HOME']}/.gitignore" do
  to "#{ENV['HOME']}/Dropbox/.gitignore"
end
link "#{ENV['HOME']}/.gitattributes" do
  to "#{ENV['HOME']}/Dropbox/.gitattributes"
end

remote_file "#{ENV['HOME']}/Dropbox/bin/git-diffall" do
  source 'https://raw.github.com/thenigan/git-diffall/master/git-diffall'
  action :create_if_missing
end

Dir.glob("#{ENV['HOME']}/Dropbox/bin/*") do |path|
  file path do
    mode '755'
    manage_symlink_source true
  end if File.file?(path)
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
#   lunchy (nice wrapper for launchctl)
#   github_cli (Complete API v3 coverage from command line: https://github.com/peter-murach/github_cli)
#   building (creating Docker container for any app using Heroku Buildpacks https://github.com/centurylinklabs/building)

# TODO
# npms:
#   underscore-cli
#   jsonlint
#   madge             # Module dependency graph for CommonJS and AMD module deps
#   jwalk             # Inspect JSON object trees on the command line
#   buster.js         # A node/browser testing toolkit
#   recess            # Twitter's code quality tool for CSS
#   testem            # A nice test runner for javascript
#   http-console      # HTTP REPL :-) (or https://github.com/mattn/http-gonsole)
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
#   csvkit            # Utility for working with CSV files (https://github.com/onyxfish/csvkit)
#   pluckr            # Another utility for working with CSV files (https://github.com/philadams/pluckr)

include_recipe 'nisgits::hacks'
include_recipe 'nisgits::framework_git_repos'
