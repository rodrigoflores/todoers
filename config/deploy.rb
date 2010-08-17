template = 'rails3'
application = 'app_name'
repository = ''
hosts = %w()

before_restarting_server do
  run "jammit"
end

ssh_opts = '-A'  

user = 'web'
