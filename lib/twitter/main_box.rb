# MainBox is the top level DI container
#
class MainBox
  include LittleBoxes::Box
  let(:port) { 80 }
  let(:dbstring) { ':memory:' }
  let(:db) do |box|
    require 'sequel'
    db = Sequel.sqlite(box.dbstring)
    # https://github.com/jeremyevans/sequel/blob/master/lib/sequel/plugins/timestamps.rb#L13
    # Timestamp all model instances using +created_at+ and +updated_at+
    # (called before loading subclasses)
    Sequel::Model.plugin :timestamps

    db
  end

  let(:env) { ENV['RUBY_ENV'] || 'development' }

  letc(:migrator) { Util::Migrator.new }
end
