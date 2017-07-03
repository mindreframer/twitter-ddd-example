require 'test_helper'

describe Policy::ValidUserPolicy do
  describe 'user without confirmed email' do
    it 'rejects' do
      user = Repo::User.new
      refute Policy::ValidUserPolicy.new(user).valid?
    end
  end

  describe 'user with confirmed email' do
    it 'allowed' do
      user = Repo::User.new(email_confirmed: true)
      assert Policy::ValidUserPolicy.new(user).valid?
    end
  end
end
