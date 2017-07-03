module Ops
  module Auth
    class CmdLogin < Util::Command
      class Form < Util::Form
        attr_accessor :password
        attr_accessor :email

        def validate
          assert_present :password
          assert_length :password, 3..32
          assert_present :email
          assert_email :email
          assert_length :email, 5..32
        end
      end

      def call
        return broadcast(:invalid_form, form.errors) unless form.valid?
        return broadcast(:not_found)                 unless user
        return broadcast(:wrong_password)            unless password_matches?

        login_as_current_user
        broadcast(:ok, user)
      end

      private

      def login_as_current_user
        session.current_user = user
      end

      def user
        @user ||= Repo::User.find(email: form.email)
      end

      def password_matches?
        authenticator.authenticate(user, form.password)
      end

      def authenticator
        Util::Authenticator.new
      end

      def form
        @form ||= Form.new(params)
      end
    end
  end
end
