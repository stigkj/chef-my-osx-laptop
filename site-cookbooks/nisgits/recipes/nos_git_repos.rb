nos_code_dir = "#{ENV['HOME']}/dev/nos/code"

directory "#{nos_code_dir}" do
  recursive true
end

git "#{nos_code_dir}/masterdata" do
  repository 'git@vcs.dev.nos.no:nosmd.git'
  reference 'master'
  user node[:nisgits][:user]
  group 'staff'
  action :checkout
  not_if "test -d #{nos_code_dir}/masterdata/.git"
end