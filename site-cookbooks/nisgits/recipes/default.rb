package 'zsh'
package 'lesspipe'
package 'gradle'
package 'groovy'
package 'ruby-build'
package 'git-flow'
package 'tig'

node['rbenv']['user_installs'] = [
  { 'user'    => 'gits',
    'rubies'  => ['1.9.3-p194'],
    'global'  => '1.9.3-p194',
    'gems'    => {
      '1.9.3-p194' => [
        { 'name' => 'git-up' }
      ]
    }
  }
]

#include_recipe 'npm'
include_recipe 'ruby_build'
include_recipe 'rbenv::user'

user node[:nisgits][:user] do
  shell '/usr/local/bin/zsh'
  action :manage
end

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

dmg_package 'Leda-IU-120.305' do
  source 'http://download.jetbrains.com/idea/ideaIU-120.305.dmg'
  destination '/Applications/Development/'
end

zip_app_package 'GitX' do
  source 'http://cloud.github.com/downloads/brotherbard/gitx/GitX%20Nov-17-2010.zip'
  destination '/Applications/Development/'
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


include_recipe 'nisgits::hacks'
include_recipe 'nisgits::nos_git_repos'
