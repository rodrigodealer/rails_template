run "rm -rf README public/index.html public/javascripts/* test app/views/layouts/*"

gem "rspec"
gem "rspec-rails"
gem "factory_girl"
gem "database_cleaner"
gem "devise"
gem "mysql2"
gem "simplecov"
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