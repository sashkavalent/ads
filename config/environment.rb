# Load the rails application
require File.expand_path('../application', __FILE__)

app_env_variables = File.join(Rails.root, 'config', 'app_env_variables.rb')
load(app_env_variables) if File.exists?(app_env_variables)

# Initialize the rails application
Ads::Application.initialize!
