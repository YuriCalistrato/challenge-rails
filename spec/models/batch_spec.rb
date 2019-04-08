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

    context "Creation" do

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

    end
end
