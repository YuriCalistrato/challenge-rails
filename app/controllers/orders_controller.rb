class OrdersController < ApplicationController
    before_action :set_order, only: [:list, :status]


    def create
      @order = Order.create(order_params)
      json_response(@order, :created)
    end
  
    def list
      json_response(@todo)
    end
  
    def status
      json_response(@todo)
    end
  
    
    private
  
    # --------------------

    def order_params
      params.require(:order).permit(Order.column_names - ["created_at", "updated_at"])
    end

    def set_order
        case
        when params[:purchase_channel]
            @todo = Todo.where(purchase_channel: params[:purchase_channel])
        when params[:ref]
            @todo = Todo.where(ref: params[:ref])
        when params[:client_name]
            query = "SELECT * FROM order ORDER BY updated_at DESC limit 10 OFFSET"+(offset*10).to_s
            @todo = Order.find_by_sql(query)
        else
            @todo = Todo.find(params[:id])
        end
    end

    # URL ----------------
    def url_params
        params.permit(:offset)
    end
  
    def offset
      if url_params.present?
        params[:offset].to_i >= 0 ? params[:offset].to_i : 0
      else
        params[:offset].to_i
      end
    end
    
  end
  