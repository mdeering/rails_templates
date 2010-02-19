# =========================
# base.rb
# Author: Michael Deering http://mdeering.com
#
# Usage: rails <name app> -m $RAILS_TEMPLATES_PATH/base.rb
# Absolute minimum that goes into every Rails app
# =========================
# TODO: Find out if we have access to the name of the application inside our template
#       without having to rely on the ask function
# TODO: Find a decent resource or guide for rails templates
#       and figure out how to include other templates or modules
# TODO: Look at adding http://github.com/justinfrench/formtastic/tree/master to the base template
# =========================

# =========================
# Initial clean up
# =========================

application_name = Dir.pwd.split('/').last.split('.').first

['public/favicon.ico', 'public/index.html', 'public/javascripts/*'].each do |file|
  puts "Removing #{file}"
  run "rm #{file}"
end

# 99.9% of the time we are going to use MySQL
file 'config/database.yml.sample',
"defaults: &defaults
  adapter:  mysql
  username: root
  password: 
  host: localhost

development:
  <<:       *defaults
  database: #{application_name}

test:
  <<:       *defaults
  database: #{application_name}_test

production:
  <<:       *defaults
  database: #{application_name}
"
file 'config/assets.yml',
"javascripts:
  base:
    - public/javascripts/*.js

stylesheets:
  base:
    - public/stylesheets/*.css
"

# Grab the latest copy of jquery and the jquery form validator
run 'curl -L http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js > public/javascripts/jquery.min.js'
run 'curl -L http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js > public/javascripts/jquery.form.js'
run 'curl -L http://assets.mdeering.com/jquery.validate.pack.js > public/javascripts/jquery.validate.pack.js'

# Start the .gitignore file
file '.gitignore',
%q{.DS_Store
coverage/*
log/*.log
db/*.db
db/*.sqlite3
tmp/**/*
doc/api
doc/app
config/database.yml
}

# now copy over the database template
run 'cp config/database.yml.sample config/database.yml'

gem 'attribute_normalizer'
gem 'authlogic'
gem 'haml'
gem 'jammit'
gem 'searchlogic'
gem 'settingslogic'
gem 'will_paginate'

# Test ENV only
gem 'factory_girl', :env => 'test'
gem 'metric_fu',    :env => 'test'
gem 'rspec',        :env => 'test'
gem 'rspec-rails',  :env => 'test'
gem 'shoulda',      :env => 'test'


# This version of annotate puts the schema at the bottom of the
# files and also leaves out adding the schema version by default
plugin 'annotate_models',      :git => 'git@github.com:mdeering/annotate_models.git'

generate('rspec')