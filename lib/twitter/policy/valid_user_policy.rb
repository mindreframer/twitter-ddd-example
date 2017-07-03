module Policy
  # ValidUserPolicy allows to be active on "Twitter"
  #
  # it just makes sure we have a user with a confirmed email
  #
  class ValidUserPolicy
    attr_reader :user
    def initialize(user)
      @user = user
    end

    def valid?
      @user && @user.email_confirmed
    end
  end
end
