module Repo
  # http://www.codedodle.com/2014/12/social-network-friends-database.html
  class Friendship < Sequel::Model(:friendships)
    plugin :enum
    enum :status, Util::Enum::FRIENDSHIP_STATUS

    one_to_one :from_user, foreign_key: :from_id, class_name: 'Repo::User', reciprocal: nil
    one_to_one :to_user, foreign_key: :to_id, class_name: 'Repo::User', reciprocal: nil
  end
end
