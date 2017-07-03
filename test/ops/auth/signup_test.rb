require 'test_helper'

describe Ops::Auth::CmdSignup do
  let(:described_class) { Ops::Auth::CmdSignup }

  it 'invalid form input' do
    params = { email: 'a', password: 'b', password_confirmation: 'c' }
    cmd = described_class.new(params)
    assert_broadcast(:invalid) { cmd.call }
  end

  it 'valid form input' do
    params = {
      email: 'a@a.com',
      password: 'somepass123',
      password_confirmation: 'somepass123'
    }
    cmd = described_class.new(params)
    assert_broadcast(:ok) { cmd.call }
  end
end
