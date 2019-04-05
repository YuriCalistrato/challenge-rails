class BatchesController < ApplicationController

    def create
        @batch = Batch.create(params[:purchase_channel])
        json_response(@batch, :created)
    end

    def produce
        @batch = Batch.search(params[:ref])
        @batch.orders.map { |x| x.status == "ready" ? x.nextState : 0 }
        json_response(@batch)
    end

    def close
        @batch = Batch.search(params[:ref])
        @batch.orders.map do |x|
            if( x.delivery_srvc == params[:delivery_srvc]) do
                if x.status == "closing" do
                    x.nextState
                end
            end
        end
        json_response(@batch)
    end

    private

    def url_params
        params.permit(:purchase_channel,:delivery_srvc, :ref)
    end

end
