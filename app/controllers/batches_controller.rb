class BatchesController < ApplicationController

    def create
        @batch = Batch.create(purchase_channel: params[:purchase_channel])
        if !@batch.new_record?
            json_response(@batch,  :created)
        else
            json_response(@batch,  :not_created)
        end
    end

    def produce
        @batch = Batch.search(params[:ref]).first
        changeFromState("ready")
    end

    def close
        @batch = Batch.search(params[:ref]).first
        changeFromState("production")
    end

    def deliver
        @batch = Batch.search(params[:ref]).first
        changeAndSend("closing",params[:delivery_srvc])
    end

    private

    def changeFromState(env)
        if @batch.present?
            @batch.orders.each do |x|
                if x.status == env
                    x.nextState
                end
            end
            json_response(@batch.orders)
        else
            json_response(:not_found )
        end
    end

    def changeAndSend(env,dserv)
        if @batch.present?
            @batch.orders.each do |x|
                if x.status == env && x.delivery_srvc == dserv
                    x.nextState
                end
            end
            json_response(@batch.orders)
        else
            json_response(:not_found )
        end
    end

    def url_params
        params.permit(:purchase_channel,:delivery_srvc, :ref)
    end

end
