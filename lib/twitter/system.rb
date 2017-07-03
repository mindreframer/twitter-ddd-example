# System is a high level framework-neutral abstraction for our app.
#
# It allows us to orchestrate top level commands and inspect the state
# of our system by issuing queries.
#
class System
  attr_reader :session
  def initialize
    @session      = Session.new
    @test_handler = TestHandlers::OKHandler.new
  end

  # @example
  #  system.cmd("cmd.auth.signup", {email: "user@example.com", password: "password123", password_confirmation: "password123"})
  #  system.cmd("cmd.auth.login", {email: "user@example.com", password: "password123"})
  def cmd(string, params = {})
    raise "needs to start with 'cmd.'" unless string[0..3] == 'cmd.'
    ops_klass = Ops::Mapping.get(string)
    instance  = ops_klass.new(params, session)
    instance.subscribe(@test_handler) if test_mode?
    instance.call
  end

  # @example
  #  system.qry("qry.user.by_email", {email: "user@example.com"})
  def qry(string, params = {})
    raise "needs to start with 'qry.'" unless string[0..3] == 'qry.'
    ops_klass = Ops::Mapping.get(string)
    instance  = ops_klass.new(params, session)
    instance.call
  end

  # @example
  #  system.with_user(user_instance) do
  #    puts system.qry("qry.user.all_friends").inspect
  #  end
  def with_user(user)
    old_user = @session.current_user
    @session.current_user = user
    begin
      yield
    ensure
      @session.current_user = old_user
    end
  end

  # @example
  #   system.expect_failure(:wrong_password) do
  #     system.cmd("cmd.auth.login", {email: "user2@example.com", password: "invalidpassword"})
  #   end
  def expect_failure(failure_event)
    old_handler = @test_handler
    @test_handler = TestHandlers::FailureHandler.new(failure_event)
    begin
      yield
    ensure
      @test_handler = old_handler
    end
  end

  def current_user
    @session.current_user
  end

  private

  def test_mode?
    Twitter.instance.env == 'test'
  end
end

module TestHandlers
  # TestHandlers::OKHandler raises on any published non-OK event
  #
  class OKHandler
    # trick wisper to send us all events...
    def respond_to?(*_args)
      true
    end

    def method_missing(m, *_args)
      deal_with_event(m.to_s)
    end

    def deal_with_event(event_str)
      return if event_str[0..1] == 'ok' # by convention all events with `ok` at beginning are successful
      raise event_str
    end
  end

  # TestHandlers::FailureHandler raises on any __unexpected__ non-OK event
  #
  class FailureHandler < OKHandler
    def initialize(expected_error)
      @expected_error = expected_error
    end

    def deal_with_event(event_str)
      return if event_str[0..1] == 'ok' # by convention all events with `ok` at beginning are successful
      return if event_str == @expected_error.to_s # ignore expected error
      raise event_str
    end
  end
end
