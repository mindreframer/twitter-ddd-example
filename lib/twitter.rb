### 3rd party
require 'little_boxes'
require 'bcrypt'
require 'wisper'
require 'scrivener'

### dev
require 'pry'

### setup lazy-loading
require 'active_support'
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths << File.expand_path('../twitter', __FILE__)

module Twitter
  def self.instance
    @instance ||= migrated
  end

  def self.box
    MainBox.new
  end

  def self.migrated
    box.tap do |b|
      b.migrator.run
    end
  end
end
