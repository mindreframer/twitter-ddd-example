require 'test_helper'

describe 'slow' do
  def new_user(params)
    Fabricas.create(:user, params)
  end

  it 'transactions 1' do
    user = new_user(password: 'somepass', email: 'a@a.be')
    assert Repo::User.find(email: 'a@a.be')
  end

  it 'transactions 2' do
    user = new_user(password: 'somepass', email: 'a@a.be')
    assert Repo::User.find(email: 'a@a.be')
  end

  it 'transactions 3' do
    user = new_user(password: 'somepass', email: 'a@a.be')
    assert Repo::User.find(email: 'a@a.be')
  end

  it 'transactions 4' do
    5.times do |i|
      new_user(password: 'somepass', email: "a#{i}@a.be")
    end
    assert Repo::User.find(email: 'a1@a.be')
  end
end
