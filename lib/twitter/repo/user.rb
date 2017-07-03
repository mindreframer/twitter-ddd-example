module Repo
  class User < Sequel::Model(:users)
    def password=(password)
      self.password_digest = authenticator.digest_password(password)
    end

    def friends(status = :accepted)
      self.class.filter(id: friend_ids(status))
    end

    private

    def friend_ids(status)
      ids = self.class.db[:friendships]
                .select(:to_id)
                .where(from_id: id, status: status_enum(status))
                .all
                .map { |x| x[:to_id] }
    end

    def status_enum(v)
      Util::Enum::FRIENDSHIP_STATUS[v]
    end

    def authenticator
      Util::Authenticator.new
    end
  end
end
