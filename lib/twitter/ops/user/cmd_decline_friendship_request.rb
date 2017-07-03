module Ops
  module User
    class CmdDeclineFriendshipRequest < Util::Command
      class Form < Util::Form
        attr_accessor :from
        def validate
          assert_present :from
          assert_numeric :from
        end
      end

      def call
        return broadcast(:unauthorized)              unless authorized?
        return broadcast(:invalid_form, form.errors) unless form.valid?
        return broadcast(:not_found)                 unless from_user
        return broadcast(:friendship_invalid)        unless friendship
        decline_friendship
        broadcast(:ok)
      end

      private

      def decline_friendship
        leg1 = Repo::Friendship.find(status: 0, from_id: from_user.id, to_id: current_user_id)
        leg2 = Repo::Friendship.find(status: 0, from_id: current_user_id, to_id: from_user.id)
        transaction do
          leg1.status = :declined
          leg2.status = :declined
          leg1.save
          leg2.save
        end
      end

      def authorized?
        policy.valid?
      end

      def policy
        @policy ||= Policy::ValidUserPolicy.new(session.current_user)
      end

      def friendship
        @friendship ||= Repo::Friendship.find(status: 0, from_id: from_user.id, to_id: current_user_id)
      end

      def form
        @form ||= Form.new(params)
      end

      def from_user
        @from_user ||= Repo::User.find(id: form.from)
      end

      def current_user_id
        session.current_user.id
      end
    end
  end
end
