module Util
  module Error
    # Util::Error::FormError is an error class for `Util::Form` errors
    #
    class FormError < StandardError
      attr_reader :errors

      def initialize(errors)
        @errors = errors
        super(errors)
      end

      def message
        errors.inspect
      end

      def to_s
        super
      end
    end
  end
end
