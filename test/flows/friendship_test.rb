require 'test_helper'

describe "Frienship flows" do
  let(:system) { System.new }
  before(:all){
    system.cmd('cmd.auth.signup', email: 'user1@example.com', password: 'password123', password_confirmation: 'password123')
    system.cmd('cmd.auth.signup', email: 'user2@example.com', password: 'password456', password_confirmation: 'password456')
    system.cmd('cmd.auth.signup', email: 'user3@example.com', password: 'password789', password_confirmation: 'password789')
    user1 = system.qry('qry.user.by_email', email: 'user1@example.com')
    user2 = system.qry('qry.user.by_email', email: 'user2@example.com')
    user3 = system.qry('qry.user.by_email', email: 'user3@example.com')
    system.cmd('cmd.auth.confirm_email', token: user1.confirm_token)
    system.cmd('cmd.auth.confirm_email', token: user2.confirm_token)
    system.cmd('cmd.auth.confirm_email', token: user3.confirm_token)
  }
  describe 'signup + confirm + send friend request + accept friend request' do
    it do
      user1 = system.qry('qry.user.by_email', email: 'user1@example.com')
      user2 = system.qry('qry.user.by_email', email: 'user2@example.com')
      user3 = system.qry('qry.user.by_email', email: 'user3@example.com')
      system.with_user(user1) do
        assert_empty system.qry('qry.user.all_friends')
        system.cmd('cmd.user.send_friendship_request', to: user2.id)
        system.cmd('cmd.user.send_friendship_request', to: user3.id)
        assert_empty system.qry('qry.user.all_friends')
      end

      system.with_user(user2) do
        assert_empty system.qry('qry.user.all_friends')
        system.cmd('cmd.user.accept_friendship_request', from: user1.id)
        assert_equal system.qry('qry.user.all_friends').map(&:id), [user1].map(&:id)
      end

      system.with_user(user1) do
        friends = system.qry('qry.user.all_friends')
        assert_equal friends.map(&:id), [user2].map(&:id)
      end

      system.with_user(user3) do
        assert_empty system.qry('qry.user.all_friends')
        system.cmd('cmd.user.accept_friendship_request', from: user1.id)
        friends = system.qry('qry.user.all_friends')
        assert_equal friends.map(&:id), [user1].map(&:id)
      end

      system.with_user(user1) do
        friends = system.qry('qry.user.all_friends')
        refute_equal friends.map(&:id), [user2].map(&:id)
        assert_equal friends.map(&:id), [user2, user3].map(&:id)
      end
    end
  end

  describe 'declining friendship requests' do
    it do
      user1 = system.qry('qry.user.by_email', email: 'user1@example.com')
      user2 = system.qry('qry.user.by_email', email: 'user2@example.com')
      user3 = system.qry('qry.user.by_email', email: 'user3@example.com')
      system.with_user(user1) do
        assert_empty system.qry('qry.user.all_friends')
        system.cmd('cmd.user.send_friendship_request', to: user2.id)
        system.cmd('cmd.user.send_friendship_request', to: user3.id)
        assert_empty system.qry('qry.user.all_friends')
      end
      system.with_user(user2) do
        assert_empty system.qry('qry.user.all_friends')
        system.cmd('cmd.user.decline_friendship_request',from: user1.id)
        assert_empty system.qry('qry.user.all_friends')
      end
      system.with_user(user3) do
        system.cmd('cmd.user.accept_friendship_request', from: user1.id)
        assert_equal system.qry('qry.user.all_friends').map(&:id), [user1.id]
      end
      system.with_user(user1) do
        assert_equal system.qry('qry.user.all_friends').map(&:id), [user3.id]
      end
    end
  end
end



