require 'test_helper'

describe "Login flows" do
  let(:system) { System.new }
  before(:all) do
    # signup 2 users
    system.cmd('cmd.auth.signup', email: 'user1@example.com', password: 'password123', password_confirmation: 'password123')
    system.cmd('cmd.auth.signup', email: 'user2@example.com', password: 'password456', password_confirmation: 'password456')
  end

  it 'login as user1 works' do
    system.cmd('cmd.auth.login', email: 'user1@example.com', password: 'password123')
    assert_equal system.current_user.email, 'user1@example.com'
  end

  it 'login as user2 works' do
    system.cmd('cmd.auth.login', email: 'user2@example.com', password: 'password456')
    assert_equal system.current_user.email, 'user2@example.com'
  end

  it 'login with wrong password fails' do
    system.expect_failure(:wrong_password) do
      system.cmd('cmd.auth.login', email: 'user2@example.com', password: 'invalidpassword')
    end
  end

  it 'login with wrong user fails' do
    system.expect_failure(:not_found) do
      system.cmd('cmd.auth.login', email: 'user0@example.com', password: 'invalidpassword')
    end
  end
end
