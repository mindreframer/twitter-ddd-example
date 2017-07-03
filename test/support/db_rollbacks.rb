# setup rollbacks for tests (http://sequel.jeremyevans.net/rdoc/files/doc/testing_rdoc.html)
require 'minitest/hooks/default'
class Minitest::HooksSpec
  def around
    Sequel::Model.db.transaction(:rollback=>:always, :savepoint=>true, :auto_savepoint=>true){super}
  end

  def around_all
    Sequel::Model.db.transaction(:rollback=>:always){super}
  end
end
