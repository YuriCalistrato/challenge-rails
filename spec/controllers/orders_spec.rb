# Controller Tests
require 'rails_helper'

describe OrdersController do
    it "POST Orders#create" do
        post :create, params: { order: attributes_for(:order) }
        expect(response).to have_http_status 201
    end

    it "GET Orders#list" do
        order = create(:order, purchase_channel: "Magazine Luiza")
        get :list, params: { purchase_channel: "Magazine Luiza" }
        expect(response.body).to include order.to_json
    end

    context "GET Orders#status" do
        before(:all) do
            @order = create(:order, client_name: "Tester", ref: "REF9999" )
        end

        it "Using Ref" do
            get :status, params: { ref: "REF9999" }
            expect(response.body).to include @order.to_json
        end
        
        it "Using Client Name" do
            get :status, params: { client_name: "Tester" }
            expect(response.body).to include @order.to_json
        end
    end

end