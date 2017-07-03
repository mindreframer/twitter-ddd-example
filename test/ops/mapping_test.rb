require 'test_helper'

describe Ops::Mapping do
  it {
    Ops::Mapping::MAP.each do |k, _v|
      Ops::Mapping.get(k)
    end
  }
end
