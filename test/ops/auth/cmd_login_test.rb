require 'test_helper'

describe Ops::Auth::CmdLogin do
  let(:described_class) { Ops::Auth::CmdLogin }

  it 'fails with invalid form' do
    cmd = described_class.new(email: 'a@a', password: 'somepass')
    assert_broadcast(:invalid_form) { cmd.call }
  end

  it 'fails without valid user' do
    cmd = described_class.new(email: 'i-dont-exist@a.be', password: 'somepass')
    assert_broadcast(:not_found) { cmd.call }
  end

  describe 'works with valid user' do
    before do
      Ops::Auth::CmdSignup.call(email: 'a@a.be', password: 'somepass', password_confirmation: 'somepass')
    end
    it {
      cmd = described_class.new(email: 'a@a.be', password: 'somepass')
      assert_broadcast(:ok) { cmd.call }
    }
  end
end
