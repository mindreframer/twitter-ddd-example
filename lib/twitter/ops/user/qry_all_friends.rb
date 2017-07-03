module Ops
  module User
    class QryAllFriends < Util::Query
      class Form < Util::Form
        attr_accessor :page, :per_page, :status
        STATUS_MAP = {
          pending: 0,
          accepted: 1,
          declined: 2,
          blocked: 3
        }.freeze

        def validate
          assert_numeric :page if page
          page ||= 1

          assert_numeric :per_page if per_page
          per_page ||= 15

          assert_member :status, %w[pending accepted declined blocked] if status
        end

        def to_params
          {
            page: page,
            per_page: per_page,
            status: STATUS_MAP[status.to_sym]
          }
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
