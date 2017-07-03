module Util
  # Util::Migrator is currently the place for migrations
  #
  # used for quick iteration and convenience
  #
  class Migrator
    include LittleBoxes::Configurable
    dependency :db

    def run
      # http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html
      unless_exists(:users) do
        primary_key :id
        String :name
        String :email
        String :password_digest
        String :confirm_token
        Boolean :email_confirmed, default: false
        DateTime :created_at, nil: false
        DateTime :updated_at, nil: false
        index %i[email], unique: true
        index %i[confirm_token], unique: true
      end

      unless_exists(:posts) do
        primary_key :id
        foreign_key :user_id, :users
        String :content, text: true
        DateTime :created_at, nil: false
        DateTime :updated_at, nil: false
      end

      unless_exists(:friendships) do
        primary_key :id
        foreign_key :from_id, :users
        foreign_key :to_id,   :users
        Integer  :status
        DateTime :created_at, nil: false
        DateTime :updated_at, nil: false
        DateTime :accepted_at
        DateTime :declined_at
        DateTime :blocked_at
        DateTime :deleted_at
        index %i[from_id to_id], unique: true
      end
    end

    def unless_exists(name, &block)
      db.create_table?(name) do
        instance_eval(&block)
      end
    end
  end
end
