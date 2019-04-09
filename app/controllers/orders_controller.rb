class OrdersController < ApplicationController

    def create
        @order = Order.create(order_params)
        if !@order.new_record?
            json_response(@order, :created)
        else
            json_response(@order, :not_created)
        end
    end
  
    def list
        if params[:purchase_channel].present?
            @order = Order.purchaseChnl(params[:purchase_channel])
        else
            @order = Order.purchaseChnl("default")
        end
        json_response(@order)
    end
  
    def status
        if params[:ref].present?
            @order = Order.refSearch(params[:ref])
        elsif params[:client_name].present?
            @order = Order.active.clientSearch(params[:client_name]).order("updated_at DESC")
        else
            @order = nil
        end
        json_response(@order)
    end
    
    private
  
    # --------------------

    def order_params
        params.require(:order).permit(Order.column_names - ["id", "created_at", "updated_at"])
    end
    
  end
  