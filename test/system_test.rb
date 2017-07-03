require 'test_helper'

describe System do
  describe 'run' do
    let(:system) { System.new }
    it 'allows to execute commands through a common interface' do
      refute system.current_user
      # signup 2 users
      system.cmd('cmd.auth.signup', email: 'user1@example.com', password: 'password123', password_confirmation: 'password123')
      system.cmd('cmd.auth.signup', email: 'user2@example.com', password: 'password456', password_confirmation: 'password456')
      system.cmd('cmd.auth.login', email: 'user1@example.com', password: 'password123')
      assert_equal system.current_user.email, 'user1@example.com'

      # try login with wrong password
      system.expect_failure(:wrong_password) do
        system.cmd('cmd.auth.login', email: 'user2@example.com', password: 'invalidpassword')
      end

      # try login with wrong user
      system.expect_failure(:not_found) do
        system.cmd('cmd.auth.login', email: 'user0@example.com', password: 'invalidpassword')
      end
      assert_equal system.current_user.email, 'user1@example.com'

      # login another user
      system.cmd('cmd.auth.login', email: 'user2@example.com', password: 'password456')
      assert_equal system.current_user.email, 'user2@example.com'
    end
  end
end
