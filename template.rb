run "rm -rf README public/index.html public/javascripts/* test app/views/layouts/*"
gem "rspec", :group => [ :development, :test ]
gem "rspec-rails", :group => [ :development, :test ]
gem "factory_girl", :group => [ :development, :test ]
gem "database_cleaner", :group => [ :development, :test ]
gem "simplecov", :group => [ :development, :test ]
gem "devise"
gem "mysql2"

run "bundle install"

rake "db:create", :env => 'development'
rake "db:create", :env => 'test'

application  <<-GENERATORS
config.generators do |g|
  g.template_engine :erb
  g.test_framework  :rspec, :fixture => true, :views => false
  g.integration_tool :rspec, :fixture => true, :views => true
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end
GENERATORS

generate "rspec:install"
generate "devise:install"
inject_into_file 'spec/spec_helper.rb', "\nrequire 'factory_girl'", :after => "require 'rspec/rails'"

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

puts "SUCCESS!"