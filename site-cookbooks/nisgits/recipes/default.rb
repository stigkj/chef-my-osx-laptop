package 'zsh'
package 'lesspipe'
package 'gradle'
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

node['rbenv']['user_installs'] = [
  { 'user'    => 'gits',
    'rubies'  => ['1.9.3-p194'],
    'global'  => '1.9.3-p194',
    'gems'    => {
      '1.9.3-p194' => [
        { 'name' => 'git-up' },
        { 'name' => 'bundler' },
        { 'name' => 'berkshelf' },
        { 'name' => 'librarian-puppet' }
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
  #volumes_dir 'WineBottler Combo'
  source 'http://slinkware.com/slink/download.php'
end

# Does not handle having another name for the installer inside the dmg
#dmg_package 'Fitbit' do
#  volumes_dir 'Fitbit-FitbitTracker-v1.8.2.10-2012-04-19'
#  source 'http://cache.fitbit.com/uploader/Install_Fitbit-1.8.2.10.dmg'
#  type 'mpkg'
#end

dmg_package 'Leda-IU-122.327' do
  source 'http://download.jetbrains.com/idea/ideaIU-122.327.dmg'
  destination '/Applications/Development/'
end

zip_app_package 'GitX' do
  source 'http://cloud.github.com/downloads/brotherbard/gitx/GitX%20Nov-17-2010.zip'
  destination '/Applications/Development/'
end

dmg_package 'VirtualBox' do
  source 'http://download.virtualbox.org/virtualbox/4.1.18/VirtualBox-4.1.18-78361-OSX.dmg'
  type 'mpkg'
end

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

# TODO add dotfiles for ack and others, look at a dotfile repo

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
# TODO look at http://babushka.me

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
#   pry
#   jazor

# TODO
# npms:
#   underscore-cli
#   jsonlint

# TODO
# python:
#   pip / virtualenv / mkvirtualenv (http://gillesfabio.com/blog/2011/03/01/rvm-for-pythonistas-virtualenv-for-rubyists)
#   littlechef

include_recipe 'nisgits::hacks'
include_recipe 'nisgits::nos_git_repos'
include_recipe 'nisgits::framework_git_repos'
