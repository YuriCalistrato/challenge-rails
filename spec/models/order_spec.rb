# == Schema Information
#
# Table name: orders
#
#  id               :bigint(8)        not null, primary key
#  ref              :string
#  purchase_channel :string
#  client_name      :string
#  address          :string
#  delivery_srvc    :string
#  value            :float
#  line_items       :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  batch_id         :bigint(8)
#
require 'rails_helper'

describe Order, :type => :model do

    it "Tool Scoop for report" do
        order = create(:order, value: 1)
        order2 = create(:order,value: 2)
        order3 = create(:order,value: 3)
        expect(Order.total).to be > 5
    end

    context 'Basic Operations' do

        before(:all) do
            @order = build(:order)
        end

        it "valid fields" do
            expect(@order).to be_valid
        end

        it "invalid fields" do
            order2 = build(:order, 
                id: 2,
                ref:4,
                purchase_channel: 1,
                client_name: 123,
                address: 1235415,
                delivery_srvc: 123,
                value: 123,
                line_items: "VideoGames"
            )
            expect(order2).not_to be_valid
        end

        it "persist" do
            expect(@order.save).to be true
        end

        it "query" do
            order = create(:order)
            expect(Order.first).not_to be nil
        end
    end

    context "State Scopes" do

        before(:all) do
            @order = create(:order)
        end

        it "active" do
            # Before(:all) has instanced one Active.
            expect(Order.active).not_to be nil
        end

        it "ready" do
            order = create(:order, status: "ready")
            expect(Order.ready).not_to be nil
        end

        it "production" do
            order = create(:order, status: "production")
            expect(Order.production).not_to be nil
        end

        it "closing" do
            order = create(:order, status: "closing")
            expect(Order.closing).not_to be nil
        end

        it "sent" do
            order = create(:order, status: "sent")
            expect(Order.sent).not_to be nil
        end

    end
    context "Conditional Scopes" do
        it "Purchase Channel Scope" do
            order = create(:order, purchase_channel:"Amazon")
            expect(Order.purchaseChnl("Amazon")).to include(order)
        end

        it "Delivery Service Scope" do
            order = create(:order, delivery_srvc: "Correios")
            expect(Order.deliverySrvc("Correios")).to include(order)
        end

        it "Production Line Scope" do
            order = create(:order, line_items: "Automóveis")
            expect(Order.line("Automóveis")).to include(order)
        end

        it "Ref Search Scope" do
            order = create(:order, ref: "REF1001")
            expect(Order.refSearch("REF1001")).to include(order)
        end

        it "Client Search Scope" do
            order = create(:order, client_name: "Yuri Calistrato")
            expect(Order.clientSearch("Yuri Calistrato")).to include(order)
        end
    end

    it "Def for State Flow" do
        order = create(:order, status: "ready")
        order.nextState
        expect(Order.production).to include(order)
    end

end
