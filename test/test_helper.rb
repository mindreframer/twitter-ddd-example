$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

$VERBOSE        = false
ENV['RUBY_ENV'] = 'test'

require 'twitter'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'wisper/minitest/assertions'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# support
require 'fabricas'
require_relative 'support/patch_fabricas'
require_relative 'support/factories'
require_relative 'support/db_rollbacks'

# make sure we have a prepared db
Twitter.instance
