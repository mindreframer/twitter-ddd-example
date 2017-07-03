module Fabricas
  def self.create(*args)
    r = build(*args)
    r.save
    r
  end
end
