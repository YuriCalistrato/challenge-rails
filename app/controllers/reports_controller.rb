class ReportsController < ApplicationController
    def index
        @report = Order.group(:purchase_channel).pluck("sum(orders.value), count(*)")
        json_respond(@report)
    end

    private

    def url_params
        params.permit(:purchase_channel)
    end
end
