module Util
  # Util::Command holds some common logic for all commands
  #
  class Command
    include Wisper::Publisher

    def self.call(*args)
      new(*args).call
    end

    attr_reader :params, :session

    def initialize(params, session = Session.new)
      @params  = params
      @session = session
    end

    def transaction
      Sequel::Model.db.transaction do
        yield
      end
    end
  end
end
