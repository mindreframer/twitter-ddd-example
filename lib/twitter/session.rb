# Session is a class that represent the execution context
#
# Basically a placeholder for the relevant minimal set of HTTP-neutral data
# like: current_user, current_company, current_location, current_language, etc
#
class Session
  attr_accessor :current_user
  def initialize(current_user: nil)
    @current_user = current_user
  end
end
