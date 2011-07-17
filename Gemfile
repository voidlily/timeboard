source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'therubyracer'

# Asset template engines
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'rubycas-client'
gem 'rubycas-client-rails', :git => "git://github.com/zuk/rubycas-client-rails.git"

gem 'jquery-rails'

gem 'email_validation'
gem 'holidays'
gem 'whenever'

gem 'rubycas-client'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
end

group :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'email_spec'
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails', '~> 1.0.1'
end

group :production do
  gem 'mysql'
end
