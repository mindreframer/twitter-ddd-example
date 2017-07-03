module Util
  # Util::Authenticator holds logic for authentication
  #
  # this removes some clutter from the User model
  #
  class Authenticator
    def authenticate(user, password)
      BCrypt::Password.new(user.password_digest) == password
    end

    def digest_password(password)
      BCrypt::Password.create(password, cost: crypt_cost).to_s
    end

    private

    def crypt_cost
      ENV['RUBY_ENV'] == 'test' ? 1 : 3
    end
  end
end
