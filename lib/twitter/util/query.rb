module Util
  # Util::Query contains common logic for queries
  #
  # while being very similar to `Util::Command`,
  # it might evolve into very different direction later
  #
  class Query
    include Wisper::Publisher

    def self.call(*args)
      new(*args).call
    end

    attr_reader :params, :session

    def initialize(params, session = Session.new)
      @params  = params
      @session = session
    end

    private

    def form_error
      Util::Error::FormError.new(form.errors)
    end
  end
end
