# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'showterm.io'
set :repo_url, 'git@github.com:gtridev/showterm.io.git'

# Default branch is :master
set :branch, ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
ask :branch, ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call if %w{production}.include?(ARGV.first) 

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/vagrant/#{fetch(:application)}"

set :user, 'vagrant'
set :ssh_options, {
  user: 'vagrant',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  port: 22,
  auth_methods: %w(publickey)
}

set :hipchat_token, '75be7130a00387f93faedcab1144f1'
set :hipchat_room_name, 'ansibletest'
# set :hipchat_options, {
#   :api_version  => "v2" # Set "v2" to send messages with API v2
# }
set :hipchat_announce, true # notify users
set :hipchat_color, 'yellow' #normal message color
set :hipchat_success_color, 'green' #finished deployment message color
set :hipchat_failed_color, 'red' #cancelled deployment message color
set :hipchat_message_format, 'html'

# Set New Relic user to git user name if it's set
# `git config user.name`.strip.tap do |gituser|
#   set :newrelic_user, gituser unless gituser.empty?
# end

set :log_level, :debug
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/templates public/assets vendor/assets } # default: []
set :keep_releases, 3 # default: 5
set :rvm_ruby_version, '2.1.1'


# set :bundle_bins, fetch(:bundle_bins, []).concat(%w{ hutch unicorn })

set :bundle_binstubs, nil
set :bundle_gemfile, -> { release_path.join('Gemfile') }      # default: nil
set :bundle_path, nil
set :bundle_without, %w{development test darwin}.join(' ')
set :bundle_flags, '--frozen --quiet'                       # default: '--deployment --quiet'
set :bundle_jobs, 2     #This is only available for bundler 1.4+

# after "deploy:restart", "newrelic:notice_deployment" if %w{production}.include?(ARGV.first)