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

    context 'Creation' do
        it "With valid fields" do
            order = Order.new(
                ref: "BR40812",
                purchase_channel: "Lojas Americanas",
                client_name: "Yudi PlayStation",
                address: "Sampa em algum lugar",
                delivery_srvc: "SEDEX",
                value: "R$ 523,00",
                line_items: "VideoGames"
            )
            expect(order).to be_valid
        end

        it "Without valid fields" do
            order = Order.new({
                id: 2,
                ref: 4,
                purchase_channel: 1,
                client_name: 123,
                address: 1235415,
                delivery_srvc: 123,
                value: 123,
                line_items: "VideoGames"
            })
            expect(order).not_to be_valid
        end
    end

end
