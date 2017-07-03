module Ops
  module User
    class CmdSendFriendshipRequest < Util::Command
      class Form < Util::Form
        attr_accessor :to
        def validate
          assert_present :to
          assert_numeric :to
        end
      end

      def call
        return broadcast(:invalid_form, form.errors) unless form.valid?
        return broadcast(:not_found)                 unless to_user
        create_request
        broadcast(:ok)
      end

      private

      def create_request
        transaction do
          Repo::Friendship.create(status: :pending, from_id: current_user_id, to_id: to_user.id)
          Repo::Friendship.create(status: :pending, from_id: to_user.id, to_id: current_user_id)
        end
      end

      def form
        @form ||= Form.new(params)
      end

      def to_user
        @to_user ||= Repo::User.find(id: form.to)
      end

      def current_user_id
        session.current_user.id
      end
    end
  end
end
