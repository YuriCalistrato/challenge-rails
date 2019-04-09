# Controller Tests
require 'rails_helper'
require 'database_cleaner'
require 'json'

describe BatchesController do

    it "POST Batchs#create" do
        post :create, params: { purchase_channel: "Canal Um" }
        expect(response).to have_http_status 201
    end

    it "GET Batchs#produce" do
        DatabaseCleaner.clean_with(:truncation)
        # Object Init and Save
        order = create(:order, purchase_channel: "Teste")
        batch = create(:batch, ref: "BR-999", purchase_channel: "Teste")
        # Retrieve after Creation
        get :produce, params: { ref: "BR-999" }

        prod = Order.production.first
        expect( prod.to_json ).to be_json_eql(JSON.parse(response.body)[0].to_json)
    end

    it "GET Batchs#close" do
        DatabaseCleaner.clean_with(:truncation)
        # Object Init and Save
        order = create(:order, purchase_channel: "Teste")
        batch = create(:batch, ref: "BR-999", purchase_channel: "Teste")
        # Retrieve after Creation
        get :produce, params: { ref: "BR-999" }
        get :close, params: { ref: "BR-999" }

        prod = Order.closing.first
        expect( prod.to_json ).to be_json_eql(JSON.parse(response.body)[0].to_json)
    end

    it "GET Batchs#deliver" do
        DatabaseCleaner.clean_with(:truncation)
        # Object Init and Save
        order = create(:order, purchase_channel: "Teste", delivery_srvc: "SEDEX")
        batch = create(:batch, ref: "BR-999", purchase_channel: "Teste")
        # Retrieve after Creation
        get :produce, params: { ref: "BR-999" }
        get :close, params: { ref: "BR-999" }
        get :deliver, params: { ref: "BR-999", delivery_srvc: "SEDEX" }

        prod = Order.sent.first
        expect( prod.to_json ).to be_json_eql(JSON.parse(response.body)[0].to_json)
    end

end