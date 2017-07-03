module Ops
  module Auth
    class CmdSignup < Util::Command
      class Form < Util::Form
        attr_accessor :email
        attr_accessor :password
        attr_accessor :password_confirmation

        def validate
          assert_present :email
          assert_email :email
          assert_present :password
          assert_length :password, 3..32
          assert password == password_confirmation, %i[password confirmation_does_not_match]
        end
      end

      def call
        return broadcast(:invalid, form.errors) unless form.valid?
        u = create_user
        broadcast(:ok, u)
      end

      private

      def create_user
        Repo::User.create(user_params)
      end

      def user_params
        form.slice(:email, :password).merge(confirm_token: confirm_token)
      end

      def confirm_token
        Util::UUIDGenerator.new.generate
      end

      def form
        @form ||= Form.new(params)
      end
    end
  end
end
