module Ops
  module User
    class CmdDeclineFriendshipRequest < Util::Command
      class Form < Util::Form
        attr_accessor :friend_
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
      def call; end
    end
  end
end
