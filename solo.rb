file_cache_path "/tmp/chef-solo"
file_backup_path "/tmp/chef-solo/backup"
cache_options({ :path => "/tmp/chef-solo/checksums", :skip_expires => true })

root = File.expand_path(File.dirname(__FILE__))
cookbook_path [root + '/cookbooks', root + '/site-cookbooks']
