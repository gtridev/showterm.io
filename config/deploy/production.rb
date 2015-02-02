set :rails_env, (fetch(:rails_env) || fetch(:stage))

role :db, '192.168.33.12.', :primary => true
server '192.168.33.12', user: 'vagrant', roles: %w{web app worker}

puts "\e[41m \e[1;37m #{fetch(:branch).upcase} in #{fetch(:rails_env).upcase} \e[0m \e[0m"