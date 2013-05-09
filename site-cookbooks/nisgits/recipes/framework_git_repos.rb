framework_code_dir = "#{ENV['HOME']}/dev/frameworks"

directory "#{framework_code_dir}" do
  recursive true
end

directory "#{framework_code_dir}/swagger"
git "#{framework_code_dir}/swagger/swagger-core" do
  repository 'git://github.com/wordnik/swagger-core.git'
  reference 'master'
  action :checkout
  not_if "test -d #{framework_code_dir}/swagger/swagger-core/.git"
end
git "#{framework_code_dir}/swagger/swagger-ui" do
  repository 'git://github.com/wordnik/swagger-ui.git'
  reference 'master'
  action :checkout
  not_if "test -d #{framework_code_dir}/swagger/swagger-ui/.git"
end

git "#{framework_code_dir}/SplunkJavaLogging" do
  repository 'git://github.com/damiendallimore/SplunkJavaLogging.git'
  reference 'master'
  action :checkout
  not_if "test -d #{framework_code_dir}/SplunkJavaLogging/.git"
end
