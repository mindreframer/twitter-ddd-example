module Ops
  module User
    class QryAllFriends < Util::Query
      class Form < Util::Form
        attr_accessor :page, :per_page, :status
        def validate
          assert_numeric :page if page
          self.page ||= 1

          assert_numeric :per_page if per_page
          self.per_page ||= 15

          assert_member :status, %w[pending accepted declined blocked] if status
          self.status ||= 'accepted'
        end

        def to_params
          {
            page: page,
            per_page: per_page,
            status: status_map(status)
          }
        end

        def status_map(status)
          Util::Enum::FRIENDSHIP_STATUS[status.to_sym]
        end
      end

      def call
        raise form_error unless form.valid?
        session.current_user.friends.all
      end

      private

      def form
        @form ||= Form.new(params)
      end
    end
  end
end
