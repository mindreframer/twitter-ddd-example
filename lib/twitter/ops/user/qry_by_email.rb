module Ops
  module User
    class QryByEmail < Util::Query
      class Form < Util::Form
        attr_accessor :email

        def validate
          assert_present :email
          assert_email :email
        end
      end

      def call
        raise form_error unless form.valid?
        Repo::User.find(email: form.email)
      end

      private

      def form
        @form ||= Form.new(params)
      end
    end
  end
end
