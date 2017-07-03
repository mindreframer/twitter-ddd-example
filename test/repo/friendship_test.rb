require 'test_helper'

describe 'Repo::Friendship' do
  it {
    # a = Repo::Friendship.new(status: :pending)
    # u = Repo::User.new
    # u.save
    # a.save

    # a.user_one_id = u.id
    # a.save

    # aa = Repo::Friendship.find(id: a.id)
    # assert_equal aa.user_one_id, u.id
  }

  it 'also works' do
    user1 = Repo::User.create(email: 'user1@a.com')
    user2 = Repo::User.create(email: 'user2@a.com')
    user3 = Repo::User.create(email: 'user3@a.com')
    Repo::Friendship.create(status: :accepted, from_id: user1.id, to_id: user2.id)
    Repo::Friendship.create(status: :accepted, from_id: user1.id, to_id: user3.id)
    assert_equal user1.friends.map(&:id), [user2, user3].map(&:id)

    # assert_equal user3.friends.map(&:id), [user1].map(&:id)
  end
end
