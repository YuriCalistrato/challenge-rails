# == Schema Information
#
# Table name: batches
#
#  id               :bigint(8)        not null, primary key
#  ref              :string
#  purchase_channel :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

describe Batch, :type => :model do

    context "Basic Operations" do

        before(:all) do
            @batch =        build(:batch)
            @savedBatch =   create(:batch)
        end

        it "valid fields" do
            expect(@batch).to be_valid
        end

        it "invalid fields" do
            batch = build( :batch,
                id: 37,
                ref: 912,
                purchase_channel: "Lojas Americanas"
            )
            expect(batch).not_to be_valid
        end

        it "persist" do
            expect(@batch.save).to be true
        end

        it "query" do
            expect(Batch.first).not_to be nil
        end

    end

    context "Batch with Orders" do
        before(:all) do
            @order1 = create(:order,purchase_channel: "Magazine Luiza", value: "4.00")
            @order2 = create(:order,purchase_channel: "Magazine Luiza", value: "4.50")
            @order3 = create(:order,purchase_channel: "Magazine Luiza", value: "6.50")
        end

        it "create" do
            @batch = create(:batch, purchase_channel: "Magazine Luiza", ref:"BR01")
            expect(@batch.orders).to include (@order1 && @order2 && @order3)
        end
    end
end
