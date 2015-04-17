require 'support/utilities'
require 'simplecov'
require 'capybara/rspec'
require 'features_helper'

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random

  Kernel.srand config.seed

  config.include FeaturesHelper, type: :feature
end
