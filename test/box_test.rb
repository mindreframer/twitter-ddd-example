require 'test_helper'

describe 'MainBox' do
  let(:box) do
    MainBox.new
  end
  it {
    assert_equal box.port, 80
    box.db
    box.migrator.run
    assert box.db.tables.include?(:users)
  }
end
