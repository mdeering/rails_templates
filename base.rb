# =========================
# base.rb
# Author: Michael Deering http://mdeering.com
#
# Absolute minimum that goes into every Rails app
# =========================
# TODO: Find out if we have access to the name of the application inside our template
#       without having to rely on the ask function
# TODO: Find a decent resource or guide for rails templates
#       and figure out how to include other templates or modules
# TODO: Add the config file setup for exception notification plugin
# =========================

# FIXME: These functions do not belong here.
def haml!
  run 'haml --rails .'
end

def piston(vendor_directory_name, repository_location)
  run "piston import #{repository_location} vendor/plugins/#{vendor_directory_name}"
end


# =========================
# Initial clean up
# =========================
['public/favicon.ico', 'public/index.html', 'public/javascripts/*'].each do |file|
  run "rm #{file}"
end

# Set up the local git repository
git :init

haml!
capify!

# 99.9% of the time we are going to use MySQL
file 'conf/database.yml.sample',
%q{defaults: &defaults
  adapter:  mysql
  username: username
  password: password
  host: localhost
  encoding: utf8

development:
  <<:       *defaults
  database: application_development

test:
  <<:       *defaults
  database: application_test

production:
  <<:       *defaults
  database: application_development
}

# Grab the latest copy of jquery

# Start the .gitignore file
file '.gitignore',
%q{.DS_Store
coverage/*
log/*.log
db/*.db
db/*.sqlite3
db/schema.rb
tmp/**/*
doc/api
doc/app
config/database.yml
coverage/*
}

gem 'thoughtbot-factory_girl', :lib => 'factory_girl',  :source => 'http://gems.github.com'
gem 'thoughtbot-shoulda',      :lib => 'shoulda',       :source => 'http://gems.github.com'
gem 'mislav-will_paginate',    :lib => 'will_paginate', :source => 'http://gems.github.com'

# This version of annotate puts the scema at the bottom of 
# the file and also leaves out adding the schema version by default
piston 'annotate_models',    'git://github.com/bendycode/annotate_models.git'

# Asset packager don't go anywhere without it!
# Lets also setup the basic config file to work with here also.
piston 'asset_packager',     'git://github.com/sbecker/asset_packager.git'
file 'config/asset_packages.yml',
%q{---
javascripts:
- admin:
  - jquery.min
  - application
  - admin
- public
  - jquery.mon
  - application
  - public
stylesheets:
- admin:
  - admin
- public:
  - application
}

piston 'exception_notifier', 'git://github.com/rails/exception_notification.git'
# TODO: Not even sure what the new exception_notification config file looks like
#       now.  Add it here when you figure it out!

piston 'rspec',              'git://github.com/dchelimsky/rspec.git'
piston 'rspec-rails',        'git://github.com/dchelimsky/rspec-rails.git'
generate("rspec")

