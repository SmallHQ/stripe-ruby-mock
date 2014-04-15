module StripeMock
  module RequestHandlers
    module Helpers

      def add_coupon_to_customer(customer, coupon)
        seconds_in_month = 2592000 # pulled from ActiveSupport time helpers (1.month.seconds)
        customer[:discount] = { start: customer[:created], end: nil, coupon: coupon }

        if coupon[:duration] == 'repeating'
          ends_at = customer[:created] + (coupon[:duration_in_months]*seconds_in_month)
          customer[:discount].merge!({ end: ends_at })
        end

        customer
      end

      def add_coupon_to_subscription(subscription, coupon)
        seconds_in_month = 2592000 # pulled from ActiveSupport time helpers (1.month.seconds)
        subscription[:discount] = { start: subscription[:start], end: nil, coupon: coupon }

        if coupon[:duration] == 'repeating'
          ends_at = subscription[:start] + (coupon[:duration_in_months]*seconds_in_month)
          subscription[:discount].merge!({ end: ends_at })
        end

        subscription
      end

    end
  end
end
