# http://asciicasts.com/episodes/275-how-i-test
# http://www.railsonmaui.com/tips/rails/capybara-phantomjs-poltergeist-rspec-rails-tips.html

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara-screenshot/rspec'
require 'resque_spec/scheduler'

# Run codeclimate-test-reporter only in CI
if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include FactoryGirl::Syntax::Methods

  # config.include IntegrationSpecHelper, :type => :request
  config.include Devise::TestHelpers, :type => :controller
  # config.include ControllerMacros, :type => :controller
  config.include ShowMeTheCookies, :type => :feature

  config.include(MailerMacros)
  config.before(:each) { reset_email }

  # http://railscasts.com/episodes/413-fast-tests
  config.filter_run :focus unless ENV["SKIP_RSPEC_FOCUS"].present?
  config.run_all_when_everything_filtered = true
  config.before(:all) { DeferredGarbageCollection.start }
  config.after(:all) { DeferredGarbageCollection.reconsider }

  config.mock_with :rspec do |c|
    c.yield_receiver_to_any_instance_implementation_blocks = true
  end

  config.before do
    ActionMailer::Base.deliveries.clear
  end
end

def page!
  save_and_open_page
end

# Saves page to place specfied at in configuration.
# NOTE: you must pass js: true for the feature definition (or else you'll see that render doesn't exist!)
# call force = true, or set ENV[RENDER_SCREENSHOTS] == 'YES'
def render_page(name, force = false)
  if force || (ENV['RENDER_SCREENSHOTS'] == 'YES')
    path = File.join Rails.application.config.integration_test_render_dir, "#{name}.png"
    page.driver.render(path)
  end
end
