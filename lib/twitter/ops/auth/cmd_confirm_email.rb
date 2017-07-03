module Ops
  module Auth
    class CmdConfirmEmail < Util::Command
      class Form < Util::Form
        attr_accessor :token

        def validate
          assert_present :token
          assert_length :token, 20..36
        end
      end

      def call
        return broadcast(:invalid, form.errors) unless form.valid?
        return broadcast(:not_found)            unless user
        confirm_email
        broadcast(:ok)
      end

      private

      def confirm_email
        user.email_confirmed = true
        user.save
      end

      def user
        @user ||= Repo::User.find(confirm_token: form.token)
      end

      def form
        @form ||= Form.new(params)
      end
    end
  end
end
